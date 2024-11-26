import 'dart:ui';

///Chart sample data
class ChartData {
  /// Holds the datapoint values like x, y, etc.,
  ChartData(
      {this.x,
      this.y,
      this.xValue,
      this.yValue,
      this.secondSeriesYValue,
      this.thirdSeriesYValue,
      this.pointColor,
      this.size,
      this.text,
      this.open,
      this.close,
      this.low,
      this.high,
      this.volume});

  /// Holds x value of the datapoint
  final dynamic x;

  /// Holds y value of the datapoint
  final num? y;

  /// Holds x value of the datapoint
  final dynamic xValue;

  /// Holds y value of the datapoint
  final num? yValue;

  /// Holds y value of the datapoint(for 2nd series)
  final num? secondSeriesYValue;

  /// Holds y value of the datapoint(for 3nd series)
  final num? thirdSeriesYValue;

  /// Holds point color of the datapoint
  final Color? pointColor;

  /// Holds size of the datapoint
  final num? size;

  /// Holds datalabel/text value mapper of the datapoint
  final String? text;

  /// Holds open value of the datapoint
  final num? open;

  /// Holds close value of the datapoint
  final num? close;

  /// Holds low value of the datapoint
  final num? low;

  /// Holds high value of the datapoint
  final num? high;

  /// Holds open value of the datapoint
  final num? volume;
}

/// Chart Sales Data
class SalesData {
  /// Holds the datapoint values like x, y, etc.,
  SalesData(this.x, this.y, [this.date, this.color]);

  /// X value of the data point
  final dynamic x;

  /// y value of the data point
  final dynamic y;

  /// color value of the data point
  final Color? color;

  /// Date time value of the data point
  final DateTime? date;
}

// /// Circular progress bar color
// class ProgressBarColor {
//   /// creating constructor of progress bar color.
//   ProgressBarColor(this.model);

//   /// Holds the SampleModel information.
//   final SampleModel model;

//   /// Get the pointer color based on the theme.
//   Color? get pointerColor =>
//       model.themeData.useMaterial3 ? model.primaryColor.withOpacity(0.8) : null;

//   /// Get the axis line color based on the theme.
//   Color get axisLineColor => model.themeData.useMaterial3
//       ? model.primaryColor.withAlpha(30)
//       : const Color.fromARGB(30, 0, 169, 181);

//   /// Get the buffer color based on the theme.
//   Color get bufferColor => model.themeData.useMaterial3
//       ? model.primaryColor.withAlpha(90)
//       : const Color.fromARGB(90, 0, 169, 181);
// }
