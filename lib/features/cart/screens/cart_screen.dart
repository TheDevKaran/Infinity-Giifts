import 'package:flutter/material.dart';
import 'package:lastminutegift/common/widgets/custom_button.dart';
import 'package:lastminutegift/constants/gloVar.dart';
import 'package:lastminutegift/features/address/screens/address_screen.dart';
import 'package:lastminutegift/features/cart/widgets/cart_product.dart';
import 'package:lastminutegift/features/cart/widgets/cart_sub_total.dart';
import 'package:lastminutegift/features/home/widgets/address_box.dart';
import 'package:lastminutegift/features/search/screens/search_screen.dart';
import 'package:lastminutegift/providers/user_provider.dart';
import 'package:provider/provider.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  void navigateToSearchScreen(String query) {
    Navigator.pushNamed(context, SearchScreen.routeName, arguments: query);
  }
  void navigateToAddress(int sum) {
    Navigator.pushNamed(context, AddressScreen.routeName, arguments: sum.toString());
  }


  @override
  Widget build(BuildContext context) {
    final user = context.watch<UserProvider>().user;
    int sum=0;
    user.cart
        .map((e) => sum+= e['quantity']*e['product']['price'] as int)
        .toList();
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
          children: [
            const AddressBox(),
            const CartSubtotal(),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                    foregroundColor: Colors.white,
                    minimumSize: Size(double.infinity, 50)),
                onPressed:()=> navigateToAddress(sum),
                child: Text('Proceed to Buy  (${user.cart.length} items)'),
              ),
            ),
            const SizedBox(height: 15,),
            Container(color: Colors.black12.withOpacity(0.08), height: 1,),
            const SizedBox(height: 5,),
            ListView.builder(itemCount: user.cart.length, shrinkWrap: true, itemBuilder: (context, index){
              return CartProduct(index: index);
            })
          ],
        ),
      ),
    );
  }
}
