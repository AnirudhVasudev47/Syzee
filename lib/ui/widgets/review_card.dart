import 'package:flutter/material.dart';

class ReviewCard extends StatelessWidget {
  const ReviewCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(right: 14.0),
          child: Image.asset(
            'assets/images/single_product/avatar.png',
            width: 46,
            height: 46,
          ),
        ),
        Expanded(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Andre Young',
                    style: TextStyle(
                      fontFamily: 'Montserrat',
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Row(
                    children: [
                      Image.asset(
                        'assets/images/single_product/star.png',
                        height: 14,
                        width: 14,
                      ),
                      Image.asset(
                        'assets/images/single_product/star.png',
                        height: 14,
                        width: 14,
                      ),
                      Image.asset(
                        'assets/images/single_product/star.png',
                        height: 14,
                        width: 14,
                      ),
                      Image.asset(
                        'assets/images/single_product/star.png',
                        height: 14,
                        width: 14,
                      ),
                      Image.asset(
                        'assets/images/single_product/star.png',
                        height: 14,
                        width: 14,
                      ),
                    ],
                  ),
                ],
              ),
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 8),
                child: Text(
                  'Wonderful dress, perfect gift for my girl for our anniversary!',
                  style: TextStyle(
                    fontFamily: 'Montserrat',
                    fontSize: 14,
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    '16 June 2021',
                    style: TextStyle(
                      fontFamily: 'Montserrat',
                      fontSize: 14,
                    ),
                  ),
                  Row(
                    children: [
                      Image.asset(
                        'assets/images/single_product/like.png',
                        height: 20,
                        width: 20,
                      ),
                      const SizedBox(
                        width: 8,
                      ),
                      const Text(
                        '3',
                        style: TextStyle(
                          fontFamily: 'Montserrat',
                          fontSize: 14,
                        ),
                      ),
                      const SizedBox(
                        width: 8,
                      ),
                      Image.asset(
                        'assets/images/single_product/dislike.png',
                        height: 20,
                        width: 20,
                      ),
                      const SizedBox(
                        width: 8,
                      ),
                      const Text(
                        '0',
                        style: TextStyle(
                          fontFamily: 'Montserrat',
                          fontSize: 14,
                        ),
                      ),
                      const SizedBox(
                        width: 8,
                      ),
                    ],
                  ),
                ],
              )
            ],
          ),
        )
      ],
    );
  }
}
