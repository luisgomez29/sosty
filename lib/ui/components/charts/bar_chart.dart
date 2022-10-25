import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:sosty/ui/common/styles/styles.dart';

class BarChart {
  const BarChart(this.x, this.y);

  final String x;
  final int y;
}

late TooltipBehavior _toolBarBehavior;

class ToolBar extends StatefulWidget {
  const ToolBar({Key? key, this.wghts, this.wghtsDates}) : super(key: key);

  final List? wghts;
  final List? wghtsDates;

  @override
  _ToolState createState() => _ToolState();
}

class _ToolState extends State<ToolBar> {
  @override
  void initState() {
    _toolBarBehavior =
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
  }

  @override
  Widget build(BuildContext context) {
    final List<BarChart> barChar = [];
    if (widget.wghts!.isNotEmpty && widget.wghtsDates!.isNotEmpty) {
      widget.wghtsDates?.forEach((element1) {
        int idx = (widget.wghtsDates)!.indexOf(element1);
        int vlr = (widget.wghts)!.elementAt(idx);
        barChar.add(BarChart(element1, vlr));
      });
    }
    return Column(
      children: [
        _getCardTitle("Evolución Peso Lote"),
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
            )
          ],
        )
      ],
    );
  }
}
