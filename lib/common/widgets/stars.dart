import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:lastminutegift/constants/gloVar.dart';

class Stars extends StatelessWidget {
  final double rating;
  const Stars({super.key, required this.rating});

  @override
  Widget build(BuildContext context) {
    return RatingBarIndicator(itemBuilder: (context, _) => const Icon(Icons.star_sharp, color: GlobalVariables.secondaryColor,), direction: Axis.horizontal, itemCount: 5, rating: rating, itemSize: 15,);
  }
}
