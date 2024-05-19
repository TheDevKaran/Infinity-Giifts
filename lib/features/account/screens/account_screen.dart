import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lastminutegift/constants/gloVar.dart';
import 'package:lastminutegift/features/account/widgets/below_app_bar.dart';
import 'package:lastminutegift/features/account/widgets/orders.dart';
import 'package:lastminutegift/features/account/widgets/top_buttons.dart';

class AccountScreen extends StatelessWidget {
  const AccountScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(50), child: AppBar(
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: GlobalVariables.appBarGradient
          ),
        ),
        title: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
          Container(
            alignment: Alignment.topLeft,
            child: Image.asset('assets/images/logo-no-background.png', width: 120, height: 45, ),
        ),
          Container(padding: const EdgeInsets.only(left: 15, right: 15), child: Row(
            children: const [
              Padding(padding: EdgeInsets.only(right: 15), child: Icon(Icons.notifications_outlined,color: Color.fromRGBO(161, 39, 16, 1),),),
              Icon(Icons.search, color: Color.fromRGBO(161, 39, 16, 1))
            ],
          ),)

        ]),
      ),
      ),
      body: Column(
        children: const [
          BelowAppBar(),
          SizedBox(height: 10,),
          TopButtons(),
          SizedBox(height: 20,),
          Orders()

        ],
      ),
    );
  }
}
