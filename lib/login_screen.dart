import 'dart:developer';

import 'package:login_screen/auth_service.dart';
import 'package:flutter/material.dart';


class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  final _auth = AuthService();
  final _email = TextEditingController();
  final _password = TextEditingController();



  @override
  void dispose() {
    super.dispose();
    _email.dispose();
    _password.dispose();
  }

  bool showPassword = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.lightBlue[50],
      body: Center(
        child: Container(
          width: 350,
          padding: EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
            boxShadow: [
              BoxShadow(
                color: Colors.black12,
                blurRadius: 10,
                offset: Offset(0, 4),
              ),
            ],
          ),


          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Flexible(child:
                Text(
                  'Login',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.blue,
                  ),
                ),
                flex: 1,
                fit: FlexFit.loose,
              ),
              SizedBox(height: 20),
              TextField(
                decoration: InputDecoration(
                  labelText: 'Email',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
                controller: _email,
              ),
              SizedBox(height: 15),
              TextField(
                obscureText: !showPassword,
                decoration: InputDecoration(
                  labelText: 'Password',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
                controller: _password,
              ),
              SizedBox(height: 10),
              Row(
                children: [
                  Checkbox(
                    value: showPassword,
                    onChanged: (value) {
                      setState(() {
                        showPassword = value!;
                      });
                    },
                  ),
                  Text('Show Password'),
                ],
              ),
              SizedBox(height: 10),
              ElevatedButton(
                onPressed: () {
                  _login();
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                  minimumSize: Size(double.infinity, 50),
                ),
                child: Text(
                  'Sign In',
                  style: TextStyle(fontSize: 18, color: Colors.white),
                ),
              ),
              SizedBox(height: 10),
              TextButton(
                onPressed: () {},
                child: Text.rich(
                  TextSpan(
                    text: 'Forgot ',
                    style: TextStyle(color: Colors.black),
                    children: [
                      TextSpan(
                        text: 'Username/Password?',
                        style: TextStyle(color: Colors.blue),
                      ),
                    ],
                  ),
                ),
              ),
              TextButton(
                onPressed: () {
                  Navigator.pushNamed(context, 'register');
                },
                child: Text.rich(
                  TextSpan(
                    text: "Don't have an account? ",
                    style: TextStyle(color: Colors.black,),
                    children: [
                      TextSpan(
                        text: 'Sign up',
                        style: TextStyle(color: Colors.blue),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 20),
              Row(
                children: [
                  Expanded(
                    child: Divider(thickness: 1),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Text('OR'),
                  ),
                  Expanded(
                    child: Divider(thickness: 1),
                  ),
                ],
              ),
              SizedBox(height: 15),
              ElevatedButton.icon(
                onPressed: (){
                  _loginWithGoogle();// Add Google sign-in logic
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                  minimumSize: Size(double.infinity, 50),
                ),
                icon: Icon(Icons.g_mobiledata, color: Colors.white, size: 25),
                label: Text(
                  'Sign in with Google',
                  style: TextStyle(color: Colors.white, fontSize: 16),
                ),
              ),
              SizedBox(height: 10),
              ElevatedButton.icon(
                onPressed: () {
                  // Add Facebook sign-in logic
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue[800],
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                  minimumSize: Size(double.infinity, 50),
                ),
                icon: Icon(Icons.facebook, color: Colors.white),
                label: Text(
                  'Sign in with Facebook',
                  style: TextStyle(color: Colors.white, fontSize: 16),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  _login() async {
    final user = await _auth.loginUserWithEmailAndPassword(_email.text, _password.text);

    if (user != null) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Logged in!')));
      Navigator.pushNamed(context, 'chat_bot');
      log("User Logged In");
      // goToHome(context);
    }else{
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Please Try Again!! With Correct email and password')));
    }
  }

  _loginWithGoogle() async {
    final user = await _auth.loginWithGoogle();
    // print(user);

    if (user != null) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Logged in with Google!')));
      Navigator.pushNamed(context, 'chat_bot');
      log("User Logged In");
      // goToHome(context);
    }else{
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Please Try Again!!')));
    }
  }
}
