import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:lastminutegift/constants/gloVar.dart';

class Carousel extends StatelessWidget {
  const Carousel({super.key});@override
  Widget build(BuildContext context) {
    return CarouselSlider(
        items: GlobalVariables.carouselImages.map((i){
          return Builder(builder: (BuildContext context)=>Image.network(
            i, fit: BoxFit.cover, height: 200,
          ));
        }).toList(),
        options: CarouselOptions(viewportFraction: 0.6, height: 100,enlargeCenterPage: true,autoPlay: true, aspectRatio: double.infinity)
    );
  }
}
