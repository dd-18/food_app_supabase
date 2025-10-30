import 'package:flutter/cupertino.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class CartProvider extends ChangeNotifier{
  final SupabaseClient _supabaseClient = Supabase.instance.client;
}