// ignore_for_file: unused_local_variable, sized_box_for_whitespace, use_build_context_synchronously

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:halfcontainerproject/model/chart_model.dart';
import 'package:halfcontainerproject/provider/dropdown_provider.dart';
import 'package:halfcontainerproject/screens/saved_chart_page.dart';
import 'package:provider/provider.dart';

class ViewChart extends StatelessWidget {
  final String chartType;
  final List<double> data;

  const ViewChart({Key? key, required this.chartType, required this.data})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<ProviderDropDown>(context, listen: false);

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        automaticallyImplyLeading: false,
        title: Text(
          '$chartType ',
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w800),
        ),
      ),
      body: Center(
        child: Container(height: 400, width: 500, child: _buildChart()),
      ),
      bottomNavigationBar: BottomAppBar(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            SizedBox(
              height: 50,
              width: 200,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(Colors.blue),
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(18.0),
                      side: const BorderSide(color: Colors.white),
                    ),
                  ),
                ),
                child: const Text(
                  'Go Back',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
            SizedBox(
              height: 50,
              width: 200,
              child: ElevatedButton(
                onPressed: () async {
                  var chartProvider =
                      Provider.of<ProviderDropDown>(context, listen: false);
                  var chartData = ChartData(chartType, data);
                  await chartProvider.saveChart(chartData);
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      backgroundColor: Colors.green,
                      content: Text('Chart saved successfully!'),
                    ),
                  );
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const SavedCharts()));
                },
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(Colors.blue),
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(18.0),
                      side: const BorderSide(color: Colors.white),
                    ),
                  ),
                ),
                child: const Text(
                  'Save Chart',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildChart() {
    switch (chartType) {
      case 'Line Chart 1':
      case 'Line Chart 2':
        return LineChart(LineChartData(
          lineBarsData: [
            LineChartBarData(
              spots: data
                  .asMap()
                  .entries
                  .map((e) => FlSpot(e.key.toDouble(), e.value))
                  .toList(),
              isCurved: true,
              color: const Color.fromARGB(255, 255, 191, 1),
              barWidth: 2,
              belowBarData: BarAreaData(show: false),
            ),
          ],
        ));
      case 'Bar Chart 1':
      case 'Bar Chart 2':
        return BarChart(BarChartData(
          barGroups: data
              .asMap()
              .entries
              .map((e) => BarChartGroupData(
                    x: e.key,
                    barRods: [
                      BarChartRodData(
                        toY: e.value,
                        color: const Color.fromARGB(255, 74, 3, 204),
                      )
                    ],
                  ))
              .toList(),
        ));
      case 'Pie Chart 1':
      case 'Pie Chart 2':
        return PieChart(PieChartData(
          sections: data
              .asMap()
              .entries
              .map((e) => PieChartSectionData(
                    value: e.value,
                    color: Colors.primaries[e.key % Colors.primaries.length],
                    title: '${e.value}',
                  ))
              .toList(),
        ));
      default:
        return Container();
    }
  }
}
