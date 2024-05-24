import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/material.dart%20%20';
import 'package:lastminutegift/constants/gloVar.dart';
import 'package:lastminutegift/features/home/widgets/address_box.dart';
import 'package:lastminutegift/features/home/widgets/carousal_images.dart';
import 'package:lastminutegift/features/home/widgets/deal_of_day.dart';
import 'package:lastminutegift/features/home/widgets/top_categories.dart';
import 'package:lastminutegift/features/search/screens/search_screen.dart';
import 'package:lastminutegift/providers/user_provider.dart';
import 'package:provider/provider.dart';
import 'package:lastminutegift/features/home/widgets/help_me_decide.dart';

class HomeScreen extends StatefulWidget {
  static const String routeName = '/home';
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  void navigateToSearchScreen(String query) {
    Navigator.pushNamed(context, SearchScreen.routeName, arguments: query);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        flexibleSpace: Container(
          decoration:
              const BoxDecoration(gradient: GlobalVariables.appBarGradient),
        ),
        title: Expanded(
          child: Column(
            children: [
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                Expanded(
                  child: Container(
                    height: 42,
                    margin: const EdgeInsets.only(left: 25, top: 10),
                    child: Material(
                        borderRadius: BorderRadius.circular(7),
                        elevation: 1,
                        child: TextFormField(
                          onFieldSubmitted: navigateToSearchScreen,
                          decoration: InputDecoration(
                              prefixIcon: InkWell(
                                onTap: () {},
                                child: Padding(
                                  padding: EdgeInsets.only(left: 6),
                                  child: Icon(
                                    Icons.search,
                                    color: GlobalVariables.selectedNavBarColor,
                                    size: 23,
                                  ),
                                ),
                              ),
                              filled: true,
                              fillColor: Colors.white,
                              contentPadding: const EdgeInsets.only(top: 10),
                              border: const OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(7)),
                                  borderSide: BorderSide.none),
                              enabledBorder: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(7)),
                                  borderSide: BorderSide(
                                      color: Colors.black38, width: 1)),
                              hintText: "Search your way to express"),
                        )),
                  ),
                ),
                Container(
                  height: 42,
                  margin: const EdgeInsets.only(left: 10, right: 10, top: 10),
                  child: Icon(
                    Icons.mic,
                    color: GlobalVariables.selectedNavBarColor,
                    size: 25,
                  ),
                )
              ]),
            ],
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: const [
            AddressBox(),
            SizedBox(
              height: 10,
            ),
            TopCategories(),
            SizedBox(
              height: 10,
            ),
            Carousel(),
            SizedBox(
              height: 10,
            ),
            DealOfDay(),
          ],
          
        ),
      ),
      floatingActionButton: FloatingActionButton(
          onPressed: (){
            Navigator.pushNamed(context, HelpMeDecide.routeName);},
        backgroundColor: GlobalVariables.selectedNavBarColor,
        child: const Icon(Icons.question_mark, ),
        tooltip: 'Help Me Decide',
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
      );
  }
}
