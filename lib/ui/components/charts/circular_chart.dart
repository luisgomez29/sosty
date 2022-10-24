import 'package:flutter/material.dart';
import 'package:sosty/domain/models/project/project_progress_weight.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:sosty/ui/common/styles/styles.dart';

class CircularChart {
  const CircularChart(this.x, this.y, this.color);
  final String x;
  final int? y;
  final Color color;
}

late TooltipBehavior _toolCircularBehavior;

class ToolCircular extends StatefulWidget {
  const ToolCircular({Key? key, this.wghts}) : super(key: key);

  final List<ProjectProgressWeight>? wghts;

  @override
  // ignore: no_logic_in_create_state
  _ToolState createState() => _ToolState();
}

class _ToolState extends State<ToolCircular> {
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
    int position = (widget.wghts?.length)! - 1;
    int totalCattles =
        (widget.wghts?[position].cantidadDeAnimalesGanananDe0A7)! +
            (widget.wghts?[position].cantidadDeAnimalesGanananDe7A10)! +
            (widget.wghts?[position].cantidadDeAnimalesGanananMasDe10)!;

    List<CircularChart> circularChar = [
      const CircularChart('Engordan entre 0 y 6kg mensuales: ', 60,
          Color.fromARGB(255, 247, 142, 6)),
      const CircularChart('Engordan entre 7 y 10kg mensuales: ', 80,
          Color.fromARGB(255, 3, 217, 245)),
      const CircularChart('Engordan mas de 10kg mensuales: ', 40,
          Color.fromARGB(255, 0, 189, 86))
    ];
    return Column(
      children: [
        _getCardTitle("Animales"),

        //Initialize the chart widget
        SfCircularChart(
            annotations: <CircularChartAnnotation>[
              CircularChartAnnotation(
                  widget: Text("$totalCattles \n Animales",
                      style: const TextStyle(
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
