import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:food_app_supabase/Core/Provider/favorite_provider.dart';
import 'package:food_app_supabase/service/auth_service.dart';

AuthService authService = AuthService();

class ProfileScreen extends ConsumerWidget {
  ProfileScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: ElevatedButton(
              onPressed: () {
                authService.logout(context);
                ref.invalidate(favoriteProvider);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              child: Icon(Icons.exit_to_app_rounded),
            ),
          ),
        ],
      ),
    );
  }
}
