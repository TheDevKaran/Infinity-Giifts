import 'package:flutter/material.dart';
String uri = 'https://bbd6-2401-4900-1c85-fcd9-1023-496c-c2c5-8f42.ngrok-free.app';
//https://localhost:3000
class GlobalVariables {
  // COLORS
  static const appBarGradient = LinearGradient(
    colors: [
      Color.fromARGB(255, 182, 179, 196),
      Color.fromARGB(255, 231, 193, 206),
    ],
    stops: [0.5, 1.0],
  );

  static const secondaryColor = Color.fromRGBO(255, 153, 0, 1);
  static const backgroundColor = Colors.white;
  static const Color greyBackgroundCOlor = Color(0xffebecee);
  static const selectedNavBarColor = Color.fromRGBO(161, 39, 16, 1);
  static const unselectedNavBarColor = Colors.black87;


// STATIC IMAGES
  static const List<String> carouselImages = [
    'https://www.fnp.com/assets/images/custom/new-desk-home/hero-banners/Better-Late-Mothers-day_06_Homepage_Desktop-Banner_02%20(1).jpg',
    'https://www.fnp.com/assets/images/custom/new-desk-home/hero-banners/Fmaily-Day_DeskV3%20(1).jpg',
    'https://www.fnp.com/assets/images/custom/new-desk-home/hero-banners/Anniversary%20banner_Des-164.jpg',
    'https://www.fnp.com/assets/images/custom/new-desk-home/hero-banners/Summerspecial%20productsbannerV3-164.jpg',
    'https://www.fnp.com/assets/images/custom/new-desk-home/hero-banners/Cake-Banner_Desktop_03_01.jpg',
  ];

  static const List<Map<String, String>> categoryImages = [
    {
      'title': 'Anniversary',
      'image': 'assets/images/anniversary.jpg',
    },
    {
      'title': 'Birthday',
      'image': 'assets/images/birthday.jpg',
    },
    {
      'title': 'Hampers',
      'image': 'assets/images/hamper.jpg',
    },
    {
      'title': 'Cakes',
      'image': 'assets/images/cakes.jpg',
    },
    {
      'title': 'Plants',
      'image': 'assets/images/plants.jpg',
    },
  ];
}
