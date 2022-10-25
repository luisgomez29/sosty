import 'package:flutter/material.dart';
import 'package:sosty/domain/models/project/project_progress_weight.dart';
import 'package:sosty/ui/common/styles/styles.dart';
import 'package:sosty/ui/components/projects/project_message.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class CircularChart {
  const CircularChart({
    required this.color,
    required this.x,
    this.y,
  });

  final Color color;
  final String x;
  final int? y;
}

class ProjectWeightsCircularChart extends StatefulWidget {
  const ProjectWeightsCircularChart({
    Key? key,
    required this.weights,
  }) : super(key: key);

  final List<ProjectProgressWeight> weights;

  @override
  _ToolState createState() => _ToolState();
}

class _ToolState extends State<ProjectWeightsCircularChart> {
  late TooltipBehavior _toolCircularBehavior;

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
  void initState() {
    super.initState();
    _toolCircularBehavior = TooltipBehavior(
      enable: true,
      tooltipPosition: TooltipPosition.pointer,
    );
  }

  @override
  Widget build(BuildContext context) {
    List<CircularChart> circularChar = [];
    int de0a7 = 0, de7a10 = 0, deMas10 = 0, totalCattles = 0;

    if (widget.weights.isNotEmpty) {
      de0a7 = (widget.weights.last.cantidadDeAnimalesGanananDe0A7);
      de7a10 = (widget.weights.last.cantidadDeAnimalesGanananDe7A10);
      deMas10 = (widget.weights.last.cantidadDeAnimalesGanananMasDe10);
      totalCattles = de0a7 + de7a10 + deMas10;
      circularChar.addAll(
        [
          CircularChart(
            color: const Color.fromARGB(255, 247, 142, 6),
            x: 'Engordan entre 0 y 6 kg mensuales: ',
            y: de0a7,
          ),
          CircularChart(
            color: const Color.fromARGB(255, 3, 217, 245),
            x: 'Engordan entre 7 y 10 kg mensuales: ',
            y: de7a10,
          ),
          CircularChart(
            color: const Color.fromARGB(255, 0, 189, 86),
            x: 'Engordan mas de 10 kg mensuales: ',
            y: deMas10,
          ),
        ],
      );
    }
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      child: Column(
        children: [
          _getCardTitle("Animales"),
          circularChar.isEmpty
              ? const ProjectMessage(
                  text: "No hay animales",
                )
              :
              //Initialize the chart widget
              SfCircularChart(
                  annotations: <CircularChartAnnotation>[
                    CircularChartAnnotation(
                      widget: Text(
                        "$totalCattles \n Animales",
                        style: const TextStyle(
                          color: Colors.black,
                          fontSize: 20,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    )
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
                  ],
                )
        ],
      ),
    );
  }
}
