// ignore_for_file: prefer_typing_uninitialized_variables

import 'package:flutter/material.dart';
import 'package:halfcontainerproject/screens/widgets/bar_widget.dart';
import 'package:halfcontainerproject/screens/widgets/linechart_widget.dart';
import 'package:halfcontainerproject/screens/widgets/pie_widget.dart';

class ProviderDropDown extends ChangeNotifier {
  var chartList = [
    'Line Chart 1',
    'Bar Chart 1',
    'Pie Chart 1',
    'Line Chart 2',
    'Bar Chart 2',
    'Pie Chart 2'
  ];

  var selectChart = 'Line Chart 1';

  var chartSample = const [
    LineChartSample(),
    BarChartSample(),
    PieChartSample(),
    LineChartSample(),
    BarChartSample(),
    PieChartSample(),
  ];

  setChart(value) {
    selectChart = value;
    notifyListeners();
  }
}
