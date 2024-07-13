import 'package:flutter/material.dart';
import 'package:halfcontainerproject/provider/dropdown_provider.dart';
import 'package:halfcontainerproject/screens/saved_chart_page.dart';
import 'package:halfcontainerproject/screens/view_chart_page.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<ProviderDropDown>(context);
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
                          provider.setChart(value);
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
            Center(
              child: Container(
                height: 500,
                margin: const EdgeInsets.all(10),
                child: Column(
                  children: [
                    //textfield area
                    const SizedBox(height: 120),
                    SizedBox(
                      height: 300,
                      child: Consumer<ProviderDropDown>(
                        builder: (context, provider, child) {
                          int index =
                              provider.chartList.indexOf(provider.selectChart);
                          return provider.chartSample[index];
                        },
                      ),
                    ),
                  ],
                ),
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
            SizedBox(
              height: 50,
              width: 200,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const ViewChart()),
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
                  'View Chart',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
            SizedBox(
              height: 50,
              width: 200,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const SaveCharts()),
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
          ],
        ),
      ),
    );
  }
}
