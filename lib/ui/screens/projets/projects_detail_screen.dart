import 'package:flutter/material.dart';
import 'package:sosty/domain/models/project/project_item.dart';
import 'package:sosty/ui/common/constants/constants.dart';
import 'package:sosty/ui/common/styles/styles.dart';
import 'package:sosty/ui/components/alerts/alert_info.dart';
import 'package:sosty/ui/components/alerts/alert_warning.dart';
import 'package:sosty/ui/components/cards/custom_card.dart';
import 'package:sosty/ui/components/cards/icon_card.dart';
import 'package:sosty/ui/components/fields/custom_text_form_field.dart';
import 'package:sosty/ui/components/general/carousel_image.dart';
import 'package:sosty/ui/components/general/content_section.dart';
import 'package:sosty/ui/components/general/custom_rich_text.dart';
import 'package:sosty/ui/components/navbar/navbar_detail.dart';
import 'package:sosty/ui/components/projects/project_support_document_card.dart';
import 'package:sosty/ui/helpers/download_file_helper.dart';
import 'package:sosty/ui/helpers/formatter_helper.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:permission_handler/permission_handler.dart';
import 'package:uuid/uuid.dart';

class ProjectDetailScreen extends StatefulWidget {
  const ProjectDetailScreen({
    Key? key,
    required this.project,
  }) : super(key: key);

  final ProjectItem project;

  @override
  _ProjectDetailScreenState createState() => _ProjectDetailScreenState();
}

class _ProjectDetailScreenState extends State<ProjectDetailScreen> {
  final _sizedBoxValue = 10.0;
  late DownloadFileHelper _downloadFileHelper;

  String _getPercentageCurrentAnimals(
    String investmentCollected,
    String investmentRequired,
    String amountOfCattles,
  ) {
    final percentage =
        (double.parse(investmentCollected) / double.parse(investmentRequired)) *
            double.parse(amountOfCattles);
    return "${FormatterHelper.doubleFormat(percentage)} Animales (${FormatterHelper.doubleFormat(investmentCollected)}) Kg";
  }

