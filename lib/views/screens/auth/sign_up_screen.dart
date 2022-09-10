// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:tiktok_clone/constants.dart';
import 'package:tiktok_clone/views/screens/auth/login_screen.dart';
import 'package:tiktok_clone/views/widgets/text_input_field.dart';

class SignupScreen extends StatelessWidget {
  TextEditingController _emailcontroller = TextEditingController();
  TextEditingController _passwordcontroller = TextEditingController();
  TextEditingController _usernamecontroller = TextEditingController();
  SignupScreen({Key? key}) : super(key: key);

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
          SizedBox(
            height: 10,
          ),
          const Text(
            'SignUp',
            style: TextStyle(fontWeight: FontWeight.w700, fontSize: 25),
          ),
          Stack(
            children: [
              CircleAvatar(
                  radius: 65,
                  backgroundColor: Colors.yellow,
                  backgroundImage: NetworkImage(
                      'https://i.pinimg.com/originals/e2/7c/87/e27c8735da98ec6ccdcf12e258b26475.png')),
              Positioned(
                  bottom: -10,
                  left: 80,
                  child: IconButton(
                    icon: Icon(Icons.add_a_photo),
                    onPressed: () => authcontroller.pickimage(),
                  ))
            ],
          ),
          const SizedBox(
            height: 15,
          ),
          Container(
            width: MediaQuery.of(context).size.width,
            margin: EdgeInsets.symmetric(horizontal: 20),
            child: TextInputField(
              controller: _usernamecontroller,
              icon: Icons.email_rounded,
              label: 'Username',
            ),
          ),
          const SizedBox(
            height: 15,
          ),
          Container(
            width: MediaQuery.of(context).size.width,
            margin: const EdgeInsets.symmetric(horizontal: 20),
            child: TextInputField(
              controller: _emailcontroller,
              icon: Icons.email_rounded,
              label: 'Email',
            ),
          ),
          const SizedBox(
            height: 15,
          ),
          Container(
            width: MediaQuery.of(context).size.width,
            margin: const EdgeInsets.symmetric(horizontal: 20),
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
              onTap: (() => authcontroller.registeruser(
                  _usernamecontroller.text,
                  _emailcontroller.text,
                  _passwordcontroller.text,
                  authcontroller.profilephoto)),
              child: Center(
                  child: Text(
                'Register',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
              )),
            ),
          ),
          const SizedBox(height: 15),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'Already an user? ',
                style: TextStyle(fontSize: 20),
              ),
              InkWell(
                onTap: () => Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => LoginScreen(),
                  ),
                ),
                child: Text(
                  'Login',
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
