import 'package:flutter/material.dart';
import 'package:halfcontainerproject/provider/dropdown_provider.dart';
import 'package:halfcontainerproject/screens/view_chart_page.dart';
import 'package:provider/provider.dart';

class SavedCharts extends StatelessWidget {
  const SavedCharts({super.key});

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<ProviderDropDown>(context, listen: false);

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
      ),
      bottomNavigationBar: BottomAppBar(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
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
          ],
        ),
      ),
      body: SafeArea(
        child: ListView.builder(
          itemCount: provider.savedCharts.length,
          itemBuilder: (context, index) {
            final chart = provider.savedCharts[index];
            return Card(
              child: ListTile(
                title: Text(
                  chart.chartType,
                  style: const TextStyle(
                      fontSize: 12, fontWeight: FontWeight.normal),
                ),
                subtitle: Text(
                  'Data: ${chart.data.join(', ')}',
                  style: const TextStyle(
                      fontSize: 12, fontWeight: FontWeight.normal),
                ),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ViewChart(
                        chartType: chart.chartType,
                        data: chart.data,
                      ),
                    ),
                  );
                },
              ),
            );
          },
        ),
      ),
    );
  }
}
