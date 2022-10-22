import 'package:flutter/material.dart';
import 'package:sosty/domain/models/project/project_item.dart';
import 'package:sosty/ui/common/styles/styles.dart';
import 'package:sosty/ui/components/cards/custom_card.dart';
import 'package:sosty/ui/components/projects/project_support_document_card.dart';
import 'package:sosty/ui/helpers/download_file_helper.dart';

class ProjectSupportDocumentsSection extends StatefulWidget {
  const ProjectSupportDocumentsSection({
    Key? key,
    required this.project,
  }) : super(key: key);

  final ProjectItem project;

  @override
  _ProjectSupportDocumentsSectionState createState() =>
      _ProjectSupportDocumentsSectionState();
}

class _ProjectSupportDocumentsSectionState
    extends State<ProjectSupportDocumentsSection> {
  late DownloadFileHelper _downloadFileHelper;

  @override
  void initState() {
    super.initState();
    _downloadFileHelper = DownloadFileHelper();
  }

  @override
  Widget build(BuildContext context) {
    return CustomCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Documentos de Soporte",
            style: Styles.headline2,
          ),
          const SizedBox(
            height: 10.0,
          ),
          ProjectSupportDocumentCard(
            title: "Condicionado Seguro Bovino y Bufalino",
            onTap: () => _downloadFileHelper.downloadFile(
              context: context,
              url: "https://drive.google.com/uc",
              params: {
                'id': '1GE8tWPk7hXn-LHOq9XKQ631mynA2Sili',
                'export': 'download',
              },
              fileName: 'Seguro_Bovino.pdf',
            ),
          ),
          if (widget.project.financialProjectionUrl != null)
            ProjectSupportDocumentCard(
              title: "Proyeccion Financiera",
              onTap: () => _downloadFileHelper.downloadFile(
                context: context,
                url: widget.project.financialProjectionUrl!,
              ),
            ),
          if (widget.project.libertadYTradicionCertificateUrl != null)
            ProjectSupportDocumentCard(
              title: "Certificado de Libertad y Tradición",
              onTap: () => _downloadFileHelper.downloadFile(
                context: context,
                url: widget.project.libertadYTradicionCertificateUrl!,
              ),
            ),
          if (widget.project.usoDelSueloCertificateUrl != null)
            ProjectSupportDocumentCard(
              title: "Certificado Uso del Suelo",
              onTap: () => _downloadFileHelper.downloadFile(
                context: context,
                url: widget.project.usoDelSueloCertificateUrl!,
              ),
            ),
          if (widget.project.registroSanitarioUrl != null)
            ProjectSupportDocumentCard(
              title: "Registro Sanitario",
              onTap: () => _downloadFileHelper.downloadFile(
                context: context,
                url: widget.project.registroSanitarioUrl!,
              ),
            ),
          if (widget.project.ultimoSoporteVacunacionUrl != null)
            ProjectSupportDocumentCard(
              title: "Último Soporte Vacunación",
              onTap: () => _downloadFileHelper.downloadFile(
                context: context,
                url: widget.project.ultimoSoporteVacunacionUrl!,
              ),
            ),
          if (widget.project.determinantesRiesgosAmbientalesYSocialesUrl !=
              null)
            ProjectSupportDocumentCard(
              title: "Determinantes Riesgos Ambientales y Sociales",
              onTap: () => _downloadFileHelper.downloadFile(
                context: context,
                url:
                    widget.project.determinantesRiesgosAmbientalesYSocialesUrl!,
              ),
            ),
          if (widget.project.suraCotizacionSeguroUrl != null)
            ProjectSupportDocumentCard(
              title: "Cotización Seguro Sura",
              onTap: () => _downloadFileHelper.downloadFile(
                context: context,
                url: widget.project.suraCotizacionSeguroUrl!,
              ),
            ),
        ],
      ),
    );
  }
}
