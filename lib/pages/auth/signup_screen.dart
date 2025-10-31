import 'package:flutter/material.dart';
import 'package:food_app_supabase/service/auth_service.dart';
import 'package:food_app_supabase/widgets/my_button.dart';
import 'package:food_app_supabase/widgets/snack_bar.dart';

import 'login_screen.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool isLoading = false;
  bool isPasswordHidden = true;
  final AuthService _authService = AuthService();

  void signup() async {
    String email = emailController.text.trim();
    String password = passwordController.text.trim();
    if (!email.contains(".com")) {
      showSnackBar(context, 'Invalid Email,It should contain .com', Colors.red);
    }
    setState(() {
      isLoading = true;
    });
    final result = await _authService.signUp(email, password);
    if (result == null) {
      setState(() {
        isLoading = false;
      });
      showSnackBar(
        context,
        'SignUp Successful! Now Turn to Login',
        Colors.green,
      );
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => LoginScreen()),
      );
    } else {
      setState(() {
        isLoading = false;
      });
      showSnackBar(context, "SignUp Failed : $result", Colors.red);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        physics: ScrollPhysics(parent: BouncingScrollPhysics()),
        child: Padding(
          padding: EdgeInsets.all(15),
          child: Column(
            children: [
              Image.asset(
                "assets/6343825.jpg",
                width: double.maxFinite,
                height: 400,
                fit: BoxFit.cover,
              ),
              TextField(
                controller: emailController,
                decoration: InputDecoration(
                  labelText: "Email",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
              SizedBox(height: 20),
              TextField(
                controller: passwordController,
                obscureText: isPasswordHidden,
                decoration: InputDecoration(
                  labelText: "Password",
                  suffixIcon: IconButton(
                    onPressed: () {
                      setState(() {
                        isPasswordHidden = !isPasswordHidden;
                      });
                    },
                    icon: Icon(
                      isPasswordHidden
                          ? Icons.visibility_off
                          : Icons.visibility,
                    ),
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
              SizedBox(height: 20),
              isLoading
                  ? Center(child: CircularProgressIndicator())
                  : SizedBox(
                      width: double.maxFinite,
                      child: MyButton(buttonText: 'Sign Up', onTap: signup),
                    ),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Already have an account? ",
                    style: TextStyle(fontSize: 18),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (context) => LoginScreen()),
                      );
                    },
                    child: Text(
                      "Login Here",
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.blue,
                        fontWeight: FontWeight.bold,
                        letterSpacing: -1,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
