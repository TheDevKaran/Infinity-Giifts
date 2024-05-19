import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:lastminutegift/constants/gloVar.dart';
// import 'package:lastminutegift/features/admin/screens/category_deals.dart';
import 'package:lastminutegift/features/home/screens/category_deals.dart';

class TopCategories extends StatelessWidget {
  const TopCategories({super.key});

  void navigateToCategoryPage(BuildContext context, String category){
    Navigator.pushNamed(context, CategoryDealsScreen.routeName, arguments: category);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60, child: ListView.builder(itemCount: GlobalVariables.categoryImages.length,
        scrollDirection: Axis.horizontal,itemBuilder: (context, index){
        return GestureDetector(
          onTap: ()=> navigateToCategoryPage(context, GlobalVariables.categoryImages[index]['title']!),
          child: Column(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 13),
                child: Column(children: [
                  ClipRRect(borderRadius: BorderRadius.circular(50),
                    child: Image.asset(GlobalVariables.categoryImages[index]['image']!,
                      fit: BoxFit.cover, height: 40,width: 40,),
                  ),
                  Text(GlobalVariables.categoryImages[index]['title']!)
                ],),
              )
            ],
          ),
        );
    }),
    );
  }
}