  Widget _getAlert(String projectProgress) {
    return double.parse(projectProgress) == 100.0
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

  Widget _getImageProducer(String? url) {
    return url != null
        ? Image.network(
            url,
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

  @override
  void initState() {
    super.initState();
    _downloadFileHelper = DownloadFileHelper();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            const NavbarDetail(),
            SliverToBoxAdapter(
              child: Column(
                children: [
                  Container(
                    height: 350,
                    padding: const EdgeInsets.only(
                      left: 10.0,
                    ),
                    child: ListView(
                      scrollDirection: Axis.horizontal,
                      children: <Widget>[
                        CarouselImage(
                          imageUrl: widget.project.projectImageUrl1,
                        ),
                        CarouselImage(
                          imageUrl: widget.project.projectImageUrl2!,
                        ),
                        CarouselImage(
                          imageUrl: widget.project.projectImageUrl3!,
                        ),
                        CarouselImage(
                          imageUrl: widget.project.projectImageUrl4!,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 50,
                  ),
                  ContentSection(
                    offsetY: 0.0,
                    child: Column(
                      children: [
                        CustomCard(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "${widget.project.producerName} (${widget.project.projectCode})",
                                style: Styles.headline2,
                              ),
                              SizedBox(
                                height: _sizedBoxValue * 2,
                              ),
                              CustomRichText(
                                text: "Ubicación",
                                textSpan: widget.project.locationAddress,
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              IconCard(
                                title:
                                    "${widget.project.projectProfitability} % (E.A)",
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
                                title: widget.project.amountOfInvestors,
                                subtitle: "NeoGanaderos",
                                elevation: 0,
                                margin: 0,
                                padding: 0,
                                icon: Icons.people_alt,
                                color: Colors.transparent,
                              ),
                              IconCard(
                                title:
                                    "${widget.project.projectDuration} Meses",
                                subtitle: "Duración",
                                elevation: 0,
                                margin: 0,
                                padding: 0,
                                icon: Icons.calendar_month,
                                color: Colors.transparent,
                              ),
                              IconCard(
                                title: "${widget.project.daysLeft} días",
                                subtitle: "Finalización recaudo",
                                elevation: 0,
                                margin: 0,
                                padding: 0,
                                icon: Icons.calendar_month,
                                color: Colors.transparent,
                              ),
                              IconCard(
                                title: widget.project.amountOfCattles,
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
                              CustomRichText(
                                text: "Meta",
                                textSpan:
                                    "${widget.project.amountOfCattles} Animales (${FormatterHelper.doubleFormat(widget.project.investmentCollected)} Kg)",
                              ),
                              SizedBox(
                                height: _sizedBoxValue,
                              ),
                              CustomRichText(
                                text: "Actual",
                                textSpan: _getPercentageCurrentAnimals(
                                  widget.project.investmentCollected,
                                  widget.project.investmentRequired,
                                  widget.project.amountOfCattles,
                                ),
                              ),
                              SizedBox(
                                height: _sizedBoxValue,
                              ),
                              LinearProgressIndicator(
                                value: (double.parse(
                                        widget.project.projectProgres) /
                                    100),
                                minHeight: 5,
                                semanticsLabel: 'Progreso',
                              ),
                              Text(
                                "${widget.project.projectProgres}% recaudado",
                              ),
                              SizedBox(
                                height: _sizedBoxValue,
                              ),
                              _getAlert(widget.project.projectProgres),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: _sizedBoxValue * 2,
                        ),
                        CustomCard(
                          child: Column(
                            children: [
                              Text(
                                "Simula tu participación, digita el valor:",
                                style: Styles.headline2.copyWith(
                                  color: Theme.of(context).primaryColor,
                                ),
                              ),
                              SizedBox(
                                height: _sizedBoxValue * 2,
                              ),
                              CustomTextFormField(
                                labelText: "",
                                inputType: TextInputType.number,
                                prefixIcon: Icon(
                                  Icons.paid_outlined,
                                ),
                              ),
                              SizedBox(
                                height: _sizedBoxValue,
                              ),
                              AlertWarning(
                                child: RichText(
                                  text: TextSpan(
                                    text: "Ganarás ",
                                    style: TextStyle(
                                      color: AlertWarning.textColor,
                                      fontSize: 16.0,
                                    ),
                                    children: [
                                      TextSpan(
                                        text: "\$ 91,667 COP, ",
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      TextSpan(
                                        text: "en ",
                                      ),
                                      TextSpan(
                                        text: "11 Meses ",
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      TextSpan(
                                        text:
                                            "aproximadamente, equivalentes a una rentabilidad total estimada del ",
                                      ),
                                      TextSpan(
                                        text: "(1.83%).\n",
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      TextSpan(
                                        text: "Recibirás aproximadamente ",
                                      ),
                                      TextSpan(
                                        text: "\$ 5,091,667 COP,",
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      TextSpan(
                                        text:
                                            "al momento de liquidar el proyecto.",
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: _sizedBoxValue * 2,
                        ),
                        CustomCard(
                          child: Column(
                            children: [
                              IconCard(
                                title:
                                    "${widget.project.amountOfCattles} animales",
                                subtitle: "Tamaño Lote",
                                elevation: 0,
                                padding: 0,
                                margin: 0,
                                icon: Icons.grid_view_outlined,
                                color: Colors.transparent,
                              ),
                              IconCard(
                                title: "${widget.project.initialWeight} Kg",
                                subtitle: "Peso inicial del animal",
                                elevation: 0,
                                padding: 0,
                                margin: 0,
                                icon: Icons.layers_outlined,
                                color: Colors.transparent,
                              ),
                              IconCard(
                                title: "${widget.project.finalWeight} Kg",
                                subtitle: "Peso final del animal",
                                elevation: 0,
                                padding: 0,
                                margin: 0,
                                icon: Icons.layers_outlined,
                                color: Colors.transparent,
                              ),
                              IconCard(
                                title: "11.4 Kg",
                                subtitle: "Engorde mensual",
                                elevation: 0,
                                padding: 0,
                                margin: 0,
                                icon: Icons.trending_up_outlined,
                                color: Colors.transparent,
                              ),
                              IconCard(
                                title: "210 Kg",
                                subtitle: "Peso del lote actual",
                                elevation: 0,
                                padding: 0,
                                margin: 0,
                                icon: Icons.layers_outlined,
                                color: Colors.transparent,
                              ),
                              IconCard(
                                title: widget.project.projectType,
                                subtitle: "Tipo de proyecto",
                                elevation: 0,
                                padding: 0,
                                margin: 0,
                                icon: Icons.share_outlined,
                                color: Colors.transparent,
                              ),
                              IconCard(
                                title: widget.project.projectSex,
                                subtitle: "Sexo",
                                elevation: 0,
                                padding: 0,
                                margin: 0,
                                icon: Icons.visibility_outlined,
                                color: Colors.transparent,
                              ),
                              IconCard(
                                title: widget.project.projectCattleType,
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
                              crossAxisAlignment: CrossAxisAlignment.start,
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
                                  widget.project.locationAddress,
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
                                  widget.project.locationArrivalLIndications,
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
                            crossAxisAlignment: CrossAxisAlignment.start,
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
                                      child: _getImageProducer(
                                        widget
                                            .project.producerProfilePictureUrl,
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    width: _sizedBoxValue * 2,
                                  ),
                                  Expanded(
                                    child: Text(
                                      widget.project.producerName,
                                      style: Styles.bodyText1.copyWith(
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
                                    color: Theme.of(context).primaryColor,
                                    size: 18.0,
                                  ),
                                  label: Text(
                                    "Productor Verificado",
                                    style: Styles.bodyText2Bold.copyWith(
                                      fontSize: 10.0,
                                      color: Theme.of(context).primaryColor,
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
                        CustomCard(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Detalle y Objetivos del Proyecto",
                                style: Styles.headline2,
                              ),
                              SizedBox(
                                height: _sizedBoxValue,
                              ),
                              Text(
                                widget.project.details,
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
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Manejo de Riesgos",
                                  style: Styles.headline2,
                                ),
                                SizedBox(
                                  height: _sizedBoxValue,
                                ),
                                Text(
                                  widget.project.risksManagement,
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
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Plan de Comunicaciones",
                                style: Styles.headline2,
                              ),
                              SizedBox(
                                height: _sizedBoxValue,
                              ),
                              Text(
                                widget.project.communicationPlan,
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
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Historia del Proyecto",
                                  style: Styles.headline2,
                                ),
                                SizedBox(
                                  height: _sizedBoxValue,
                                ),
                                Text(
                                  widget.project.projectStory,
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
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Documentos de Soporte",
                                style: Styles.headline2,
                              ),
                              SizedBox(
                                height: _sizedBoxValue,
                              ),
                              ProjectSupportDocumentCard(
                                title: "Certificado de Libertad y Tradición",
                                onTap: () {
                                  _downloadFileHelper.downloadFile(
                                    context: context,
                                    url: widget.project.financialProjectionUrl,
                                  );
                                },
                              ),
                              ProjectSupportDocumentCard(
                                title:
                                    "Determinantes Riesgos Ambientales y Sociales",
                              ),
                              ProjectSupportDocumentCard(
                                title: "Condicionado Seguro Bovino y Bufalino",
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: _sizedBoxValue * 5,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
