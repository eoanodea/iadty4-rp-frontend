/*
 * File: Register.dart
 * Project: src
 * Version <<projectversion>>
 * File Created: Tuesday, 1st December 2020 7:37:50 pm
 * Author: Eoan O'Dea (eoan@web-space.design)
 * -----
 * File Description: 
 * Last Modified: Tuesday, 1st December 2020 8:02:06 pm
 * Modified By: Eoan O'Dea (eoan@web-space.design>)
 * -----
 * Copyright 2020 WebSpace, WebSpace
 */

import 'package:flutter/material.dart';
import 'package:frontend/src/Widget/CustomDivider.dart';
import 'package:frontend/src/services/User.dart';

import 'package:google_fonts/google_fonts.dart';

import 'Login.dart';

class RegisterPage extends StatefulWidget {
  RegisterPage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  User user = User();

  String username = '';
  String usernameError = '';
  String email = '';
  String emailError = '';
  String password = '';
  String passwordError = '';
  String error = '';
  bool isLoading = false;

  void setLoading(bool loading) {
    setState(() {
      isLoading = loading;
    });
  }

  void setError(name, message) {
    setState(() {
      if (name == 'email') emailError = '';
    });
  }

  void register() async {
    setLoading(true);

    if (email == '')
      return setState(() => emailError = 'Email cannot be blank');
    if (username == '')
      return setState(() => usernameError = 'Username cannot be blank');
    if (password == '')
      return setState(() => passwordError = 'Password cannot be blank');

    var authedUser = await user.register(username, email, password);

    setLoading(false);

    if (authedUser == null) return;

    Navigator.pushNamed(context, '/profile',
        arguments: authedUser['data']['user']);
  }

  Widget _backButton() {
    return InkWell(
      onTap: () {
        Navigator.popAndPushNamed(context, '/');
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 10),
        child: Row(
          children: <Widget>[
            Container(
              padding: EdgeInsets.only(left: 0, top: 10, bottom: 10),
              child: Icon(Icons.keyboard_arrow_left, color: Colors.black),
            ),
            Text('Back',
                style: TextStyle(fontSize: 12, fontWeight: FontWeight.w500))
          ],
        ),
      ),
    );
  }

  Widget _entryField(String title, {bool isPassword = false}) {
    void handleChange(name, value) {
      setState(() {
        if (name == 'Email') {
          return email = value;
        }
        if (name == 'Password') {
          return password = value;
        }

        username = value;
      });
    }

    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            title,
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
          ),
          SizedBox(
            height: 10,
          ),
          TextField(
            obscureText: isPassword,
            decoration: InputDecoration(
              border: InputBorder.none,
              fillColor: Color(0xfff3f3f4),
              filled: true,
            ),
            onChanged: (value) => handleChange(title, value),
          )
        ],
      ),
    );
  }

  Widget _submitButton() {
    return GestureDetector(
      onTap: () => register(),
      child: Container(
        width: MediaQuery.of(context).size.width,
        padding: EdgeInsets.symmetric(vertical: 15),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(5)),
          boxShadow: <BoxShadow>[
            BoxShadow(
                color: Colors.grey.shade200,
                offset: Offset(2, 4),
                blurRadius: 5,
                spreadRadius: 2)
          ],
          gradient: LinearGradient(
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
            colors: isLoading
                ? [Colors.grey, Colors.grey]
                : [Color(0xfffbb448), Color(0xfff7892b)],
          ),
        ),
        child: Text(
          isLoading ? 'Registering...' : 'Register',
          style: TextStyle(fontSize: 20, color: Colors.white),
        ),
      ),
    );
  }

  Widget _loginAccountLabel() {
    return InkWell(
      onTap: () {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => LoginPage()));
      },
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 20),
        padding: EdgeInsets.all(15),
        alignment: Alignment.bottomCenter,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Already have an account ?',
              style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600),
            ),
            SizedBox(
              width: 10,
            ),
            Text(
              'Login',
              style: TextStyle(
                  color: Color(0xfff79c4f),
                  fontSize: 13,
                  fontWeight: FontWeight.w600),
            ),
          ],
        ),
      ),
    );
  }

  Widget _title() {
    return RichText(
      text: TextSpan(
        text: 'Register',
        style: GoogleFonts.openSans(
          fontSize: 30,
          fontWeight: FontWeight.w900,
          color: Colors.black,
        ),
      ),
    );
  }

  Widget _emailPasswordWidget() {
    return Column(
      children: <Widget>[
        _entryField("Username"),
        _entryField("Email"),
        _entryField("Password", isPassword: true),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Container(
        height: height,
        child: Stack(
          children: <Widget>[
            // Positioned(
            //   top: -MediaQuery.of(context).size.height * .15,
            //   right: -MediaQuery.of(context).size.width * .4,
            //   child: BezierContainer(),
            // ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    SizedBox(height: height * .2),
                    _title(),
                    SizedBox(
                      height: 50,
                    ),
                    _emailPasswordWidget(),
                    SizedBox(
                      height: 20,
                    ),
                    _submitButton(),
                    SizedBox(height: 55),
                    CustomDivider(),
                    SizedBox(height: 5),
                    _loginAccountLabel(),
                  ],
                ),
              ),
            ),
            Positioned(top: 40, left: 0, child: _backButton()),
          ],
        ),
      ),
    );
  }
}
