import 'package:flutter/material.dart';
import 'package:lastminutegift/common/widgets/custom_textfield.dart';
import 'package:lastminutegift/constants/gloVar.dart';
import 'package:lastminutegift/constants/utils.dart';
import 'package:lastminutegift/features/address/services/address_Services.dart';
import 'package:lastminutegift/providers/user_provider.dart';
import 'package:pay/pay.dart';
import 'package:provider/provider.dart';
import 'package:lastminutegift/payment_configurations.dart'
    as payment_configurations;
import 'package:lastminutegift/router.dart' as payment_configurations;

class AddressScreen extends StatefulWidget {
  static const String routeName = '/address';
  final String totalAmount;
  const AddressScreen({super.key, required this.totalAmount});

  @override
  State<AddressScreen> createState() => _AddressScreenState();
}

class _AddressScreenState extends State<AddressScreen> {
  TextEditingController flatController = TextEditingController();
  TextEditingController areaController = TextEditingController();
  TextEditingController pinController = TextEditingController();
  TextEditingController cityController = TextEditingController();
  final _addressFormKey = GlobalKey<FormState>();
  List<PaymentItem> paymentItems = [];
  String addressToBEUsed = "";
  final AddressServices addressServices = AddressServices()
;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    paymentItems.add(PaymentItem(
        amount: widget.totalAmount,
        label: 'Total Amount',
        status: PaymentItemStatus.final_price));
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    flatController.dispose();
    areaController.dispose();
    pinController.dispose();
    cityController.dispose();
  }
  void onGooglePayResult(res) {
    if(Provider.of<UserProvider>(context, listen: false).user.address.isEmpty){
      addressServices.saveUserAddress(context: context, address: addressToBEUsed);
    }
    addressServices.placeOrder(context: context, address: addressToBEUsed, totalSum: double.parse(widget.totalAmount));
  }
  void payPressed(String addressFormProvider) {
    addressToBEUsed = "";
    bool isForm = flatController.text.isNotEmpty ||
        areaController.text.isNotEmpty ||
        pinController.text.isNotEmpty ||
        cityController.text.isNotEmpty;

    if(isForm){
      if(_addressFormKey.currentState!.validate()){
        addressToBEUsed = '${flatController.text}, ${areaController.text}, ${cityController.text} - ${pinController.text}';
      }
      else{
        throw Exception('Please enter all the values');
      }}
      else if(addressFormProvider.isNotEmpty){
        addressToBEUsed = addressFormProvider;
    } else {
        showSnackBar(context, 'ERROR');
    }
      print(addressToBEUsed);
  }

  @override
  Widget build(BuildContext context) {
    var address = context.watch<UserProvider>().user.address;
    return Scaffold(
      appBar: AppBar(
        flexibleSpace: Container(
          decoration:
              const BoxDecoration(gradient: GlobalVariables.appBarGradient),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              if (address.isNotEmpty)
                Column(
                  children: [
                    Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.black12)),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          address,
                          style: TextStyle(fontSize: 18),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    const Text(
                      'OR',
                      style: TextStyle(fontSize: 18),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                  ],
                ),
              Form(
                  key: _addressFormKey,
                  child: Column(
                    children: [
                      CustomTextField(
                        controller: flatController,
                        hintText: 'Flat, House no, Building',
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      CustomTextField(
                        controller: areaController,
                        hintText: 'Area, Street',
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      CustomTextField(
                        controller: pinController,
                        hintText: 'Pincode',
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      CustomTextField(
                        controller: cityController,
                        hintText: 'Town/City',
                      )
                    ],
                  )),
              GooglePayButton(
                onPressed: ()=> payPressed(address),
                paymentConfiguration: PaymentConfiguration.fromJsonString(
                    payment_configurations.defaultGooglePay),
                paymentItems: paymentItems,
                onPaymentResult: onGooglePayResult,
                height: 50,
                width: double.infinity,
                type: GooglePayButtonType.buy,
                theme: GooglePayButtonTheme.light,
                margin: const EdgeInsets.only(top: 15),
                loadingIndicator: const Center(
                  child: CircularProgressIndicator(),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
