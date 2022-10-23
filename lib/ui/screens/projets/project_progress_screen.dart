import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sosty/config/provider/project_provider.dart';
import 'package:sosty/domain/models/project/project_progress.dart';
import 'package:sosty/ui/common/styles/styles.dart';
import 'package:sosty/ui/components/cards/custom_card.dart';
import 'package:sosty/ui/components/cards/custom_ink_well_card.dart';
import 'package:sosty/ui/components/cards/icon_card.dart';
import 'package:sosty/ui/components/charts/bar_chart.dart';
import 'package:sosty/ui/components/charts/circular_chart.dart';
import 'package:sosty/ui/components/general/content_section.dart';
import 'package:sosty/ui/components/general/custom_rich_text.dart';
import 'package:sosty/ui/components/general/load_data_error.dart';
import 'package:sosty/ui/components/general/loading_indicator.dart';
import 'package:sosty/ui/components/general/section_title.dart';
import 'package:sosty/ui/components/general/timeline.dart';
import 'package:sosty/ui/components/investments/investments_timeline_item.dart';
import 'package:sosty/ui/components/navbar/navbar_detail.dart';
import 'package:sosty/ui/helpers/formatter_helper.dart';
import 'package:sosty/ui/common/constants/constants.dart';

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
    // final response = projectProvider.projectUseCase
    //     .getProjectProgressInformation(widget.investmentId);
    final response = projectProvider.projectUseCase
        .getProjectProgressInformation('d9392cc2-987e-4fb5-a9fc-e374ac49d912');
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

  String _getEstimatedGain(double projectProfitability, DateTime endDate) {
    const months = 12.0;
    final monthsInProgress = endDate.difference(DateTime.now()).inDays / 30;
    final double estimatedGain =
        ((projectProfitability / months) * monthsInProgress) * Constants.minimumInvestment;
    return FormatterHelper.money(estimatedGain);
  }

  @override
  void initState() {
    super.initState();
    _fetchProjectProgress();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                        final ProjectProgress projectProgress = snapshot.data!;
                        return Column(
                          children: [
                            SectionTitle(
                              title:
                                  "Seguimiento Proyecto # ${projectProgress.projectCode}",
                              subTitle: projectProgress.projectName,
                            ),
                            // TODO
                            IconCard(
                              title: FormatterHelper.money(
                                projectProgress.amountInvested,
                              ),
                              subtitle: 'Inversión Inicial',
                            ),
                            // TODO
                            const IconCard(
                              title: '\$ 1,095,562.50',
                              subtitle: 'Valor Actual Estimado',
                            ),
                            // TODO
                            IconCard(
                              title: _getEstimatedGain(
                                projectProgress.projectProfitability,
                                projectProgress.endDate,
                              ),
                              subtitle: 'Ganancia Estimada',
                              icon: Icons.trending_up_sharp,
                            ),
                            CustomInkWellCard(
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
                                ],
                              ),
                            ),
                            const CustomCard(
                              child: ToolBar(),
                            ),
                            const CustomCard(
                              child: ToolCircular(),
                            ),
                            CustomInkWellCard(
                              child: Column(
                                children: [
                                  _getCardTitle(
                                      "Actualizaciones y \n Documentos"),
                                  Timeline(
                                    lineColor: Theme.of(context)
                                        .primaryColor
                                        .withOpacity(0.3),
                                    lineGap: 0,
                                    children: const <Widget>[
                                      InvestmentsTimelineItem(
                                        title: "Nuevo Pesaje",
                                        date: "2022-02-02",
                                        description:
                                            "Se realiza carga de documentos para entrega en finca",
                                      ),
                                      Card(
                                        child: SizedBox(
                                          height: 50,
                                        ),
                                      ),
                                      Card(
                                        child: SizedBox(
                                          height: 200,
                                        ),
                                      ),
                                      Card(
                                        child: SizedBox(
                                          height: 100,
                                        ),
                                      ),
                                    ],
                                    indicators: <Widget>[
                                      Icon(
                                        Icons.adjust_outlined,
                                        color: Theme.of(context).primaryColor,
                                      ),
                                      Icon(
                                        Icons.adjust_outlined,
                                        color: Theme.of(context).primaryColor,
                                      ),
                                      Icon(
                                        Icons.adjust_outlined,
                                        color: Theme.of(context).primaryColor,
                                      ),
                                      Icon(
                                        Icons.adjust_outlined,
                                        color: Theme.of(context).primaryColor,
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(
                              height: 50,
                            ),
                          ],
                        );
                      } else if (snapshot.hasError) {
                        if (kDebugMode) {
                          print("PROJECT_PROGRESS_ERROR => ${snapshot.error}");
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
    );
  }
}
