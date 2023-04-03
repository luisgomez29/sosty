import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:sosty/config/provider/project_provider.dart';
import 'package:sosty/domain/models/project/project_item.dart';
import 'package:sosty/ui/common/constants/constants.dart';
import 'package:sosty/ui/common/styles/styles.dart';
import 'package:sosty/ui/components/alerts/alert_info.dart';
import 'package:sosty/ui/components/alerts/alert_warning.dart';
import 'package:sosty/ui/components/cards/custom_card.dart';
import 'package:sosty/ui/components/cards/icon_card.dart';
import 'package:sosty/ui/components/general/carousel_image.dart';
import 'package:sosty/ui/components/general/content_section.dart';
import 'package:sosty/ui/components/general/custom_rich_text.dart';
import 'package:sosty/ui/components/general/load_data_error.dart';
import 'package:sosty/ui/components/general/loading_indicator.dart';
import 'package:sosty/ui/components/navbar/navbar_detail.dart';
import 'package:sosty/ui/components/projects/project_current_widget.dart';
import 'package:sosty/ui/components/projects/project_goal_widget.dart';
import 'package:sosty/ui/components/projects/project_participation_simulator.dart';
import 'package:sosty/ui/components/projects/project_progress_indicator.dart';
import 'package:sosty/ui/components/projects/project_support_documents_section.dart';
import 'package:sosty/ui/config/theme/app_theme.dart';
import 'package:sosty/ui/helpers/formatter_helper.dart';

class ProjectDetailScreen extends StatefulWidget {
  const ProjectDetailScreen({
    Key? key,
    required this.projectCode,
  }) : super(key: key);

  final String projectCode;

  @override
  State<ProjectDetailScreen> createState() => _ProjectDetailScreenState();
}

class _ProjectDetailScreenState extends State<ProjectDetailScreen> {
  final _sizedBoxValue = 5.0;
  Future<ProjectItem>? _futureProject;

  Future<ProjectItem> _fetchProjectDetail() async {
    final projectProvider =
        Provider.of<ProjectProvider>(context, listen: false);
    return projectProvider.projectUseCase
        .getProjectPublicByCode(widget.projectCode);
  }

  String _getMonthlyFattening(String cattleWeightAverageGain) {
    double total = 0.0;
    if (cattleWeightAverageGain != '-') {
      total = (double.parse(cattleWeightAverageGain) * 30) / 1000;
    }
    return "${FormatterHelper.doubleFormat(total)} Kg";
  }

