/// Package imports
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

/// Chart import
import 'package:syncfusion_flutter_charts/charts.dart';

import '../../core/style/style.dart';
import '../../data.dart';
import '../../widgets/custom_button.dart';

/// Local imports
import 'stock_item.dart';
import 'chart_data.dart';

///Renders default Candle series chart
class CandleChart extends StatefulWidget {
  ///Creates default Candle series chart
  const CandleChart({super.key, required this.stock, this.selectedIndexes});

  final StockItem stock;
  final List<int>? selectedIndexes;

  @override
  CandleChartState createState() => CandleChartState();
}

class CandleChartState extends State<CandleChart> {
  late bool _enableSolidCandle;
  late bool _toggleVisibility;
  late double _width;
  late double _space;
  late double _borderRadius;
  TrackballBehavior? _trackballBehavior;

  final Color primaryColor = AppColors.primaryColor;
  final Color textColor = AppColors.textColor;
  List<int>? _selectedIndexes;

  @override
  void initState() {
    _width = 0.8;
    _space = 0.2;
    _borderRadius = 5;
    _enableSolidCandle = false;
    _toggleVisibility = true;
    _selectedIndexes = widget.selectedIndexes;
    _trackballBehavior = TrackballBehavior(
        enable: true, activationMode: ActivationMode.singleTap);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.stock.name),
      ),
      body: _buildCandle(),
    );
  }

  Widget buildSettings(BuildContext context) {
    return StatefulBuilder(
        builder: (BuildContext context, StateSetter stateSetter) {
      return ListView(
        shrinkWrap: true,
        children: <Widget>[
          SizedBox(
            child: Row(
              children: <Widget>[
                Text('Enable solid candles',
                    style: TextStyle(
                      color: textColor,
                      fontSize: 16,
                    )),
                SizedBox(
                    width: 90,
                    child: CheckboxListTile(
                        activeColor: primaryColor,
                        value: _enableSolidCandle,
                        onChanged: (bool? value) {
                          setState(() {
                            _enableSolidCandle = value!;
                            stateSetter(() {});
                          });
                        }))
              ],
            ),
          ),
          SizedBox(
            child: Row(
              children: <Widget>[
                Text('Show indication for  \nsame values',
                    style: TextStyle(
                      color: textColor,
                      fontSize: 16,
                    )),
                SizedBox(
                    width: 87,
                    child: CheckboxListTile(
                        activeColor: primaryColor,
                        value: _toggleVisibility,
                        onChanged: (bool? value) {
                          setState(() {
                            _toggleVisibility = value!;
                            stateSetter(() {});
                          });
                        }))
              ],
            ),
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 15, 0, 0),
                child: Text('Width  ', style: TextStyle(color: textColor)),
              ),
              Container(
                padding: const EdgeInsets.fromLTRB(95, 0, 0, 0),
                child: CustomDirectionalButtons(
                  maxValue: 1,
                  initialValue: _width,
                  onChanged: (double val) {
                    setState(() {
                      _width = val;
                    });
                  },
                  step: 0.1,
                  loop: true,
                  iconColor: textColor,
                  style: TextStyle(fontSize: 16.0, color: textColor),
                ),
              ),
            ],
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 15, 0, 0),
                child: Text('Spacing  ', style: TextStyle(color: textColor)),
              ),
              Container(
                padding: const EdgeInsets.fromLTRB(85, 0, 0, 0),
                child: CustomDirectionalButtons(
                  maxValue: 1,
                  initialValue: _space,
                  onChanged: (double val) {
                    setState(() {
                      _space = val;
                    });
                  },
                  step: 0.1,
                  loop: true,
                  padding: 5.0,
                  iconColor: textColor,
                  style: TextStyle(fontSize: 16.0, color: textColor),
                ),
              )
            ],
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 15, 0, 0),
                child:
                    Text('Border Radius  ', style: TextStyle(color: textColor)),
              ),
              Container(
                padding: const EdgeInsets.fromLTRB(55, 0, 0, 0),
                child: CustomDirectionalButtons(
                  maxValue: 10,
                  initialValue: _borderRadius,
                  onChanged: (double val) {
                    setState(() {
                      _borderRadius = val;
                    });
                  },
                  loop: true,
                  padding: 5.0,
                  iconColor: textColor,
                  style: TextStyle(fontSize: 16.0, color: textColor),
                ),
              )
            ],
          ),
        ],
      );
    });
  }

  SfCartesianChart _buildCandle() {
    return SfCartesianChart(
      plotAreaBorderWidth: 0,
      title: ChartTitle(text: '${widget.stock.symbol} - 2016'),
      primaryXAxis: DateTimeAxis(
          autoScrollingDelta: 3,
          autoScrollingMode: AutoScrollingMode.start,
          dateFormat: DateFormat.MMM(),
          interval: 1,
          intervalType: DateTimeIntervalType.months,
          minimum: DateTime(2016),
          maximum: DateTime(2016, 10),
          majorGridLines: const MajorGridLines(width: 0)),
      primaryYAxis: const NumericAxis(
          minimum: 80,
          maximum: 120,
          interval: 20,
          labelFormat: r'${value}',
          axisLine: AxisLine(width: 0)),
      series: _getCandleSeries(),
      trackballBehavior: _trackballBehavior,
      selectionGesture: ActivationMode.singleTap,
      zoomPanBehavior: ZoomPanBehavior(
        enableMouseWheelZooming: true,
        enablePinching: true,
        enablePanning: true,
        // Adjust zoom mode as needed (ZoomMode.x, ZoomMode.y, or ZoomMode.xy)
        zoomMode: ZoomMode.x,
        maximumZoomLevel: 0.5, // Set maximum zoom level
        enableDoubleTapZooming: true, // Enable double-tap zooming
      ),
    );
  }

  List<CandleSeries<ChartData, DateTime>> _getCandleSeries() {
    return <CandleSeries<ChartData, DateTime>>[
      CandleSeries<ChartData, DateTime>(
        enableSolidCandles: _enableSolidCandle,
        dataSource: _injectStockData(),
        name: widget.stock.symbol,
        showIndicationForSameValues: _toggleVisibility,
        xValueMapper: (ChartData sales, _) => sales.x as DateTime,

        /// High, low, open and close values used to render the candle series.
        lowValueMapper: (ChartData sales, _) => sales.low,
        highValueMapper: (ChartData sales, _) => sales.high,
        openValueMapper: (ChartData sales, _) => sales.open,
        closeValueMapper: (ChartData sales, _) => sales.close,
        opacity: _space,
        // selectionBehavior: SelectionBehavior(
        //   enable: true,
        //   selectedColor: Colors.red,
        //   unselectedColor: Colors.blue,
        //   selectedOpacity: 1,
        //   unselectedOpacity: 0.2,
        // ),
        // initialSelectedDataIndexes: widget.selectedIndexes ?? [],
        // pointColorMapper: (ChartData data, int index) {
        //   return widget.selectedIndexes != null &&
        //           widget.selectedIndexes!.contains(index)
        //       ? Colors.red
        //       : Colors.blue;
        // },
        // width: _width,
        // borderRadius: BorderRadius.all(Radius.circular(_borderRadius)),
      )
    ];
  }

  List<ChartData> _injectStockData() {
    return kStockData;
  }
}
