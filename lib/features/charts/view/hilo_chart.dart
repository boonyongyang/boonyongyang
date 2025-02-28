import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import '../../../data.dart';
import 'chart_data.dart';
import 'stock_item.dart';

class HiloChart extends StatefulWidget {
  const HiloChart({super.key, required this.stock});

  final StockItem stock;

  @override
  HiloChartState createState() => HiloChartState();
}

class HiloChartState extends State<HiloChart> {
  late bool _toggleVisibility;
  TooltipBehavior? _tooltipBehavior;

  // Define colors locally to avoid constant issues
  final Color textColor = const Color(0xFFEBF0FF); // hologramWhite
  final Color accentColor = const Color(0xFF3A7BEF); // neonBlue

  @override
  void initState() {
    _toggleVisibility = true;
    _tooltipBehavior = TooltipBehavior(enable: true);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _buildHilo(),
    );
  }

  Widget buildSettings(BuildContext context) {
    return StatefulBuilder(
        builder: (BuildContext context, StateSetter stateSetter) {
      return Row(
        children: <Widget>[
          Text('Show indication for\nsame values ',
              style: TextStyle(
                color: textColor,
                fontSize: 16,
              )),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: SizedBox(
                width: 90,
                child: CheckboxListTile(
                    activeColor: accentColor,
                    value: _toggleVisibility,
                    onChanged: (bool? value) {
                      setState(() {
                        _toggleVisibility = value!;
                        stateSetter(() {});
                      });
                    })),
          )
        ],
      );
    });
  }

  SfCartesianChart _buildHilo() {
    return SfCartesianChart(
      plotAreaBorderWidth: 0,
      title: ChartTitle(
        text: 'AAPL - 2016',
        textStyle: TextStyle(color: textColor),
      ),
      primaryXAxis: DateTimeAxis(
          dateFormat: DateFormat.MMMd(),
          minimum: DateTime(2016),
          maximum: DateTime(2016, 07),
          intervalType: DateTimeIntervalType.months,
          majorGridLines: const MajorGridLines(width: 0)),
      primaryYAxis: const NumericAxis(
          interval: 20,
          minimum: 60,
          maximum: 140,
          labelFormat: r'${value}',
          axisLine: AxisLine(width: 0),
          labelStyle: TextStyle(color: Color(0xFFCED5E5))), // matrixSilver
      series: _getHiloSeries(),
      tooltipBehavior: _tooltipBehavior,
      backgroundColor: const Color(0xFF1E2740).withOpacity(0.6), // techNavy
    );
  }

  List<HiloSeries<ChartData, DateTime>> _getHiloSeries() {
    return <HiloSeries<ChartData, DateTime>>[
      HiloSeries<ChartData, DateTime>(
          dataSource: _injectData(),
          color: accentColor,
          name: 'AAPL',
          showIndicationForSameValues: _toggleVisibility,
          xValueMapper: (ChartData sales, _) => sales.x as DateTime,
          lowValueMapper: (ChartData sales, _) => sales.low,
          highValueMapper: (ChartData sales, _) => sales.high)
    ];
  }

  List<ChartData> _injectData() {
    return kStockData;
  }
}
