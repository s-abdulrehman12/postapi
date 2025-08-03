import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert'; // For jsonEncode and decoding

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  // this is the function to handle the login request
  // it takes email and password as parameters
  // and sends a POST request to the API endpoint
  void login(String email, String password) async {
    try {
      final response = await http.post(
        Uri.parse('https://reqres.in/api/register'),
        //for the api key
        headers: {
          'Content-Type': 'application/json',
          'x-api-key': 'reqres-free-v1',
        },
        body: jsonEncode({'email': email, 'password': password}),
      );
      ;

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        print("✅ Registered successfully");
        print("🆔 ID: ${data['id']}");
        print("🔐 Token: ${data['token']}");
      } else {
        print('❌ Registration failed');
        print('Status Code: ${response.statusCode}');
        print('Response: ${response.body}');
      }
    } catch (e) {
      print('⚠️ Error: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: const Center(child: Text('Post-API')),
          backgroundColor: Colors.blueAccent.shade200,
        ),
        body: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextFormField(
                controller: emailController,
                decoration: const InputDecoration(hintText: 'Email'),
              ),
              const SizedBox(height: 20),
              TextFormField(
                controller: passwordController,
                decoration: const InputDecoration(hintText: 'Password'),
                obscureText: true,
              ),
              const SizedBox(height: 40),
              GestureDetector(
                onTap: () {
                  final email = emailController.text.trim();
                  final password = passwordController.text.trim();
                  login(email, password);
                },
                child: Container(
                  height: 45,
                  width: 240,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    color: Colors.green.shade400,
                  ),
                  child: const Center(
                    child: Text('Log In', style: TextStyle(fontSize: 16)),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
