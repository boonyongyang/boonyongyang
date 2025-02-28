/// Package imports
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

/// Chart import
import 'package:syncfusion_flutter_charts/charts.dart';

import '../../../core/style/style.dart';
import '../../../data.dart';
import '../../../shared/widgets/custom_button.dart';

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
  // List<int>? _selectedIndexes;

  @override
  void initState() {
    _width = 0.8;
    _space = 0.2;
    _borderRadius = 5;
    _enableSolidCandle = false;
    _toggleVisibility = true;
    // _selectedIndexes = widget.selectedIndexes;
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
          // autoScrollingDeltaUnit: DateTimeIntervalType.months,
          autoScrollingDelta: 3,
          autoScrollingMode: AutoScrollingMode.start,
          dateFormat: DateFormat.MMM(),
          interval: 1,
          intervalType: DateTimeIntervalType.months,
          minimum: DateTime(2016),
          maximum: DateTime(2016, 10),
          labelIntersectAction: AxisLabelIntersectAction.hide,
          isVisible: true,
          majorGridLines: const MajorGridLines(width: 0)),
      primaryYAxis: const NumericAxis(
          minimum: 80,
          maximum: 120,
          interval: 20,
          labelFormat: r'${value}',
          isVisible: true,
          labelIntersectAction: AxisLabelIntersectAction.hide,
          axisLine: AxisLine(width: 0)),
      series: _getCandleSeries(),
      trackballBehavior: _trackballBehavior,
      selectionGesture: ActivationMode.singleTap,
      zoomPanBehavior: ZoomPanBehavior(
        enableMouseWheelZooming: true,
        enablePinching: true,
        enablePanning: true,
        zoomMode: ZoomMode.x,
        maximumZoomLevel: 0.5,
        enableDoubleTapZooming: true,
      ),
      // Ensure the chart maintains proper constraints
      margin: const EdgeInsets.all(10),
      onActualRangeChanged: (ActualRangeChangedArgs args) {
        // Handle range change if needed
      },
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
        lowValueMapper: (ChartData sales, _) => sales.low,
        highValueMapper: (ChartData sales, _) => sales.high,
        openValueMapper: (ChartData sales, _) => sales.open,
        closeValueMapper: (ChartData sales, _) => sales.close,
        width: _width,
        spacing: _space,
        borderRadius: BorderRadius.all(Radius.circular(_borderRadius)),
        emptyPointSettings: const EmptyPointSettings(mode: EmptyPointMode.zero),
        // Use only needed properties to avoid rendering issues
        animationDuration:
            0, // Disable animation to prevent layout issues during resize
      )
    ];
  }

  List<ChartData> _injectStockData() {
    return kStockData;
  }
}
