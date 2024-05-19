import 'package:flutter/material.dart';
import 'package:lastminutegift/constants/gloVar.dart';
import 'package:lastminutegift/features/home/services/home_services.dart';
import 'package:lastminutegift/features/product_details/screens/product_details_screen.dart';
import 'package:lastminutegift/models/product.dart';

class CategoryDealsScreen extends StatefulWidget {
  static const String routeName = '/category-deals';
  final String category;

  const CategoryDealsScreen({Key? key, required this.category}) : super(key: key);

  @override
  State<CategoryDealsScreen> createState() => _CategoryDealsState();
}

class _CategoryDealsState extends State<CategoryDealsScreen> {
  List<Product>? productList;
  final HomeServices homeServices = HomeServices();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchCategoryProducts();
  }

  fetchCategoryProducts() async {
    productList = await homeServices.fetchCategoryProducts(
        context: context,
        category: widget.category
    );
    setState(() {

    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: GlobalVariables.appBarGradient,
          ),
        ),
        title: Text(
          widget.category,
          style: TextStyle(
            color: GlobalVariables.selectedNavBarColor,
          ),
        ),
      ),
      body: productList == null ? const CircularProgressIndicator() : Column(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
            alignment: Alignment.topLeft,
            child: Text(
              'Keep Shopping for ${widget.category}',
              style: TextStyle(fontSize: 20),
            ),
          ),
          SizedBox(height: 170, child: GridView.builder(
            scrollDirection: Axis.horizontal,
              itemCount: productList!.length,
              padding: const EdgeInsets.only(left: 15),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 1,
                  childAspectRatio: 1.4,
                  mainAxisExtent: 100),
              itemBuilder: (context, index){
              final product = productList![index];
                return GestureDetector(
                  onTap: (){
                    Navigator.pushNamed(context, ProductDetailScreen.routeName, arguments: product);
                  },
                  child: Column(
                    children: [
                      SizedBox(height: 130,width: 70, child: DecoratedBox(
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.cyan, width: 0.5)
                          ),
                        child: Image.network(product.images[0]),
                      ),),
                      Container(
                        alignment: Alignment.center,
                        padding: const EdgeInsets.only(
                          left: 0, top: 5, right: 15
                        ),
                        child: Text(product.name, maxLines: 1, overflow: TextOverflow.ellipsis,),
                      )
                    ],
                  ),
                );
          }),)
        ],
      ),
    );
  }
}
