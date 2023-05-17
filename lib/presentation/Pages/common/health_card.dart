import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HealthCard extends StatelessWidget {
  final String title;
  final String data;
  final Color color;
  final String image;

  const HealthCard({
    Key? key,
    this.title = " ",
    this.data = " ",
    this.color = const Color(0xFF2086fd),
    this.image = " ",
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 240,
      margin: const EdgeInsets.symmetric(vertical: 10),
      padding: const EdgeInsets.symmetric(vertical: 10),
      decoration: BoxDecoration(
          color: color,
          borderRadius: const BorderRadius.all(Radius.circular(20))),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Text(title,
              style:
                  const TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
          Image.asset(image, width: 70),
          Text(data),
        ],
      ),
    );
  }
}
