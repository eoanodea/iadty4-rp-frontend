// @dart=2.9
import 'package:flutter/material.dart';
import 'package:frontend/src/Widget/CustomDivider.dart';
import 'package:frontend/src/components/utils.dart';
import 'package:frontend/src/data/Auth.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

import '../constants.dart';
import 'Login.dart';

class RegisterPage extends StatefulWidget {
  RegisterPage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  String username = '';
  String usernameError = '';
  String email = '';
  String emailError = '';
  String password = '';
  String passwordError = '';
  String confirmPassword = '';
  String confirmPasswordError = '';
  String error = '';

  bool isLoading = false;

  final _formKey = GlobalKey<FormState>();

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

  Widget _backButton() {
    return InkWell(
      onTap: () {
        Navigator.pop(context);
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
        if (name == "Confirm Password") return confirmPassword = value;
        username = value;
      });
    }

    return TextFormField(
      validator: (value) {
        if (value.length < 3) {
          return '$title must be more than 3 characters';
        }
        if (title == 'Email') {
          Pattern pattern =
              r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
          RegExp regex = new RegExp(pattern);
          if (!regex.hasMatch(value)) return 'Please enter a valid email';
        }
        if (title == "Confirm Password" && value != password) {
          return "Value must equal password";
        }
        if (value.isEmpty) {
          return '$title cannot be blank';
        }
        return null;
      },
      obscureText: isPassword,
      keyboardType:
          title == 'Email' ? TextInputType.emailAddress : TextInputType.text,
      decoration: InputDecoration(
        border: InputBorder.none,
        fillColor: Color(0xfff3f3f4),
        filled: true,
        labelText: '$title',
      ),
      onChanged: (value) => handleChange(title, value),
    );
  }

  Widget _submitButton(formKey, RunMutation runMutation) {
    return GestureDetector(
      onTap: () => {
        if (formKey.currentState.validate())
          {
            setLoading(true),
            runMutation(
                {"name": username, "email": email, "password": password})
          }
      },
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
          style: kbodyTextStyle.copyWith(color: Colors.white),
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
              style: kSubbodyTextStyle,
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
        style: kHeadingTextStyle.copyWith(color: Colors.black),
      ),
    );
  }

  Widget _emailPasswordWidget(RunMutation runMutation) {
    return Form(
      key: _formKey,
      child: Column(
        children: <Widget>[
          _entryField("Username"),
          SizedBox(
            height: 50,
          ),
          _entryField("Email"),
          SizedBox(
            height: 50,
          ),
          _entryField("Password", isPassword: true),
          SizedBox(
            height: 50,
          ),
          _entryField("Confirm Password", isPassword: true),
          SizedBox(
            height: 50,
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 30.0),
            child: RichText(
              text: TextSpan(
                text: '$error',
                style:
                    TextStyle(color: Colors.red, fontWeight: FontWeight.bold),
              ),
            ),
          ),
          _submitButton(_formKey, runMutation)
        ],
      ),
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
            Mutation(
                options: MutationOptions(
                  errorPolicy: ErrorPolicy.all,
                  documentNode: gql(Auth.register),
                  update: (Cache cache, QueryResult result) {
                    if (result.hasException) {
                      UtilFs.showToast("Register Failed", context);

                      if (result.exception.clientException
                          is NetworkException) {
                        // handle network issues, maybe
                        print("Network Exception!");
                        setState(() {
                          error = "Could not connect to server";
                        });
                        return cache;
                      }

                      setState(() {
                        error = result.exception.graphqlErrors[0].message;
                      });
                      return cache;
                    }
                    return cache;
                  },
                  onError: (dynamic error) {
                    print("Error!! $error");
                  },
                  onCompleted: (dynamic result) async {
                    setState(() {
                      isLoading = false;
                      error = "";
                    });
                    if (result == null) {
                      return;
                    }

                    if (result.data != null) {
                      // print(result.data['login']['token']);
                      // String token = result.data['login']['token'];
                      UtilFs.showToast("Register Successful", context);
                      // await sharedPreferenceService.setToken(token);
                      // Config.initailizeClient(token);
                      Navigator.pushReplacementNamed(context, "/login");
                      return;
                    }
                  },
                ),
                builder: (RunMutation runMutation, QueryResult result) {
                  return Container(
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
                          _emailPasswordWidget(runMutation),
                          SizedBox(
                            height: 20,
                          ),
                          SizedBox(height: 55),
                          CustomDivider(),
                          SizedBox(height: 5),
                          _loginAccountLabel(),
                        ],
                      ),
                    ),
                  );
                }),
            Positioned(top: 40, left: 0, child: _backButton()),
          ],
        ),
      ),
    );
  }
}
