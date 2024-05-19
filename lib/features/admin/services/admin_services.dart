import 'dart:convert';
import 'dart:io';
import 'dart:ui';

import 'package:cloudinary_public/cloudinary_public.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/material.dart%20%20';
import 'package:lastminutegift/constants/error_handling.dart';
import 'package:lastminutegift/constants/gloVar.dart';
import 'package:lastminutegift/constants/utils.dart';
import 'package:lastminutegift/features/admin/models/sales.dart';
import 'package:lastminutegift/models/order.dart';
import 'package:lastminutegift/models/product.dart';
import 'package:http/http.dart' as http;
import 'package:lastminutegift/providers/user_provider.dart';
import 'package:provider/provider.dart';

class AdminServices{

  void sellProduct({
    required BuildContext context,
    required String name,
    required String description,
    required String category,
    required double price,
    required double quantity,
    required List<File> images,
}) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    try {
      final cloudinary = CloudinaryPublic('dxnl9tuee', 'sbmeni91' );
      List<String> imageUrls =[];
      for(int i=0; i<images.length; i++){
        CloudinaryResponse res = await cloudinary.uploadFile(CloudinaryFile.fromFile(images[i].path, folder: name));
        imageUrls.add(res.secureUrl);
      }
      Product product = Product(
          name: name, 
          description: description, 
          quantity: quantity, 
          images: imageUrls, 
          category: category, 
          price: price
      );

      http.Response res = await http.post(
        Uri.parse('$uri/admin/add-product'),
        headers: {
          'Content-Type' : 'application/json; charset=UTF-8',
          'x-auth-token': userProvider.user.token,
        },
        body: product.toJson(),
      );
      httpErrorHandle(response: res, context: context, onSuccess: (){
        showSnackBar(context, 'Product Added Successfully');
        Navigator.pop(context);
      });
    }
    catch(e){
      showSnackBar(context, e.toString());
    }
  }

  Future<List<Product>> fetchAllProducts(BuildContext context) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    List<Product> productList = [];
    try{
      http.Response res = await http.get(
        Uri.parse('$uri/admin/get-products'),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          'x-auth-token': userProvider.user.token,
        }
      );
      httpErrorHandle(response: res, context: context, onSuccess: (){
        for(int i=0; i<jsonDecode(res.body).length; i++){
          productList.add(
            Product.fromJson(jsonEncode(jsonDecode(res.body)[i]))
          );
        }
      });
    }
    catch(e){
      showSnackBar(context, e.toString());
    }
    return productList;
  }

  void deleteProduct(
  {
    required BuildContext context,
    required Product product,
    required VoidCallback onSuccess,}) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    try {
      http.Response res = await http.post(
        Uri.parse('$uri/admin/delete-product'),
        headers: {
          'Content-Type' : 'application/json; charset=UTF-8',
          'x-auth-token': userProvider.user.token,
        },
        body: jsonEncode({
          'id' : product.id,
        })
      );
      httpErrorHandle(response: res, context: context, onSuccess: (){
        onSuccess();
      });
    }
    catch(e){
      showSnackBar(context, e.toString());
    }
  }

  Future<List<Order>> fetchAllOrders(BuildContext context) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    List<Order> orderList = [];
    try{
      http.Response res = await http.get(
          Uri.parse('$uri/admin/get-orders'),
          headers: {
            'Content-Type': 'application/json; charset=UTF-8',
            'x-auth-token': userProvider.user.token,
          }
      );
      httpErrorHandle(response: res, context: context, onSuccess: (){
        for(int i=0; i<jsonDecode(res.body).length; i++){
          orderList.add(
              Order.fromJson(jsonEncode(jsonDecode(res.body)[i]))
          );
        }
      });
    }
    catch(e){
      showSnackBar(context, e.toString());
    }
    return orderList;
  }

  void changeOrderStatus({
    required BuildContext context,
    required int status,
    required Order order,
    required VoidCallback onSuccess,
  }) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    try {
      String orderId = order.id != null ? order.id.toString() : '';

      http.Response res = await http.post(
        Uri.parse('$uri/admin/change-order-status'),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          'x-auth-token': userProvider.user.token,
        },
        body: jsonEncode({
          'id': orderId,
          'status': status,
        }),
      );

      print('Response status: ${res.statusCode}');
      print('Response body: ${res.body}');

      if (res.statusCode == 200) {
        // If the request is successful
        onSuccess();
      } else {
        // Handle other status codes
        showSnackBar(context, 'Failed to change order status. Status code: ${res.statusCode}');
      }
    } catch (e) {
      showSnackBar(context, 'Failed to change order status: ${e.toString()}');
    }
  }

  Future<Map<String, dynamic>> getEarnings(BuildContext context) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    List<Sales> sales = [];
    int totalEarning = 0;
    try{
      http.Response res = await http.get(
          Uri.parse('$uri/admin/analytics'),
          headers: {
            'Content-Type': 'application/json; charset=UTF-8',
            'x-auth-token': userProvider.user.token,
          }
      );
      httpErrorHandle(
          response: res,
          context: context,
          onSuccess: (){
            var response = jsonDecode(res.body);
            totalEarning = response['totalEarnings'];
            sales = [
              Sales('Anniversary', response['anniversaryEarnings']),
              Sales('Birthday', response['birthdayEarnings']),
              Sales('Hampers', response['hampersEarnings']),
              Sales('Cakes', response['cakesEarnings']),
              Sales('Plants', response['plantsEarnings']),
            ];
      });
    }
    catch(e){
      showSnackBar(context, e.toString());
    }
    return {
      'sales': sales,
      'totalEarnings': totalEarning
    };
  }


}