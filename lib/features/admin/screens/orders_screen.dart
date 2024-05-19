import 'package:flutter/material.dart';
import 'package:lastminutegift/features/account/widgets/single_product.dart';
import 'package:lastminutegift/features/admin/services/admin_services.dart';
import 'package:lastminutegift/features/order_details/screens/order_details.dart';
import 'package:lastminutegift/models/order.dart';

class OrdersScreen extends StatefulWidget {
  const OrdersScreen({super.key});

  @override
  State<OrdersScreen> createState() => _OrdersScreenState();
}

class _OrdersScreenState extends State<OrdersScreen> {
  List<Order>? orders;
  final AdminServices adminServices = AdminServices();

  @override
  void initState() {
    super.initState();
    fetchOrders();
  }

  void fetchOrders() async {
    orders = await adminServices.fetchAllOrders(context);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return orders == null
        ? const Center(child: CircularProgressIndicator())
        : GridView.builder(
      itemCount: orders!.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 10.0,
        mainAxisSpacing: 10.0,
      ),
      itemBuilder: (context, index) {
        final orderData = orders![index];
        // Check if products list is empty
        if (orderData.products.isEmpty) {
          return SizedBox.shrink(); // Return empty SizedBox if products list is empty
        }
        return GestureDetector(
          onTap: (){
            Navigator.pushNamed(context, OrderDetailsScreen.routeName, arguments: orderData);
          },
          child: SizedBox(
            height: 140,
            child: SingleProduct(image: orderData.products[0].images[0]),
          ),
        );
      },
    );
  }
}
