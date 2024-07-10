import 'package:flutter/material.dart';

class SFul extends StatefulWidget {
  const SFul({super.key});

  @override
  State<SFul> createState() => _SFulState();
}

class _SFulState extends State<SFul> {
  bool isClick = false;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height / 2,
      width: MediaQuery.of(context).size.width,
      color: isClick ? Colors.amber : Colors.blue,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Center(
            child: Text(
              'Stateful setState',
              style: TextStyle(fontSize: 24, color: Colors.white),
            ),
          ),
          const SizedBox(height: 40),
          SizedBox(
            height: 60,
            width: 200,
            child: ElevatedButton(
              onPressed: () {
                setState(() {
                  isClick = !isClick;
                });
              },
              child: const Text('Click'),
            ),
          ),
        ],
      ),
    );
  }
}
