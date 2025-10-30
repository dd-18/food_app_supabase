import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:food_app_supabase/Core/Provider/favorite_provider.dart';
import 'package:food_app_supabase/Core/Utils/consts.dart';
import 'package:food_app_supabase/Core/models/product_model.dart';
import 'package:food_app_supabase/pages/Screens/food_detail_screen.dart';

class ProductsItemsDisplay extends ConsumerWidget {
  final FoodModel foodModel;
  const ProductsItemsDisplay({super.key, required this.foodModel});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final provider = ref.watch(favoriteProvider);
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          PageRouteBuilder(
            transitionDuration: const Duration(seconds: 1),
            pageBuilder: (_, __, ___) => FoodDetailScreen(product: foodModel),
          ),
        );
      },
      child: SizedBox(
        width: 140,
        height: 179.7,
        child: Stack(
          clipBehavior: Clip.none,
          alignment: Alignment.bottomCenter,
          children: [
            Container(
              height: 155,
              width: 140,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withValues(alpha: 0.2),
                    spreadRadius: 1,
                    blurRadius: 8,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(height: 50),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: Text(
                      foodModel.name,
                      maxLines: 1,
                      textAlign: TextAlign.center,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const SizedBox(height: 2),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: Text(
                      foodModel.specialItems,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      textAlign: TextAlign.center,
                      style: const TextStyle(fontSize: 11, color: Colors.grey),
                    ),
                  ),
                  const SizedBox(height: 6),
                  RichText(
                    textAlign: TextAlign.center,
                    text: TextSpan(
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                      children: [
                        TextSpan(
                          text: "\$ ",
                          style: TextStyle(fontSize: 12, color: red),
                        ),
                        TextSpan(
                          text: foodModel.price.toStringAsFixed(2),
                          style: const TextStyle(
                            fontSize: 18,
                            letterSpacing: -0.5,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Positioned(
              top: 15,
              child: Hero(
                tag: foodModel.imageCard,
                child: Image.network(
                  foodModel.imageCard.trim(),
                  height: 100,
                  width: 100,
                  fit: BoxFit.contain,
                  errorBuilder: (context, error, stackTrace) => const SizedBox(
                    height: 100,
                    width: 100,
                    child: Icon(Icons.fastfood, color: Colors.grey, size: 50),
                  ),
                ),
              ),
            ),
            Positioned(
              top: 10,
              right: 10,
              child: GestureDetector(
                onTap: () {
                  ref.read(favoriteProvider).toggleFavorite(foodModel.name);
                },
                child: CircleAvatar(
                  radius: 15,
                  backgroundColor: provider.isExist(foodModel.name)
                      ? Colors.red[100]
                      : Colors.transparent,
                  child: provider.isExist(foodModel.name)
                      ? Image.asset(
                          'assets/food-delivery/icon/fire.png',
                          height: 22,
                        )
                      : const Icon(
                          Icons.local_fire_department,
                          color: red,
                          size: 20,
                        ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
