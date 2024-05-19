import 'package:flutter/material.dart';
import 'package:lastminutegift/constants/gloVar.dart';
import 'package:lastminutegift/providers/user_provider.dart';
import 'package:provider/provider.dart';

class AddressBox extends StatelessWidget {
  const AddressBox({super.key});

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserProvider>(context).user;
    return Container(
      height: 40, decoration: const BoxDecoration(
      gradient: LinearGradient(colors: [
        Color.fromARGB(255, 182, 179, 196),
        Color.fromARGB(255, 231, 193, 206)], stops: [0.5, 1.0])
    ), 
      padding: EdgeInsets.only(left: 10),
      child: Row(children: [
         Icon(Icons.location_on,color: GlobalVariables.selectedNavBarColor ,size: 20,), Expanded(child: Padding(padding: const EdgeInsets.only(left: 5), child: Text('Deivery to ${user.name} - ${user.address}', style: TextStyle(fontWeight: FontWeight.w500),overflow: TextOverflow.ellipsis,))
        ), Padding(padding: EdgeInsets.only(left: 5, top: 2), child: Icon(Icons.arrow_drop_down_circle_outlined, size: 18, color: GlobalVariables.selectedNavBarColor),)
      ],),
    );
  }
}
