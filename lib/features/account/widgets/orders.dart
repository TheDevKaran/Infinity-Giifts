import 'package:flutter/material.dart';
import 'package:lastminutegift/constants/gloVar.dart';
import 'package:lastminutegift/features/account/services/account_services.dart';
import 'package:lastminutegift/features/account/widgets/single_product.dart';
import 'package:lastminutegift/features/order_details/screens/order_details.dart';
import 'package:lastminutegift/models/order.dart';

class Orders extends StatefulWidget {
  const Orders({super.key});

  @override
  State<Orders> createState() => _OrdersState();
}

class _OrdersState extends State<Orders> {
  List<Order>? orders;
  final AccountServices accountServices = AccountServices();

  @override
  void initState() {
    super.initState();
    fetchOrders();
  }

  void fetchOrders() async {
    orders = await accountServices.fetchMyOrders(context: context);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return orders == null
        ? const CircularProgressIndicator()
        : Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              padding: const EdgeInsets.only(left: 15),
              child: const Text(
                'Your Orders',
                style:
                TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
              ),
            ),
            Container(
              padding: const EdgeInsets.only(right: 15),
              child: Text(
                'See all',
                style: TextStyle(
                    fontWeight: FontWeight.w600,
                    color: GlobalVariables.selectedNavBarColor),
              ),
            ),
          ],
        ),
        Container(
          height: 170,
          padding: const EdgeInsets.only(left: 10, top: 20, right: 0),
          child: orders!.isEmpty
              ? Center(child: Text('No orders available'))
              : ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: orders!.length,
            itemBuilder: (context, index) {
              final order = orders![index];
              if (order.products.isEmpty || order.products[0].images.isEmpty) {
                return SizedBox.shrink();
              }
              return GestureDetector(
                onTap: () {
                  Navigator.pushNamed(
                    context,
                    OrderDetailsScreen.routeName,
                    arguments: order,
                  );
                },
                child: SingleProduct(
                  image: order.products[0].images[0],
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
