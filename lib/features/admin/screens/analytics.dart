import 'package:flutter/material.dart';
import 'package:lastminutegift/features/admin/models/sales.dart';
import 'package:lastminutegift/features/admin/services/admin_services.dart';

class AnalyticsScree extends StatefulWidget {
  const AnalyticsScree({super.key});

  @override
  State<AnalyticsScree> createState() => _AnalyticsScreeState();
}

class _AnalyticsScreeState extends State<AnalyticsScree> {
  final AdminServices adminServices = AdminServices();
  int? totalSales;
  List<Sales>? earnings;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getEarnings();
  }

  getEarnings() async {
    var earningData = await adminServices.getEarnings(context);
    totalSales = earningData['totalEarnings'];
    earnings = earningData['Sales'];
    setState(() {

    });
  }

  @override
  Widget build(BuildContext context) {
    return earnings == null || totalSales == null ? const CircularProgressIndicator() :  Column(
      children: [
        Text('\₹$totalSales', style:  const TextStyle(fontSize:  20, fontWeight: FontWeight.bold),)
      ],
    );
  }
}
