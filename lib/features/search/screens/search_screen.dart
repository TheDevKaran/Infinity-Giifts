import 'package:flutter/material.dart';
import 'package:lastminutegift/constants/gloVar.dart';
import 'package:lastminutegift/features/home/widgets/address_box.dart';
import 'package:lastminutegift/features/product_details/screens/product_details_screen.dart';
import 'package:lastminutegift/features/search/services/seacrh_services.dart';
import 'package:lastminutegift/features/search/widgets/searched_products.dart';
import 'package:lastminutegift/models/product.dart';

class SearchScreen extends StatefulWidget {
  static const String routeName = '/search-screen';
  final String searchQuery;

  const SearchScreen({Key? key, required this.searchQuery}) : super(key: key);

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  List<Product>? products;
  final SearchServices searchServices = SearchServices();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchSearchProduct();
  }

  void navigateToSearchScreen(String query) {
    Navigator.pushNamed(context, SearchScreen.routeName, arguments: query);
  }

  fetchSearchProduct() async {
    products = await searchServices.fetchSearchedProducts(context: context, searchQuery: widget.searchQuery);
    setState(() {

    });
  }


  @override
  Widget build(BuildContext context) {
    return products == null
        ? const CircularProgressIndicator()
        : Scaffold(
      appBar: PreferredSize(preferredSize: const Size.fromHeight(60),
        child: AppBar(
          flexibleSpace: Container(
            decoration:
            const BoxDecoration(gradient: GlobalVariables.appBarGradient),
          ),
          title: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            Expanded(
              child: Container(
                height: 42,
                margin: const EdgeInsets.only(left:15),
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
        ),
      ),
          body: Column(
            children: [const AddressBox(),
              SizedBox(height: 10,),
              Expanded(child: ListView.builder(
                  itemCount: products!.length,
                  itemBuilder: (context, index){
                    return GestureDetector(
                        onTap: (){
                          Navigator.pushNamed(context, ProductDetailScreen.routeName, arguments: products![index]);
                        },
                        child: SearchedProduct(product: products![index]));
                  }))
            ],
          ),
    );
  }
}