  @override
  void initState() {
    super.initState();
    _futureProject = _fetchProjectDetail();
  }

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: AppTheme.getSystemUiOverlayStyle(),
      child: Scaffold(
        body: SafeArea(
          child: CustomScrollView(
            slivers: [
              const NavbarDetail(),
              SliverToBoxAdapter(
                child: FutureBuilder<ProjectItem>(
                  future: _futureProject,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.done) {
                      if (snapshot.hasData) {
                        final ProjectItem project = snapshot.data!;
                        return Column(
                          children: [
                            ProjectCarouselImage(
                              project: project,
                            ),
                            const SizedBox(
                              height: 30,
                            ),
                            ContentSection(
                              child: Column(
                                children: [
                                  CustomCard(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "${project.producerName} (${project.projectCode})",
                                          style: Styles.headline2,
                                        ),
                                        SizedBox(
                                          height: _sizedBoxValue * 2,
                                        ),
                                        CustomRichText(
                                          text: "Ubicación",
                                          textSpan: project.locationAddress,
                                        ),
                                        const SizedBox(
                                          height: 20,
                                        ),
                                        IconCard(
                                          title:
                                              "${project.projectProfitability} % (E.A)",
                                          subtitle: "Rentabilidad estimada*",
                                          elevation: 0,
                                          padding: 0,
                                          margin: 0,
                                          icon: Icons.signal_cellular_alt,
                                          color: Colors.transparent,
                                        ),
                                        IconCard(
                                          title: FormatterHelper.money(
                                              Constants.minimumInvestment),
                                          titleSpan: "COP",
                                          subtitle: "Inversión mínima",
                                          elevation: 0,
                                          margin: 0,
                                          padding: 0,
                                          color: Colors.transparent,
                                        ),
                                        IconCard(
                                          title: project.amountOfInvestors,
                                          subtitle: "NeoGanaderos",
                                          elevation: 0,
                                          margin: 0,
                                          padding: 0,
                                          icon: Icons.people_alt,
                                          color: Colors.transparent,
                                        ),
                                        IconCard(
                                          title:
                                              "${project.projectDuration} Meses",
                                          subtitle: "Duración",
                                          elevation: 0,
                                          margin: 0,
                                          padding: 0,
                                          icon: Icons.calendar_month,
                                          color: Colors.transparent,
                                        ),
                                        IconCard(
                                          title: "${project.daysLeft} días",
                                          subtitle: "Finalización recaudo",
                                          elevation: 0,
                                          margin: 0,
                                          padding: 0,
                                          icon: Icons.calendar_month,
                                          color: Colors.transparent,
                                        ),
                                        IconCard(
                                          title: project.amountOfCattles,
                                          subtitle: "Cantidad de animales",
                                          elevation: 0,
                                          margin: 0,
                                          padding: 0,
                                          icon: Icons.local_offer_outlined,
                                          color: Colors.transparent,
                                        ),
                                        const SizedBox(
                                          height: 10,
                                        ),
                                        ProjectGoalWidget(
                                          amountOfCattles:
                                              project.amountOfCattles,
                                          investmentRequired:
                                              project.investmentRequired,
                                        ),
                                        SizedBox(
                                          height: _sizedBoxValue,
                                        ),
                                        ProjectCurrentWidget(
                                          investmentCollected:
                                              project.investmentCollected,
                                          investmentRequired:
                                              project.investmentRequired,
                                          amountOfCattles:
                                              project.amountOfCattles,
                                        ),
                                        SizedBox(
                                          height: _sizedBoxValue,
                                        ),
                                        ProjectProgressIndicator(
                                          progress: project.projectProgres,
                                        ),
                                        Text(
                                          "${project.projectProgres}% recaudado",
                                        ),
                                        SizedBox(
                                          height: _sizedBoxValue,
                                        ),
                                        ProjectAlert(
                                            progress: project.projectProgres),
                                      ],
                                    ),
                                  ),
                                  SizedBox(
                                    height: _sizedBoxValue * 2,
                                  ),
                                  if (double.parse(project.projectProgres) <
                                      100.0)
                                    ProjectParticipationSimulator(
                                      projectCode: project.projectCode,
                                      profitability:
                                          project.projectProfitability,
                                      duration: project.projectDuration,
                                    ),
                                  SizedBox(
                                    height: _sizedBoxValue * 2,
                                  ),
                                  CustomCard(
                                    child: Column(
                                      children: [
                                        IconCard(
                                          title:
                                              "${project.amountOfCattles} animales",
                                          subtitle: "Tamaño Lote",
                                          elevation: 0,
                                          padding: 0,
                                          margin: 0,
                                          icon: Icons.grid_view_outlined,
                                          color: Colors.transparent,
                                        ),
                                        IconCard(
                                          title:
                                              "${project.initialWeight ?? 0} Kg",
                                          subtitle: "Peso inicial del animal",
                                          elevation: 0,
                                          padding: 0,
                                          margin: 0,
                                          icon: Icons.layers_outlined,
                                          color: Colors.transparent,
                                        ),
                                        IconCard(
                                          title:
                                              "${project.finalWeight ?? 0} Kg",
                                          subtitle: "Peso final del animal",
                                          elevation: 0,
                                          padding: 0,
                                          margin: 0,
                                          icon: Icons.layers_outlined,
                                          color: Colors.transparent,
                                        ),
                                        IconCard(
                                          title: _getMonthlyFattening(
                                            project.cattleWeightAverageGain,
                                          ),
                                          subtitle: "Engorde mensual",
                                          elevation: 0,
                                          padding: 0,
                                          margin: 0,
                                          icon: Icons.trending_up_outlined,
                                          color: Colors.transparent,
                                        ),
                                        IconCard(
                                          title: project.projectType,
                                          subtitle: "Tipo de proyecto",
                                          elevation: 0,
                                          padding: 0,
                                          margin: 0,
                                          icon: Icons.share_outlined,
                                          color: Colors.transparent,
                                        ),
                                        IconCard(
                                          title: project.projectSex,
                                          subtitle: "Sexo",
                                          elevation: 0,
                                          padding: 0,
                                          margin: 0,
                                          icon: Icons.visibility_outlined,
                                          color: Colors.transparent,
                                        ),
                                        IconCard(
                                          title: project.projectCattleType,
                                          subtitle: "Tipo de ganado",
                                          elevation: 0,
                                          padding: 0,
                                          margin: 0,
                                          icon: Icons.light_mode_outlined,
                                          color: Colors.transparent,
                                        ),
                                      ],
                                    ),
                                  ),
                                  SizedBox(
                                    height: _sizedBoxValue * 2,
                                  ),
                                  SizedBox(
                                    width: MediaQuery.of(context).size.width,
                                    child: CustomCard(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            "Predio",
                                            style: Styles.headline2,
                                          ),
                                          SizedBox(
                                            height: _sizedBoxValue,
                                          ),
                                          Text(
                                            "Ubicación",
                                            style: Styles.bodyText1Bold,
                                          ),
                                          SizedBox(
                                            height: _sizedBoxValue / 2,
                                          ),
                                          Text(
                                            project.locationAddress,
                                          ),
                                          SizedBox(
                                            height: _sizedBoxValue,
                                          ),
                                          Text(
                                            "Indicaciones",
                                            style: Styles.bodyText1Bold,
                                          ),
                                          SizedBox(
                                            height: _sizedBoxValue / 2,
                                          ),
                                          Text(
                                            project.locationArrivalLIndications,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: _sizedBoxValue * 2,
                                  ),
                                  CustomCard(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "Productor",
                                          style: Styles.headline2,
                                        ),
                                        SizedBox(
                                          height: _sizedBoxValue * 2,
                                        ),
                                        Row(
                                          children: [
                                            ClipOval(
                                              child: Material(
                                                color: Theme.of(context)
                                                    .primaryColor
                                                    .withOpacity(0.2),
                                                child: ImageProducer(
                                                  url: project
                                                      .producerProfilePictureUrl,
                                                ),
                                              ),
                                            ),
                                            SizedBox(
                                              width: _sizedBoxValue * 2,
                                            ),
                                            Expanded(
                                              child: Text(
                                                project.producerName,
                                                style:
                                                    Styles.bodyText1.copyWith(
                                                  fontSize: 17.0,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                        SizedBox(
                                          height: _sizedBoxValue,
                                        ),
                                        Align(
                                          alignment: Alignment.centerRight,
                                          child: Chip(
                                            backgroundColor: Theme.of(context)
                                                .primaryColor
                                                .withOpacity(0.1),
                                            avatar: Icon(
                                              Icons.verified_outlined,
                                              color: Theme.of(context)
                                                  .primaryColor,
                                              size: 18.0,
                                            ),
                                            label: Text(
                                              "Productor Verificado",
                                              style:
                                                  Styles.bodyText2Bold.copyWith(
                                                fontSize: 10.0,
                                                color: Theme.of(context)
                                                    .primaryColor,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  SizedBox(
                                    height: _sizedBoxValue * 2,
                                  ),
                                  SizedBox(
                                    width: MediaQuery.of(context).size.width,
                                    child: CustomCard(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            "Detalle y Objetivos del Proyecto",
                                            style: Styles.headline2,
                                          ),
                                          SizedBox(
                                            height: _sizedBoxValue,
                                          ),
                                          Text(
                                            project.details,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: _sizedBoxValue * 2,
                                  ),
                                  SizedBox(
                                    width: MediaQuery.of(context).size.width,
                                    child: CustomCard(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            "Manejo de Riesgos",
                                            style: Styles.headline2,
                                          ),
                                          SizedBox(
                                            height: _sizedBoxValue,
                                          ),
                                          Text(
                                            project.risksManagement,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: _sizedBoxValue * 2,
                                  ),
                                  SizedBox(
                                    width: MediaQuery.of(context).size.width,
                                    child: CustomCard(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            "Plan de Comunicaciones",
                                            style: Styles.headline2,
                                          ),
                                          SizedBox(
                                            height: _sizedBoxValue,
                                          ),
                                          Text(
                                            project.communicationPlan,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: _sizedBoxValue * 2,
                                  ),
                                  SizedBox(
                                    width: MediaQuery.of(context).size.width,
                                    child: CustomCard(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            "Historia del Proyecto",
                                            style: Styles.headline2,
                                          ),
                                          SizedBox(
                                            height: _sizedBoxValue,
                                          ),
                                          Text(
                                            project.projectStory,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: _sizedBoxValue * 2,
                                  ),
                                  ProjectSupportDocumentsSection(
                                    project: project,
                                  ),
                                  SizedBox(
                                    height: _sizedBoxValue * 8,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        );
                      } else if (snapshot.hasError) {
                        if (kDebugMode) {
                          print(
                              "INVESTMENT_IN_PROGRESS_ERROR => ${snapshot.error}");
                        }
                        return const LoadDataError();
                      }
                    }
                    return Padding(
                      padding: const EdgeInsets.only(
                        top: 30.0,
                      ),
                      child: LoadingIndicator(
                        color: Theme.of(context).primaryColor,
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ProjectCarouselImage extends StatelessWidget {
  const ProjectCarouselImage({
    Key? key,
    required this.project,
  }) : super(key: key);

  final ProjectItem project;

  @override
  Widget build(BuildContext context) {
    final List<String> imagesUrl = [project.projectImageUrl1];
    if (project.projectImageUrl2 != null) {
      imagesUrl.add(project.projectImageUrl2!);
    }
    if (project.projectImageUrl3 != null) {
      imagesUrl.add(project.projectImageUrl3!);
    }
    if (project.projectImageUrl4 != null) {
      imagesUrl.add(project.projectImageUrl4!);
    }

    return CarouselImage(
      images: imagesUrl,
    );
  }
}

class ImageProducer extends StatelessWidget {
  const ImageProducer({
    Key? key,
    this.url,
  }) : super(key: key);

  final String? url;

  @override
  Widget build(BuildContext context) {
    return url != null
        ? Image.network(
            url!,
            width: 60,
            height: 60,
            fit: BoxFit.cover,
          )
        : Padding(
            padding: const EdgeInsets.all(8.0),
            child: Icon(
              Icons.person_outline_rounded,
              size: 48,
              color: Theme.of(context).primaryColor,
            ),
          );
  }
}

class ProjectAlert extends StatelessWidget {
  const ProjectAlert({
    Key? key,
    required this.progress,
  }) : super(key: key);

  final String progress;

  @override
  Widget build(BuildContext context) {
    return double.parse(progress) >= 100.0
        ? AlertWarning(
            child: Text(
              Constants.projectFullText,
              style: TextStyle(
                color: AlertWarning.textColor,
                fontWeight: FontWeight.bold,
              ),
            ),
          )
        : AlertInfo(
            child: Text(
              Constants.projectIncompleteText,
              style: TextStyle(
                color: AlertInfo.textColor,
                fontWeight: FontWeight.bold,
              ),
            ),
          );
  }
}
