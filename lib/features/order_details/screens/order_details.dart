import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:lastminutegift/common/widgets/custom_button.dart';
import 'package:lastminutegift/constants/gloVar.dart';
import 'package:lastminutegift/features/admin/services/admin_services.dart';
import 'package:lastminutegift/features/search/screens/search_screen.dart';
import 'package:lastminutegift/models/order.dart';
import 'package:lastminutegift/providers/user_provider.dart';
import 'package:provider/provider.dart';

class OrderDetailsScreen extends StatefulWidget {
  static const String routeName = '/order-details';
  final Order order;
  const OrderDetailsScreen({super.key, required this.order});

  @override
  State<OrderDetailsScreen> createState() => _OrderDetailsScreenState();
}

class _OrderDetailsScreenState extends State<OrderDetailsScreen> {
  int currentStep =0;
  final AdminServices adminServices = AdminServices();
  void navigateToSearchScreen(String query) {
    Navigator.pushNamed(context, SearchScreen.routeName, arguments: query);
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    currentStep = widget.order.status;
  }

  void changeOrderStatus(int status){
    adminServices.changeOrderStatus(context: context, status: status+1, order: widget.order, onSuccess: (){
      setState(() {
        currentStep+=1;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserProvider>(context).user;
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
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'View order details',
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
              Container(
                width: double.infinity,
                padding: EdgeInsets.all(10),
                decoration:
                    BoxDecoration(border: Border.all(color: Colors.black12)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                        'Order Date:    ${DateFormat().format(DateTime.fromMicrosecondsSinceEpoch(widget.order.orderedAt))}'),
                    Text('Order ID:     ${widget.order?.id??""}'),
                    Text('Order Total:   \₹${widget.order.totalPrice}'),
                  ],
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              const Text(
                'Purchase Details',
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
              Container(
                padding: EdgeInsets.all(10),
                decoration:
                    BoxDecoration(border: Border.all(color: Colors.black12)),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    for (int i = 0; i < widget.order.products.length; i++)
                      Row(
                        children: [
                          Image.network(
                            widget.order.products[i].images[0],
                            height: 120,
                            width: 120,
                          ),
                          const SizedBox(
                            width: 5,
                          ),
                          Expanded(
                              child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                widget.order.products[i].name,
                                style: const TextStyle(
                                    fontSize: 17, fontWeight: FontWeight.bold),
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              ),
                              Text('Qty: ${widget.order.quantity[i]}')
                            ],
                          ))
                        ],
                      )
                  ],
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              const Text(
                'Tracking',
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
              Container(
                  padding: EdgeInsets.all(10),
                  decoration:
                      BoxDecoration(border: Border.all(color: Colors.black12)),
                  child: Stepper(controlsBuilder: (context, details){
                    if(user.type=='admin'){
                      return CustomButton(text: 'Done', onTap: ()=> changeOrderStatus(details.currentStep));
                    }
                    return const SizedBox();
                  },
                      currentStep: currentStep,
                      steps: [
                    Step(
                        title: const Text('Pending'),
                        content: const Text('Your order is yet to be deliered'), isActive: currentStep>0, state: currentStep > 0 ? StepState.complete : StepState.indexed),
                    Step(
                        title: const Text('Completed'),
                        content: const Text('Your order has been delivered, you are yet to sign') ,isActive: currentStep>1, state: currentStep > 1 ? StepState.complete : StepState.indexed),
                    Step(
                        title: const Text('Received'),
                        content: const Text('Your order has been delivered and signed by you'), isActive: currentStep>2, state: currentStep > 2 ? StepState.complete : StepState.indexed),
                    Step(
                        title: const Text('Delivered'),
                        content: const Text('Your order has been delivered and signed by yo'), isActive: currentStep>3, state: currentStep >= 3 ? StepState.complete : StepState.indexed),
                  ])),
            ],
          ),
        ),
      ),
    );
  }
}
