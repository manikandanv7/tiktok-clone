import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:tiktok_clone/constants.dart';
import 'package:tiktok_clone/views/screens/auth/sign_up_screen.dart';
import 'package:tiktok_clone/views/widgets/text_input_field.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({Key? key}) : super(key: key);
  TextEditingController _emailcontroller = TextEditingController();
  TextEditingController _passwordcontroller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      alignment: Alignment.center,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'Tiktok',
            style: TextStyle(
                fontWeight: FontWeight.w900, fontSize: 35, color: buttonColor),
          ),
          const Text(
            'Login',
            style: TextStyle(fontWeight: FontWeight.w700, fontSize: 25),
          ),
          Container(
            width: MediaQuery.of(context).size.width,
            margin: EdgeInsets.symmetric(horizontal: 20),
            child: TextInputField(
              controller: _emailcontroller,
              icon: Icons.email_rounded,
              label: 'Email',
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Container(
            width: MediaQuery.of(context).size.width,
            margin: EdgeInsets.symmetric(horizontal: 20),
            child: TextInputField(
              controller: _passwordcontroller,
              icon: Icons.lock,
              label: 'Password',
              isObscure: true,
            ),
          ),
          const SizedBox(height: 30),
          Container(
            width: MediaQuery.of(context).size.width - 40,
            height: 50,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: buttonColor,
            ),
            child: InkWell(
              onTap: () => authcontroller.login(
                  _emailcontroller.text, _passwordcontroller.text),
              child: Center(
                  child: Text(
                'Login',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
              )),
            ),
          ),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'Don\'t you have an account? ',
                style: TextStyle(fontSize: 20),
              ),
              InkWell(
                onTap: () => Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => SignupScreen(),
                  ),
                ),
                child: Text(
                  'Register',
                  style: TextStyle(
                      fontSize: 20,
                      color: buttonColor,
                      decorationColor: Colors.white),
                ),
              )
            ],
          )
        ],
      ),
    ));
  }
}
