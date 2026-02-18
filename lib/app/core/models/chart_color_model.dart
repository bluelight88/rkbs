import 'package:intl/intl.dart';

import '../../utils/services/util_methods.dart';

class ChartColorModel {
  String label;
  double y;
  String markerColor;

  ChartColorModel({
    required this.label,
    required this.y,
    required this.markerColor,
  });

  factory ChartColorModel.fromJson(Map<String, dynamic> json) =>
      ChartColorModel(
        label: UtilMethods.instance.stringValueParser(json["label"]),
        y: UtilMethods.instance.doubleValueParser(json["y"]),
        markerColor: UtilMethods.instance.stringValueParser(
          json["markerColor"],
        ),
      );
}

class ChartModel {
  String x;
  int y;

  ChartModel({required this.x, required this.y});

  factory ChartModel.fromJson(Map<String, dynamic> json) => ChartModel(
    x: UtilMethods.instance.stringValueParser(json["x"]),
    y: UtilMethods.instance.intValueParser(json["y"]),
  );
}

class ChartModelWithDateTime {
  DateTime x;
  int y;

  ChartModelWithDateTime({required this.x, required this.y});

  factory ChartModelWithDateTime.fromJson(Map<String, dynamic> json) =>
      ChartModelWithDateTime(
        x:
            (json["x"] == false || json["x"] == null)
                ? DateTime.now()
                : DateFormat("yyyy-MM-dd hh:mm:ss").parse(json["x"]),
        y: UtilMethods.instance.intValueParser(json["y"]),
      );
}
