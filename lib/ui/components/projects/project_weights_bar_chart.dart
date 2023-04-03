import 'package:flutter/material.dart';
import 'package:sosty/ui/common/styles/styles.dart';
import 'package:sosty/ui/components/projects/project_message.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class BarChart {
  const BarChart({
    required this.x,
    required this.y,
  });

  final String x;
  final int y;
}

class ProjectWeightsBarChart extends StatefulWidget {
  const ProjectWeightsBarChart({
    Key? key,
    required this.weights,
    required this.weightsDates,
  }) : super(key: key);

  final List<int> weights;
  final List<String> weightsDates;

  @override
  State<ProjectWeightsBarChart> createState() => _ProjectWeightsBarChartState();
}

class _ProjectWeightsBarChartState extends State<ProjectWeightsBarChart> {
  late TooltipBehavior _toolBarBehavior;

  @override
  void initState() {
    super.initState();
    _toolBarBehavior = TooltipBehavior(
      enable: true,
      tooltipPosition: TooltipPosition.pointer,
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
    final List<BarChart> barChar = [];
    if (widget.weights.isNotEmpty && widget.weightsDates.isNotEmpty) {
      for (var element1 in widget.weightsDates) {
        int idx = (widget.weightsDates).indexOf(element1);
        int vlr = (widget.weights).elementAt(idx);
        barChar.add(BarChart(x: element1, y: vlr));
      }
    }
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      child: Column(
        children: [
          _getCardTitle("Evolución Peso Lote"),
          barChar.isEmpty
              ? const ProjectMessage(
                  text: "No hay animales",
                )
              :
              //Initialize the chart widget
              SfCartesianChart(
                  primaryXAxis: CategoryAxis(interval: 1),
                  primaryYAxis: NumericAxis(interval: 20000),
                  tooltipBehavior: _toolBarBehavior,
                  series: <ChartSeries<BarChart, String>>[
                    // Renders column chart
                    ColumnSeries<BarChart, String>(
                      color: Styles.primaryColor,
                      dataSource: barChar,
                      xValueMapper: (BarChart data, _) => data.x,
                      yValueMapper: (BarChart data, _) => data.y,
                    ),
                  ],
                ),
        ],
      ),
    );
  }
}
