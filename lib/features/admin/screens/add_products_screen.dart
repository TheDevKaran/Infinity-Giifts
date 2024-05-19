import 'dart:io';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lastminutegift/common/widgets/custom_button.dart';
import 'package:lastminutegift/common/widgets/custom_textfield.dart';
import 'package:lastminutegift/constants/gloVar.dart';
import 'package:lastminutegift/constants/utils.dart';
import 'package:lastminutegift/features/admin/services/admin_services.dart';

class AddProductsScreen extends StatefulWidget {
  static const String routeName = '/add-product';
  const AddProductsScreen({super.key});

  @override
  State<AddProductsScreen> createState() => _AddProductsScreenState();
}

class _AddProductsScreenState extends State<AddProductsScreen> {
  final TextEditingController productNameController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController priceController = TextEditingController();
  final TextEditingController quantityController = TextEditingController();
  final AdminServices adminServices = AdminServices();

  String category='Anniversary';
  List<File> images = [];
  final _addProductFormKey = GlobalKey<FormState>();

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    productNameController.dispose();
    descriptionController.dispose();
    priceController.dispose();
    quantityController.dispose();
  }

  List<String> productCategories =[
    'Anniversary',
    'Birthday',
    'Hampers',
    'Cakes',
    'Plants'
  ];

  void sellProduct(){
    if(_addProductFormKey.currentState!.validate() &&  images.isNotEmpty){
      adminServices.sellProduct(
          context: context,
          name: productNameController.text,
          description: descriptionController.text,
          price: double.parse(priceController.text),
          quantity: double.parse(quantityController.text),
          category: category,
          images: images);
    }
  }


  void selectImages() async {
    var res = await pickImages();
    setState(() {
      images = res;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(50), child: AppBar(centerTitle: true,
          iconTheme: IconThemeData(color: GlobalVariables.selectedNavBarColor),
          flexibleSpace: Container(
          decoration: const BoxDecoration(
              gradient: GlobalVariables.appBarGradient
          ),
        ),
        title: const Text('Add Product',style: TextStyle(color: GlobalVariables.selectedNavBarColor, fontWeight: FontWeight.bold),)
      ),
      ),
      body: SingleChildScrollView(
        child: Form(
          key: _addProductFormKey,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Column(
                children: [
                  const SizedBox(height: 20,),
                  images.isNotEmpty ? CarouselSlider(
                      items: images.map((i){
                        return Builder(builder: (BuildContext context)=>Image.file(
                          i, fit: BoxFit.cover, height: 200,
                        ));
                      }).toList(),
                      options: CarouselOptions(viewportFraction: 0.6, height: 100,enlargeCenterPage: true,autoPlay: true, aspectRatio: double.infinity)
                  ) :
                  GestureDetector(
                    onTap: selectImages,
                    child: DottedBorder(borderType: BorderType.RRect,
                    radius: const Radius.circular(10),
                    dashPattern: [10,4],
                    strokeCap: StrokeCap.round,
                    child: Container(
                                    width: double.infinity,
                                    height: 150,
                                    decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10)
                                    ),
                                    child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(Icons.folder_open, size: 40,color: GlobalVariables.selectedNavBarColor,),
                      const SizedBox(height: 15,),
                      Text('Select Product Images',style: TextStyle(fontWeight: FontWeight.w200,
                        fontSize: 15, color: GlobalVariables.selectedNavBarColor
                      ),)
                    ],
                                    ),
                                  )),
                  ),
              const SizedBox(height: 30,),
              CustomTextField(controller: productNameController, hintText: 'Product Name'),
              const SizedBox(height: 10,),
              CustomTextField(controller: descriptionController, hintText: ' Description',maxLines: 7, ),
              const SizedBox(height: 10,),
              CustomTextField(controller: priceController, hintText: ' Price' ),
              const SizedBox(height: 10,),
              CustomTextField(controller: quantityController, hintText: ' Quantity', ),
              const SizedBox(height: 10,),
              SizedBox(width: double.infinity,
              child: DropdownButton(
                value: category,
                  items: productCategories.map((String item){
                    return DropdownMenuItem(
                      value: item,
                      child: Text(item)
                    );}).toList(),
                  onChanged: (String? newVal){
                  setState(() {
                    category = newVal!;
                  });
                  },
                  icon: const Icon(Icons.keyboard_arrow_down),
              ),),
              const SizedBox(height: 10,),
              CustomButton(text: 'Sell', onTap: sellProduct,)
            ],
          ),
        )),
      ),
    );
  }
}
