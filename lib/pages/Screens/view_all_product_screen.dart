import 'package:flutter/material.dart';
import 'package:food_app_supabase/Core/models/product_model.dart';
import 'package:food_app_supabase/widgets/products_items_display.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class ViewAllProductScreen extends StatefulWidget {
  const ViewAllProductScreen({super.key});

  @override
  State<ViewAllProductScreen> createState() => _ViewAllProductScreenState();
}

class _ViewAllProductScreenState extends State<ViewAllProductScreen> {
  final supabase = Supabase.instance.client;
  List<FoodModel> products = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchFoodProduct();
  }

  Future<void> fetchFoodProduct() async {
    try {
      final response = await Supabase.instance.client
          .from('food_product')
          .select();

      final data = response as List;
      setState(() {
        products = data.map((json) => FoodModel.fromJson(json)).toList();
        isLoading = false;
      });
    } catch (e) {
      debugPrint("Error Fetching Product: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue[50],
      appBar: AppBar(
        title: Text(
          'All Products',
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.blue[50],
        forceMaterialTransparency: true,
        centerTitle: true,
      ),
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : GridView.builder(
              itemCount: products.length,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 10.0,
                mainAxisSpacing: 10.0,
              ),
              itemBuilder: (context, index) {
                return ProductsItemsDisplay(foodModel: products[index]);
              },
            ),
    );
  }
}
