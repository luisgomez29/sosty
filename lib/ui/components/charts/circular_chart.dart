import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:sosty/ui/common/styles/styles.dart';

class CircularChart {
  const CircularChart(this.x, this.y, this.color);
  final String x;
  final int y;
  final Color color;
}

late TooltipBehavior _toolCircularBehavior;

class ToolCircular extends StatefulWidget {
  const ToolCircular({Key? key}) : super(key: key);

  @override
  _ToolState createState() => _ToolState();
}

class _ToolState extends State<ToolCircular> {
  static const List<CircularChart> circularChar = [
    CircularChart('Engordan entre 0 y 6kg mensuales: ', 80,
        Color.fromARGB(255, 247, 142, 6)),
    CircularChart('Engordan entre 7 y 10kg mensuales: ', 80,
        Color.fromARGB(255, 3, 217, 245)),
    CircularChart(
        'Engordan mas de 10kg mensuales: ', 40, Color.fromARGB(255, 0, 189, 86))
  ];

  @override
  void initState() {
    _toolCircularBehavior =
        TooltipBehavior(enable: true, tooltipPosition: TooltipPosition.pointer);
    super.initState();
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
  } //

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _getCardTitle("Animales"),

        //Initialize the chart widget
        SfCircularChart(
            annotations: <CircularChartAnnotation>[
              CircularChartAnnotation(
                  widget: const Text('200 \n Animales',
                      style: TextStyle(
                          color: Color.fromARGB(255, 0, 0, 0), fontSize: 20),
                      textAlign: TextAlign.center))
            ],
            tooltipBehavior: _toolCircularBehavior,
            series: <CircularSeries>[
              // Renders doughnut chart
              DoughnutSeries<CircularChart, String>(
                dataSource: circularChar,
                innerRadius: '70%',
                pointColorMapper: (CircularChart data, _) => data.color,
                xValueMapper: (CircularChart data, _) => data.x,
                yValueMapper: (CircularChart data, _) => data.y,
              ),
            ])
      ],
    );
  }
}
