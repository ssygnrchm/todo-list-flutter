import 'package:flutter/material.dart';
import 'package:my_first_app/data/other_data.dart';

class Other extends StatefulWidget {
  const Other({super.key});

  @override
  State<Other> createState() => _OtherState();
}

class _OtherState extends State<Other> {
  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      padding: EdgeInsets.all(16),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        mainAxisSpacing: 8,
        crossAxisSpacing: 8,
      ),
      itemCount: gridData.length,
      itemBuilder: (context, index) {
        final data = gridData[index];
        return Container(
          color: data.color,
          child: Text(data.name, style: TextStyle(fontSize: 16)),
        );
      },
    );
  }
}
