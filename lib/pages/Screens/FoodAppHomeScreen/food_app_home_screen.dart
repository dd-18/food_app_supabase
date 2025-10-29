import 'package:flutter/material.dart';
import 'package:food_app_supabase/Core/Utils/consts.dart';
import 'package:food_app_supabase/Core/models/categories_model.dart';
import 'package:food_app_supabase/pages/Screens/FoodAppHomeScreen/widgets/view_all.dart';
import 'package:food_app_supabase/widgets/products_items_display.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../Core/models/product_model.dart';

class FoodAppHomeScreen extends StatefulWidget {
  const FoodAppHomeScreen({super.key});

  @override
  State<FoodAppHomeScreen> createState() => _FoodAppHomeScreenState();
}

class _FoodAppHomeScreenState extends State<FoodAppHomeScreen> {
  late Future<List<CategoryModel>> futureCategories = fetchCategories();
  late Future<List<FoodModel>> futureFoodProducts = Future.value([]);
  List<CategoryModel> categories = [];
  String? selectedCategory;

  @override
  void initState() {
    super.initState();
    _initializeData();
  }

  void _initializeData() async {
    try {
      final categories = await futureCategories;
      if (categories.isNotEmpty) {
        setState(() {
          this.categories = categories;
          selectedCategory = categories.first.name;

          futureFoodProducts = fetchFoodProduct(selectedCategory!);
        });
      }
    } catch (e) {
      debugPrint("Initialization Error: $e");
    }
  }

  Future<List<FoodModel>> fetchFoodProduct(String category) async {
    try {
      final response = await Supabase.instance.client
          .from('food_product')
          .select()
          .eq('category', category);

      return (response as List)
          .map((json) => FoodModel.fromJson(json))
          .toList();
    } catch (e) {
      debugPrint("Error Fetching Product: $e");
      return [];
    }
  }

  Future<List<CategoryModel>> fetchCategories() async {
    try {
      final response = await Supabase.instance.client
          .from('category_items')
          .select();

      return (response as List)
          .map((json) => CategoryModel.fromJson(json))
          .toList();
    } catch (e) {
      debugPrint("Error Fetching Categories: $e");
      return [];
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: appBarParts(),
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 15, vertical: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                appBanner(),
                SizedBox(height: 25),
                Text(
                  'Categories',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w800),
                ),
              ],
            ),
          ),
          _buildCategoryList(),
          SizedBox(height: 25),
          ViewAll(),
          SizedBox(height: 25),
          _buildProductSection(),
        ],
      ),
    );
  }

  Widget _buildProductSection() {
    return Expanded(
      child: FutureBuilder<List<FoodModel>>(
        future: futureFoodProducts,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }
          final products = snapshot.data ?? [];
          if (products.isEmpty) {
            return Center(child: Text('No products found.'));
          }
          return ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: products.length,
            itemBuilder: (context, index) {
              return Padding(
                padding: EdgeInsets.only(
                  left: index == 0 ? 25 : 0,
                  right: index == products.length - 1 ? 25 : 0,
                ),
                child: ProductsItemsDisplay(foodModel: products[index]),
              );
            },
          );
        },
      ),
    );
  }

  AppBar appBarParts() {
    return AppBar(
      backgroundColor: Colors.white,
      elevation: 0,
      centerTitle: true,
      actions: [
        SizedBox(width: 25),
        Container(
          height: 45,
          width: 45,
          padding: EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: grey1,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Image.asset('assets/food-delivery/icon/dash.png'),
        ),
        Spacer(),
        Row(
          children: [
            Icon(Icons.location_on_outlined, color: red, size: 18),
            SizedBox(width: 5),
            Text(
              'Rajkot, Gujarat',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: Colors.black,
              ),
            ),
            SizedBox(width: 5),
            Icon(
              Icons.keyboard_arrow_down_rounded,
              color: Colors.orange,
              size: 18,
            ),
          ],
        ),
        Spacer(),
        Container(
          height: 45,
          width: 45,
          padding: EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: grey1,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Image.asset('assets/food-delivery/profile.png'),
        ),
        SizedBox(width: 25),
      ],
    );
  }

  appBanner() {
    return Container(
      height: 160,
      decoration: BoxDecoration(
        color: imageBackground,
        borderRadius: BorderRadius.circular(20),
      ),
      padding: EdgeInsets.only(top: 25, right: 25, left: 25),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 10),
                RichText(
                  text: TextSpan(
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
                    children: [
                      TextSpan(
                        text: 'The Fastest In Delivery',
                        style: TextStyle(color: Colors.black),
                      ),
                      TextSpan(
                        text: 'Food',
                        style: TextStyle(color: Colors.red),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 10),
                Container(
                  decoration: BoxDecoration(
                    color: red,
                    borderRadius: BorderRadius.circular(30),
                  ),
                  padding: EdgeInsets.symmetric(horizontal: 15, vertical: 9),
                  child: Text(
                    'Order Now',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ],
            ),
          ),
          Image.asset('assets/food-delivery/courier.png'),
        ],
      ),
    );
  }

  Widget _buildCategoryList() {
    return FutureBuilder(
      future: futureCategories,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        }
        if (snapshot.hasError || !snapshot.hasData || snapshot.data!.isEmpty) {
          return SizedBox.shrink();
        }
        return SizedBox(
          height: 60,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            physics: BouncingScrollPhysics(),
            itemCount: categories.length,
            itemBuilder: (context, index) {
              final category = categories[index];

              return Padding(
                padding: EdgeInsets.only(left: index == 0 ? 15 : 0, right: 15),
                child: GestureDetector(
                  onTap: () => handleCategoryTap(category.name),
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                    decoration: BoxDecoration(
                      color: selectedCategory == category.name ? red : grey1,
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: Row(
                      children: [
                        Container(
                          padding: EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: selectedCategory == category.name
                                ? Colors.white
                                : Colors.transparent,
                            borderRadius: BorderRadius.circular(30),
                          ),
                          child: Image.network(
                            category.image,
                            width: 30,
                            height: 30,
                            errorBuilder: (context, error, stackTrace) {
                              return Icon(Icons.fastfood);
                            },
                          ),
                        ),
                        SizedBox(width: 10),
                        Text(
                          category.name,
                          style: TextStyle(
                            color: selectedCategory == category.name
                                ? Colors.white
                                : Colors.black,
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        );
      },
    );
  }

  void handleCategoryTap(String category) {
    if (selectedCategory != category) {
      setState(() {
        selectedCategory = category;
        futureFoodProducts = fetchFoodProduct(category);
      });
    }
  }
}
