// ignore_for_file: prefer_final_fields

import 'package:flutter/material.dart';
import 'package:halfcontainerproject/model/chart_model.dart';
import 'package:halfcontainerproject/screens/widgets/bar_chart/bar_widget.dart';
import 'package:halfcontainerproject/screens/widgets/line_chart/linechart_widget.dart';
import 'package:halfcontainerproject/screens/widgets/pie_chart/pie_widget.dart';
import 'package:hive/hive.dart';

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
  List<ChartData> _saveCharts = [];

  Map<String, List<double>> _chartData = {};
  List<ChartData> get savedCharts => _saveCharts;

  ProviderDropDown() {
    _loadSavedCharts();
  }

  setChart(String value) {
    selectChart = value;
    notifyListeners();
  }

  List<double>? getChartData(String chartType) {
    return _chartData[chartType];
  }

  void updateChartData(String chartType, List<double> data) {
    try {
      _chartData[chartType] = data;
      notifyListeners();
    } catch (e) {
      print('Error update chart data: $e');
    }
  }

  Future<void> saveChart(ChartData chartData) async {
    try {
      var box = await Hive.openBox<ChartData>('charts');
      await box.add(chartData);
      _saveCharts.add(chartData);
      notifyListeners();
    } catch (e) {
      print('Error saving chart data: $e');
    }
  }

  Future<void> _loadSavedCharts() async {
    try {
      var box = await Hive.openBox<ChartData>('charts');
      _saveCharts = box.values.toList();
      notifyListeners();
    } catch (e) {
      print('Error load saved chart data: $e');
    }
  }
}
