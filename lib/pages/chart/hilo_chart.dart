import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import '../../core/style/style.dart';
import '../../data.dart';
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
                    })),
          )
        ],
      );
    });
  }

  SfCartesianChart _buildHilo() {
    return SfCartesianChart(
      plotAreaBorderWidth: 0,
      title: const ChartTitle(text: 'AAPL - 2016'),
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
          axisLine: AxisLine(width: 0)),
      series: _getHiloSeries(),
      tooltipBehavior: _tooltipBehavior,
    );
  }

  List<HiloSeries<ChartData, DateTime>> _getHiloSeries() {
    return <HiloSeries<ChartData, DateTime>>[
      HiloSeries<ChartData, DateTime>(
          dataSource: _injectData(),
          color: AppColors.primaryColor,
          name: 'AAPL',
          showIndicationForSameValues: _toggleVisibility,
          xValueMapper: (ChartData sales, _) => sales.x as DateTime,
          lowValueMapper: (ChartData sales, _) => sales.low,
          highValueMapper: (ChartData sales, _) => sales.high)
    ];
  }

  List<ChartData> _injectData() {
    return kStockData;
    // final List<ChartData> chartData = <ChartData>[];
    // for (int i = 0; i < widget.stock.data.length; i++) {
    //   chartData.add(ChartData(
    //       widget.stock.data[i].date,
    //       widget.stock.data[i].low,
    //       widget.stock.data[i].high,
    //       widget.stock.data[i].open,
    //       widget.stock.data[i].close,
    //       widget.stock.data[i].volume));
    // }
    // return chartData;
  }
}
