import 'package:flutter/material.dart';
import 'package:lastminutegift/common/widgets/bottom_bar.dart';
import 'package:lastminutegift/features/address/screens/address_screen.dart';
import 'package:lastminutegift/features/admin/screens/add_products_screen.dart';
import 'package:lastminutegift/features/auth/screens/auth_screens.dart';
import 'package:lastminutegift/features/home/screens/category_deals.dart';
import 'package:lastminutegift/features/home/screens/home_screens.dart';
// import 'package:lastminutegift/features/admin/screens/category_deals.dart';
import 'package:lastminutegift/features/order_details/screens/order_details.dart';
import 'package:lastminutegift/features/product_details/screens/product_details_screen.dart';
import 'package:lastminutegift/features/search/screens/search_screen.dart';
import 'package:lastminutegift/models/order.dart';
import 'package:lastminutegift/models/product.dart';

Route<dynamic> generateRoute(RouteSettings routeSettings) {
  switch (routeSettings.name) {

    case AuthScreen.routeName:
      return MaterialPageRoute(
          settings: routeSettings, builder: (_) => const AuthScreen());

    case HomeScreen.routeName:
      return MaterialPageRoute(
          settings: routeSettings, builder: (_) => const HomeScreen());

    case BottomBar.routeName:
      return MaterialPageRoute(
          settings: routeSettings, builder: (_) => const BottomBar( ));

    case AddProductsScreen.routeName:
      return MaterialPageRoute(
          settings: routeSettings, builder: (_) => const AddProductsScreen());

    case CategoryDealsScreen.routeName:
      var category = routeSettings.arguments as String;
      return MaterialPageRoute(
          settings: routeSettings, builder: (_) => CategoryDealsScreen(category: category));

    case SearchScreen.routeName:
      var searchQuery = routeSettings.arguments as String;
      return MaterialPageRoute(
          settings: routeSettings,
          builder: (_) => SearchScreen(
              searchQuery: searchQuery));

    case ProductDetailScreen.routeName:
      var product = routeSettings.arguments as Product;
      return MaterialPageRoute(
          settings: routeSettings,
          builder: (_) => ProductDetailScreen(
            product: product,));

    case AddressScreen.routeName:
      var totalAmount = routeSettings.arguments as String;
      return MaterialPageRoute(
          settings: routeSettings,
          builder: (_) => AddressScreen(totalAmount: totalAmount,));

    case OrderDetailsScreen.routeName:
      var order = routeSettings.arguments as Order;
      return MaterialPageRoute(
          settings: routeSettings,
          builder: (_) => OrderDetailsScreen(order: order,));

    default:
      return MaterialPageRoute(
          settings: routeSettings, builder: (_) => const Scaffold(body: Center(child: Text('Screen does not exist!'),),));
  }
}