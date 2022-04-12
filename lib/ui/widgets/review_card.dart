import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class ReviewCard extends StatelessWidget {
  const ReviewCard({
    Key? key,
    required this.name,
    required this.review,
    required this.date,
    required this.rate,
  }) : super(key: key);

  final String name;
  final String review;
  final String date;
  final double rate;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    name,
                    style: const TextStyle(
                      fontFamily: 'Montserrat',
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Row(
                    children: [
                      RatingBar.builder(
                        initialRating: rate,
                        itemSize: 18,
                        minRating: 1,
                        direction: Axis.horizontal,
                        allowHalfRating: true,
                        ignoreGestures: true,
                        itemCount: 5,
                        itemPadding: const EdgeInsets.symmetric(horizontal: 0.0),
                        itemBuilder: (context, _) => const Icon(
                          Icons.star,
                          color: Color(0xff009C95),
                        ),
                        onRatingUpdate: (rating) {
                          print(rating);
                        },
                      ),
                    ],
                  ),
                ],
              ),

              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8),
                child: Text(
                  review,
                  style: const TextStyle(
                    fontFamily: 'Montserrat',
                    fontSize: 14,
                  ),
                  textAlign: TextAlign.start,
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    date,
                    style: const TextStyle(
                      fontFamily: 'Montserrat',
                      fontSize: 14,
                    ),
                  ),
                  // Row(
                  //   children: [
                  //     Image.asset(
                  //       'assets/images/single_product/like.png',
                  //       height: 20,
                  //       width: 20,
                  //     ),
                  //     const SizedBox(
                  //       width: 8,
                  //     ),
                  //     const Text(
                  //       '3',
                  //       style: TextStyle(
                  //         fontFamily: 'Montserrat',
                  //         fontSize: 14,
                  //       ),
                  //     ),
                  //     const SizedBox(
                  //       width: 8,
                  //     ),
                  //     Image.asset(
                  //       'assets/images/single_product/dislike.png',
                  //       height: 20,
                  //       width: 20,
                  //     ),
                  //     const SizedBox(
                  //       width: 8,
                  //     ),
                  //     const Text(
                  //       '0',
                  //       style: TextStyle(
                  //         fontFamily: 'Montserrat',
                  //         fontSize: 14,
                  //       ),
                  //     ),
                  //     const SizedBox(
                  //       width: 8,
                  //     ),
                  //   ],
                  // ),
                ],
              )
            ],
          ),
        )
      ],
    );
  }
}
