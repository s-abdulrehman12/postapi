import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert'; // For jsonEncode and decoding

void main() {
  runApp(MyApp());
}

// in this project , i am going to send the data to the server
// for this first of all, import the http package
// now in the coding area

// make the two TextController
// one is email controller , second is the password controller


// this controller takes the values and then send it to the server
// by final TextEditingController emailController = TextEditingController();

//then makes the void function of login which takes two parameters with the async fubctionality

// first one is email and second one is password type , both are of string type

// then use the try catch block


// try {} catch (e){}


// in try block first we find the response by using the
// final response = await http.post('api_link here');
// then  we provide the api key to the app by using header{}
// in header {
//    "Content-Type" : "application/json",
//    "x-api-key" : "your_actual_key"
//
// }

// this is the method to define the actual private key to the the app


// then in body use jsonEncode and provide the parameters such as


// body : jsonEncode({
// "email" : email,    ("email" is the api- parameter and {email} is the value which is given by the controller)
//  "password": password (this is just like the key-value pair)
// })




// then if response exists then works

// if not exists then it is cleared that it doees not exist



// last but not least , provide the email controller and password controller to the both text form field



// and on tap :-> call the login function with the email and password value










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
