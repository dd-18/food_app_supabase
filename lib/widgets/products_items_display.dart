import 'package:flutter/material.dart';
import 'package:food_app_supabase/Core/Utils/consts.dart';
import 'package:food_app_supabase/Core/models/product_model.dart';

class ProductsItemsDisplay extends StatefulWidget {
  final FoodModel foodModel;
  const ProductsItemsDisplay({super.key, required this.foodModel});

  @override
  State<ProductsItemsDisplay> createState() => _ProductsItemsDisplayState();
}

class _ProductsItemsDisplayState extends State<ProductsItemsDisplay> {
  @override
  Widget build(BuildContext context) {
    // This widget is built to fit the parent's constraints (w:140, h:179.7)
    return GestureDetector(
      onTap: () {},
      child: SizedBox(
        width: 140,
        height: 179.7, // Fit within the exact constraint from the error log
        child: Stack(
          clipBehavior: Clip.none, // Allows the image to overflow visually
          alignment: Alignment.bottomCenter,
          children: [
            // Card with text content
            Container(
              height: 150, // Set to be less than the max height
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
                children: [
                  // This SizedBox creates space for the image to overlap
                  const SizedBox(height: 50),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: Text(
                      widget.foodModel.name,
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
                      widget.foodModel.specialItems,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontSize: 11,
                        color: Colors.grey,
                      ),
                    ),
                  ),
                  const SizedBox(height: 6),
                  RichText(
                    text: TextSpan(
                      style: const TextStyle(
                          fontWeight: FontWeight.bold, color: Colors.black),
                      children: [
                        TextSpan(
                          text: "\$",
                          style: TextStyle(fontSize: 12, color: red),
                        ),
                        TextSpan(
                          text: widget.foodModel.price.toStringAsFixed(2),
                          style: const TextStyle(fontSize: 18),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 12), // Bottom padding
                ],
              ),
            ),

            // The image that pops out of the top
            Positioned(
              top: -25, // Positioned above the card
              child: Image.network(
                widget.foodModel.imageCard.trim(), // Trim whitespace from URL
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
          ],
        ),
      ),
    );
  }
}
