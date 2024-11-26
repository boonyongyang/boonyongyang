import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import '../../core/style/style.dart';
import '../../data.dart';
import 'chart_data.dart';
import 'stock_item.dart';

class HiloOpenCloseChart extends StatefulWidget {
  const HiloOpenCloseChart({super.key, required this.stock});

  final StockItem stock;

  @override
  HiloOpenCloseChartState createState() => HiloOpenCloseChartState();
}

class HiloOpenCloseChartState extends State<HiloOpenCloseChart> {
  late bool _toggleVisibility;
  TrackballBehavior? _trackballBehavior;

  @override
  void initState() {
    _toggleVisibility = true;
    _trackballBehavior = TrackballBehavior(
        enable: true, activationMode: ActivationMode.singleTap);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _buildHiloOpenClose(),
    );
  }

  Widget buildSettings(BuildContext context) {
    return StatefulBuilder(
        builder: (BuildContext context, StateSetter stateSetter) {
      return Row(
        children: <Widget>[
          const Text('Show indication for\nsame values ',
              style: TextStyle(
                color: AppColors.textColor,
                fontSize: 16,
              )),
          Padding(
              padding: const EdgeInsets.all(8.0),
              child: SizedBox(
                width: 90,
                child: CheckboxListTile(
                    activeColor: AppColors.primaryColor,
                    value: _toggleVisibility,
                    onChanged: (bool? value) {
                      setState(() {
                        _toggleVisibility = value!;
                        stateSetter(() {});
                      });
                    }),
              ))
        ],
      );
    });
  }

  SfCartesianChart _buildHiloOpenClose() {
    return SfCartesianChart(
      plotAreaBorderWidth: 0,
      title: const ChartTitle(text: 'AAPL - 2016'),
      primaryXAxis: DateTimeAxis(
          dateFormat: DateFormat.MMM(),
          interval: 3,
          intervalType: DateTimeIntervalType.months,
          minimum: DateTime(2016),
          maximum: DateTime(2017),
          majorGridLines: const MajorGridLines(width: 0)),
      primaryYAxis: const NumericAxis(
          minimum: 60,
          maximum: 140,
          interval: 20,
          labelFormat: r'${value}',
          axisLine: AxisLine(width: 0)),
      series: _getHiloOpenCloseSeries(),
      trackballBehavior: _trackballBehavior,
    );
  }

  List<HiloOpenCloseSeries<ChartData, DateTime>> _getHiloOpenCloseSeries() {
    return <HiloOpenCloseSeries<ChartData, DateTime>>[
      HiloOpenCloseSeries<ChartData, DateTime>(
          dataSource: _injectData(),
          name: 'AAPL',
          showIndicationForSameValues: _toggleVisibility,
          xValueMapper: (ChartData sales, _) => sales.x as DateTime,
          lowValueMapper: (ChartData sales, _) => sales.low,
          highValueMapper: (ChartData sales, _) => sales.high,
          openValueMapper: (ChartData sales, _) => sales.open,
          closeValueMapper: (ChartData sales, _) => sales.close)
    ];
  }

  List<ChartData> _injectData() {
    return kStockData;
  }
}
