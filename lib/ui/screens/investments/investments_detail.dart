import 'package:flutter/material.dart';
import 'package:sosty/ui/common/styles/styles.dart';
import 'package:sosty/ui/components/cards/custom_card.dart';
import 'package:sosty/ui/components/general/content_section.dart';
import 'package:sosty/ui/components/general/custom_rich_text.dart';
import 'package:sosty/ui/components/general/section_title.dart';
import 'package:sosty/ui/components/general/timeline.dart';
import 'package:sosty/ui/components/investments/investments_timeline_item.dart';
import 'package:sosty/ui/components/cards/icon_card.dart';
import 'package:sosty/ui/components/navbar/navbar_detail.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class InvestmentsDetail extends StatelessWidget {
  const InvestmentsDetail({Key? key}) : super(key: key);

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

  @override
  Widget build(BuildContext context) {
    const List<ChartData> chartData = [
      ChartData("01/01/2022", 40000),
      ChartData("02/02/2022", 40000)
    ];
    return Scaffold(
      body: SafeArea(
        child: CustomScrollView(
          slivers: <Widget>[
            const NavbarDetail(),
            SliverToBoxAdapter(
              child: ContentSection(
                offsetY: 0.0,
                child: Column(
                  children: [
                    const SizedBox(
                      height: 20,
                    ),
                    const SectionTitle(
                      title: "Seguimiento Proyecto # 1110",
                      subTitle: "Proyecto de Prueba - No Invertir",
                    ),
                    const IconCard(
                      title: '\$ 1,000,000',
                      subtitle: 'Inversión Inicial',
                    ),
                    const IconCard(
                      title: '\$ 1,095,562.50',
                      subtitle: 'Valor Actual Estimado',
                    ),
                    const IconCard(
                      title: '\$ 95,562.50',
                      subtitle: 'Ganancia Estimada',
                      icon: Icons.trending_up_sharp,
                    ),
                    CustomCard(
                      child: Column(
                        children: [
                          _getCardTitle("Información Proyecto"),
                          Timeline(
                            children: [
                              _getProjectInformationItem(
                                "Productor",
                                "User Test",
                              ),
                              _getProjectInformationItem(
                                "Lugar",
                                "Meta",
                              ),
                              _getProjectInformationItem(
                                "Finca",
                                "Finca El Origen",
                              ),
                              _getProjectInformationItem(
                                "Fecha Inicio",
                                "2021-07-12",
                              ),
                              _getProjectInformationItem(
                                "Fecha Cierre",
                                "2022-06-12",
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
                    CustomCard(
                      child: Column(
                        children: [
                          _getCardTitle("Evolución Peso Lote"),
                          //Initialize the chart widget
                          SfCartesianChart(
                              primaryXAxis: CategoryAxis(interval: 1),
                              primaryYAxis: NumericAxis(interval: 20000),
                              series: <ChartSeries<ChartData, String>>[
                                // Renders column chart
                                ColumnSeries<ChartData, String>(
                                    color: Styles.primaryColor,
                                    dataSource: chartData,
                                    xValueMapper: (ChartData data, _) => data.x,
                                    yValueMapper: (ChartData data, _) => data.y)
                              ])
                        ],
                      ),
                    ),
                    CustomCard(
                      child: Column(
                        children: [
                          _getCardTitle("Actualizaciones y \n Documentos"),
                          Timeline(
                            lineColor:
                                Theme.of(context).primaryColor.withOpacity(0.3),
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
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ChartData {
  const ChartData(this.x, this.y);
  final String x;
  final int y;
}
