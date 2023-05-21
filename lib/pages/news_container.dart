import 'package:flutter/material.dart';

class newsDetails extends StatelessWidget {
  final String urlToImage;
  final String title;
  final String author;
  const newsDetails({
    super.key,
    required this.urlToImage,
    required this.title,
    required this.author,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              // SizedBox(
              //   width: double.infinity,
              //   child: Image.network(
              //     // 'https://picsum.photos/250?image=9',
              //     urlToImage,
              //     height: 140,
              //     fit: BoxFit.fitWidth,
              //   ),
              // ),
              SizedBox(
                height: 5,
              ),

              Align(
                alignment: Alignment.topLeft,
                child: RichText(
                  textAlign: TextAlign.start,
                  text: TextSpan(
                    style: DefaultTextStyle.of(context).style,
                    children: <TextSpan>[
                      TextSpan(
                        text: 'Title:  ',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Theme.of(context).primaryColor,
                        ),
                      ),
                      TextSpan(
                        text: title,
                        style: TextStyle(
                          fontSize: 18,
                          // fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              SizedBox(
                height: 5,
              ),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: RichText(
                      text: TextSpan(
                        style: DefaultTextStyle.of(context).style,
                        children: <TextSpan>[
                          TextSpan(
                            text: 'Author:  ',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Theme.of(context).primaryColor,
                            ),
                          ),
                          TextSpan(
                            text: "~$author",
                            style: TextStyle(
                              fontSize: 18,
                              // fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all<Color>(
                          Theme.of(context).primaryColor),
                    ),
                    onPressed: () {},
                    child: Text(
                      'View Details',
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),

              SizedBox(
                height: 5,
              )
            ],
          ),
        ),
      ),
    );
  }
}
