import 'package:flutter/material.dart';

class NewsContainer extends StatelessWidget {
  final String imageSource;

  final String title;

  const NewsContainer({
    super.key,
    required this.imageSource,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 120,
        child: Padding(
          padding: const EdgeInsets.all(5),
          child: Row(
            children: [
              Expanded(
                child: SizedBox(
                    height: 50, width: 60, child: Image.network(imageSource)),
              ),
              SizedBox(width: 5),
              Expanded(
                child: Text(
                  title,
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        ));
  }
}
