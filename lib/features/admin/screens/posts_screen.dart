import 'package:flutter/material.dart';
import 'package:lastminutegift/constants/gloVar.dart';
import 'package:lastminutegift/features/account/widgets/single_product.dart';
import 'package:lastminutegift/features/admin/screens/add_products_screen.dart';
import 'package:lastminutegift/features/admin/services/admin_services.dart';
import 'package:lastminutegift/models/product.dart';

class PostsScreen extends StatefulWidget {
  const PostsScreen({super.key});

  @override
  State<PostsScreen> createState() => _PostsScreenState();
}

class _PostsScreenState extends State<PostsScreen> {
  List<Product>? products =[];
  final AdminServices adminServices = AdminServices();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchAllProducts();
  }

  fetchAllProducts()async{
    products = await adminServices.fetchAllProducts(context);
    setState(() {

    });
  }

  void deleteProduct(Product product, int index){
    adminServices.deleteProduct(context: context, product: product, onSuccess: (){
      products!.removeAt(index);
      setState(() {

      });
    });
  }

  void navigateToAddPrdouct(){
;
  }
  @override
  Widget build(BuildContext context) {
    return products == null ? CircularProgressIndicator() : Scaffold(
      body: GridView.builder(
        itemCount: products!.length,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2), itemBuilder: (context, index){
        final productData = products![index];
        return Column(
          children: [
            SizedBox(
              height: 140,
              child: SingleProduct(image: productData.images[0]),
            ),
            Row(
              children: [
                Expanded(
                    child: Text(
                      productData.name,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 2,
                    )
                ),
                IconButton(
                    onPressed: () => deleteProduct(productData, index),
                    icon: const Icon(Icons.delete_sharp))
              ],
            )
          ],
        );
      }),
      floatingActionButton: FloatingActionButton(
          onPressed: (){
            Navigator.pushNamed(context, AddProductsScreen.routeName);},
        backgroundColor: GlobalVariables.selectedNavBarColor,
        child: const Icon(Icons.add, ),
        tooltip: 'Add a Product',
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
