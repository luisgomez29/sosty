import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:sosty/config/provider/project_provider.dart';
import 'package:sosty/domain/models/project/project_progress.dart';
import 'package:sosty/ui/common/constants/constants.dart';
import 'package:sosty/ui/common/styles/styles.dart';
import 'package:sosty/ui/components/buttons/large_button.dart';
import 'package:sosty/ui/components/cards/custom_card.dart';
import 'package:sosty/ui/components/cards/icon_card.dart';
import 'package:sosty/ui/components/general/content_section.dart';
import 'package:sosty/ui/components/general/custom_rich_text.dart';
import 'package:sosty/ui/components/general/load_data_error.dart';
import 'package:sosty/ui/components/general/loading_indicator.dart';
import 'package:sosty/ui/components/general/section_title.dart';
import 'package:sosty/ui/components/general/timeline.dart';
import 'package:sosty/ui/components/investments/investment_timeline_item.dart';
import 'package:sosty/ui/components/navbar/navbar_detail.dart';
import 'package:sosty/ui/components/projects/project_message.dart';
import 'package:sosty/ui/components/projects/project_weights_bar_chart.dart';
import 'package:sosty/ui/components/projects/project_weights_circular_chart.dart';
import 'package:sosty/ui/config/theme/app_theme.dart';
import 'package:sosty/ui/helpers/formatter_helper.dart';
import 'package:sosty/ui/screens/projects/projects_detail_screen.dart';

class ProjectProgressScreen extends StatefulWidget {
  const ProjectProgressScreen({
    Key? key,
    required this.investmentId,
  }) : super(key: key);

  final String investmentId;

  @override
  _ProjectProgressScreenState createState() => _ProjectProgressScreenState();
}

class _ProjectProgressScreenState extends State<ProjectProgressScreen> {
  Future<ProjectProgress>? futureProjectProgress;

  void _fetchProjectProgress() {
    final projectProvider =
        Provider.of<ProjectProvider>(context, listen: false);
    final response = projectProvider.projectUseCase
        .getProjectProgressInformation(widget.investmentId);
    setState(() {
      futureProjectProgress = response;
    });
  }

