import 'package:flutter/material.dart';
import 'package:halfcontainerproject/provider/provider_color.dart';
import 'package:provider/provider.dart';

class SLess extends StatelessWidget {
  const SLess({super.key});

  @override
  Widget build(BuildContext context) {
    var controller = Provider.of<ProviderColor>(context);
    return Container(
      height: MediaQuery.of(context).size.height / 2,
      width: MediaQuery.of(context).size.width,
      color: controller.isClick ? Colors.green : Colors.red,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Center(
            child: Text(
              'Stateless Provider',
              style: TextStyle(fontSize: 24, color: Colors.white),
            ),
          ),
          const SizedBox(height: 40),
          SizedBox(
              height: 60,
              width: 200,
              child: Consumer<ProviderColor>(
                builder: (context, value, child) {
                  return ElevatedButton(
                    onPressed: () {
                      controller.onFunction();
                    },
                    child: const Text('Click'),
                  );
                },
              )),
        ],
      ),
    );
  }
}
