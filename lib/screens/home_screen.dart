// ignore_for_file: unused_local_variable, recursive_getters, no_leading_underscores_for_local_identifiers

import 'package:flutter/material.dart';
import 'package:halfcontainerproject/provider/dropdown_provider.dart';
import 'package:halfcontainerproject/screens/saved_chart_page.dart';
import 'package:halfcontainerproject/screens/view_chart_page.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<ProviderDropDown>(context, listen: false);
    TextEditingController _controller = TextEditingController();

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        leading: const Padding(
          padding: EdgeInsets.only(left: 8.0),
          child: CircleAvatar(child: Icon(Icons.show_chart)),
        ),
        title: const Text('Chart Patterns'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Consumer<ProviderDropDown>(
              builder: (context, value, child) {
                return Padding(
                  padding:
                      const EdgeInsets.only(top: 40, left: 20.0, right: 10),
                  child: Container(
                    height: 60,
                    width: 170,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.blue,
                    ),
                    child: Center(
                      child: DropdownButton(
                        style:
                            const TextStyle(color: Colors.black, fontSize: 17),
                        underline: const SizedBox(),
                        value: provider.selectChart,
                        onChanged: (value) {
                          provider.setChart(value!);
                        },
                        items: provider.chartList
                            .map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                      ),
                    ),
                  ),
                );
              },
            ),
            // Display selected chart and input fields here
            Container(
              height: 500,
              margin: const EdgeInsets.all(10),
              child: Column(
                children: [
                  const SizedBox(height: 35),
                  //textfield area for values inserting
                  const Text(
                    'Enter numbers using coma',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
                  ),
                  const SizedBox(height: 10),
                  SizedBox(
                    width: 300,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        TextField(
                          controller: _controller,
                          keyboardType: TextInputType.number,
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            focusedBorder: OutlineInputBorder(),
                            hintText: "Enter values",
                            hintStyle: TextStyle(
                                fontSize: 13, fontWeight: FontWeight.normal),
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 20),
                  Expanded(
                    child: SizedBox(
                      height: 300,
                      child: Consumer<ProviderDropDown>(
                        builder: (context, provider, child) {
                          int index =
                              provider.chartList.indexOf(provider.selectChart);
                          return provider.chartSample[index];
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      //bottomNavigationbar
      bottomNavigationBar: BottomAppBar(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Expanded(
              child: SizedBox(
                height: 50,
                width: 200,
                child: ElevatedButton(
                  onPressed: () {
                    // Get the data from the TextField
                    List<double> data = _controller.text
                        .split(',')
                        .map((e) => double.tryParse(e.trim()) ?? 0)
                        .toList();

                    // Check if the data is empty or not before navigating
                    if (data.isNotEmpty) {
                      // Update the chart data in the provider
                      provider.updateChartData(provider.selectChart, data);
                      // Navigate to ViewChart with the updated data
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ViewChart(
                            chartType: provider.selectChart,
                            data: provider.getChartData(provider.selectChart)!,
                          ),
                        ),
                      );
                    } else {
                      // Handle case where no valid data is entered
                      showDialog(
                        context: context,
                        builder: (context) => AlertDialog(
                          title: const Text("Error"),
                          content: const Text(
                              "Please enter valid data in the TextField."),
                          actions: <Widget>[
                            TextButton(
                              child: const Text("OK"),
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                            ),
                          ],
                        ),
                      );
                    }
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
                    'View Chart',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
            ),
            Expanded(
              child: SizedBox(
                height: 50,
                width: 200,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const SavedCharts()),
                    );
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
                    'Saved Charts',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