  Padding _getProjectInformationItem(String text, String textSpan) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: CustomRichText(
        text: text,
        textSpan: textSpan,
      ),
    );
  }

  Padding _getCardTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(
        top: 10.0,
      ),
      child: Text(
        title,
        style: Styles.headline3,
      ),
    );
  }

  double _getEstimatedGain(
    int amountInvested,
    double projectProfitability,
    String projectDuration,
    DateTime startDate,
    DateTime endDate,
  ) {
    double estimatedGain = 0;
    double monthsProgress = 0;
    int pendingDays = endDate.difference(DateTime.now()).inDays;

    if (pendingDays <= 0) {
      monthsProgress = double.parse(projectDuration);
    } else {
      monthsProgress = DateTime.now().difference(startDate).inDays / 30;
    }

    double profitabilityPercentage = projectProfitability / 100;
    estimatedGain =
        ((profitabilityPercentage / Constants.monthsOfYear) * monthsProgress) *
            amountInvested;
    return estimatedGain;
  }

  @override
  void initState() {
    super.initState();
    _fetchProjectProgress();
  }

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: AppTheme.getSystemUiOverlayStyle(),
      child: Scaffold(
        body: SafeArea(
          child: CustomScrollView(
            slivers: <Widget>[
              const NavbarDetail(),
              SliverToBoxAdapter(
                child: ContentSection(
                  offsetY: 30.0,
                  child: FutureBuilder<ProjectProgress>(
                    future: futureProjectProgress,
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.done) {
                        if (snapshot.hasData) {
                          final ProjectProgress projectProgress =
                              snapshot.data!;
                          final estimatedGain = _getEstimatedGain(
                            projectProgress.amountInvested,
                            projectProgress.projectProfitability,
                            projectProgress.projectDuration,
                            projectProgress.startDate,
                            projectProgress.endDate,
                          );
                          return Column(
                            children: [
                              SectionTitle(
                                title:
                                    "Seguimiento Proyecto # ${projectProgress.projectCode}",
                                subTitle: projectProgress.projectName,
                              ),
                              IconCard(
                                title: FormatterHelper.money(
                                  projectProgress.amountInvested,
                                ),
                                subtitle: 'Inversión Inicial',
                              ),
                              IconCard(
                                title: FormatterHelper.money(
                                  estimatedGain,
                                ),
                                subtitle: 'Ganancia Estimada',
                                icon: Icons.trending_up_sharp,
                              ),
                              IconCard(
                                title: FormatterHelper.money(
                                  estimatedGain +
                                      projectProgress.amountInvested,
                                ),
                                subtitle: 'Valor Actual Estimado',
                              ),
                              CustomCard(
                                child: Column(
                                  children: [
                                    _getCardTitle("Información Proyecto"),
                                    Timeline(
                                      children: [
                                        _getProjectInformationItem(
                                          "Productor",
                                          "${projectProgress.firstName} ${projectProgress.lastName}",
                                        ),
                                        _getProjectInformationItem(
                                          "Lugar",
                                          "${projectProgress.locationState} - ${projectProgress.locationCity ?? ""}",
                                        ),
                                        _getProjectInformationItem(
                                          "Finca",
                                          projectProgress.locationAddress,
                                        ),
                                        _getProjectInformationItem(
                                          "Indicaciones",
                                          projectProgress
                                                  .locationArrivalLIndications ??
                                              "-",
                                        ),
                                        _getProjectInformationItem(
                                          "Fecha Inicio",
                                          FormatterHelper.shortDate(
                                            projectProgress.startDate,
                                          ),
                                        ),
                                        _getProjectInformationItem(
                                          "Fecha Cierre",
                                          FormatterHelper.shortDate(
                                            projectProgress.endDate,
                                          ),
                                        ),
                                      ],
                                      indicators: <Widget>[
                                        Icon(
                                          Icons.perm_identity,
                                          color: Theme.of(context).primaryColor,
                                        ),
                                        const Icon(
                                          Icons.location_pin,
                                          color: Color(0xFF82868B),
                                        ),
                                        Icon(
                                          Icons.home,
                                          color: Theme.of(context).primaryColor,
                                        ),
                                        const Icon(
                                          Icons.accessibility,
                                          color: Color(0xFF82868B),
                                        ),
                                        Icon(
                                          Icons.calendar_month_outlined,
                                          color: Theme.of(context).primaryColor,
                                        ),
                                        const Icon(
                                          Icons.calendar_month_outlined,
                                          color: Colors.deepOrangeAccent,
                                        ),
                                      ],
                                    ),
                                    const SizedBox(
                                      height: 20,
                                    ),
                                    LargeButton(
                                      text: "Ver proyecto",
                                      onPressed: () => Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              ProjectDetailScreen(
                                            projectCode:
                                                projectProgress.projectCode,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              CustomCard(
                                child: ProjectWeightsBarChart(
                                  weights: projectProgress.weightsList,
                                  weightsDates:
                                      projectProgress.weightsDatesList,
                                ),
                              ),
                              CustomCard(
                                child: ProjectWeightsCircularChart(
                                  weights: projectProgress.weights,
                                ),
                              ),
                              SizedBox(
                                width: MediaQuery.of(context).size.width,
                                child: CustomCard(
                                  child: Column(
                                    children: [
                                      _getCardTitle(
                                          "Actualizaciones y \n Documentos"),
                                      (projectProgress.events.isEmpty)
                                          ? const ProjectMessage(
                                              text: "No hay actualizaciones",
                                            )
                                          : Column(
                                              children: [
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                    top: 20.0,
                                                  ),
                                                  child: Text(
                                                    "Haz clic sobre la imagen o archivo para descargarlo",
                                                    style: TextStyle(
                                                      color: Theme.of(context)
                                                          .primaryColor,
                                                    ),
                                                  ),
                                                ),
                                                Timeline(
                                                  lineColor: Theme.of(context)
                                                      .primaryColor
                                                      .withOpacity(0.3),
                                                  lineGap: 0,
                                                  children: List.generate(
                                                    projectProgress
                                                        .events.length,
                                                    (index) =>
                                                        InvestmentsTimelineItem(
                                                      event: projectProgress
                                                          .events[index],
                                                    ),
                                                  ),
                                                  indicators: List.generate(
                                                    projectProgress
                                                        .events.length,
                                                    (index) => Icon(
                                                      Icons.adjust_outlined,
                                                      color: Theme.of(context)
                                                          .primaryColor,
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                    ],
                                  ),
                                ),
                              ),
                              const SizedBox(
                                height: 50,
                              ),
                            ],
                          );
                        } else if (snapshot.hasError) {
                          if (kDebugMode) {
                            print(
                                "PROJECT_PROGRESS_ERROR => ${snapshot.error}");
                          }
                          return const LoadDataError();
                        }
                      }
                      return LoadingIndicator(
                        color: Theme.of(context).primaryColor,
                      );
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
