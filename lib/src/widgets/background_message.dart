import 'package:flutter/material.dart';

class BackgroundMessage extends StatelessWidget {
  final String text;
  final IconData icon;

  const BackgroundMessage({Key? key, required this.text, required this.icon})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final itemsColor = Colors.grey[500];

    return Center(
      heightFactor: 2,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            icon,
            color: itemsColor,
            size: 128,
          ),
          const SizedBox(height: 16),
          Text(
            text,
            style: TextStyle(
              fontSize: 16,
              color: itemsColor,
            ),
          )
        ],
      ),
    );
  }
}
