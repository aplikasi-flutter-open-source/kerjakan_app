import 'package:flutter/material.dart';

class RatingStar extends StatelessWidget {
  final int rating;
  RatingStar(this.rating);
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(
          Icons.star,
          size: 14,
          color: rating >= 1.0
              ? Color(0xFFFBBF12)
              : Color(0xFFFBBF12).withOpacity(0.25),
        ),
        Icon(
          Icons.star,
          size: 14,
          color: rating >= 2.0
              ? Color(0xFFFBBF12)
              : Color(0xFFFBBF12).withOpacity(0.25),
        ),
        Icon(
          Icons.star,
          size: 14,
          color: rating >= 3.0
              ? Color(0xFFFBBF12)
              : Color(0xFFFBBF12).withOpacity(0.25),
        ),
        Icon(
          Icons.star,
          size: 14,
          color: rating >= 4.0
              ? Color(0xFFFBBF12)
              : Color(0xFFFBBF12).withOpacity(0.25),
        ),
        Icon(
          Icons.star,
          size: 14,
          color: rating >= 5.0
              ? Color(0xFFFBBF12)
              : Color(0xFFFBBF12).withOpacity(0.25),
        ),
      ],
    );
  }
}
