import 'package:flutter/material.dart';
import 'package:my_first_app/data/other_data.dart';

class Other extends StatefulWidget {
  const Other({super.key});

  @override
  State<Other> createState() => _OtherState();
}

class _OtherState extends State<Other> {
  Color borderColor = Colors.black87;
  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      padding: EdgeInsets.all(16),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: 16,
        crossAxisSpacing: 16,
      ),
      itemCount: gridData.length,
      itemBuilder: (context, index) {
        // final data = gridData[index];
        return GestureDetector(
          onTap: () {
            setState(() {
              borderColor == Colors.black87
                  ? borderColor = Colors.deepPurple
                  : borderColor = Colors.black87;
            });
          },
          child: Container(
            key: Key(index.toString()),
            // color: Colors.black,
            padding: EdgeInsets.all(1.25),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(16)),
              color: borderColor,
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: Image.asset(gridData[index].imagePath),
            ),
          ),
        );
      },
    );
  }
}
