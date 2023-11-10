import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import '../../helper/analyticsHelper.dart';
import '../../service/authentication.dart';
import 'login.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  MyAnalyticsHelper analyticsHelper = MyAnalyticsHelper();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  TextEditingController _confirmPasswordController = TextEditingController();

  String _email = "";
  String _password = "";
  String _confirmPassword = "";

  bool _signUpStatus = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xffFCFDF5),
        foregroundColor: Color(0xff186F65),
        // shadowColor: Colors.black.withOpacity(0),
        forceMaterialTransparency: true,
      ),
      body: SingleChildScrollView(
        child: SignupPageWidget(),
      ),
    );
  }

  Column SignupPageWidget() {
    return Column(
      children: [
        Container(
          margin: EdgeInsets.only(top: 10, bottom: 50),
          alignment: Alignment.center,
          child: Text(
            "DidaPedia",
            style: TextStyle(
              fontSize: 32,
              fontWeight: FontWeight.bold,
              color: Color(0xff186F65),
              // letterSpacing: 1=,
            ),
          ),
        ),
        Container(
          alignment: Alignment.centerLeft,
          child: Padding(
            padding: const EdgeInsets.only(left: 30, bottom: 20),
            child: Text(
              "Create your Account",
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ),
        Form(
          key: _formKey,
          child: Column(
            children: [
              Container(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: const EdgeInsets.only(left: 30, bottom: 20),
                  child: SizedBox(
                    width: 350,
                    child: Container(
                      decoration: BoxDecoration(
                        color: Color(0xffFCFDF5),
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.2),
                            offset: Offset(2, 2),
                            blurRadius: 3,
                            spreadRadius: 1,
                          ),
                        ],
                      ),
                      child: TextFormField(
                        controller: _emailController,
                        keyboardType: TextInputType.emailAddress,
                        decoration: InputDecoration(
                          border:
                              OutlineInputBorder(borderSide: BorderSide.none),
                          hintText: 'Email',
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Please Enter Your Email";
                          }
                          return null;
                        },
                        onChanged: (value) {
                          setState(() {
                            _email = value;
                          });
                        },
                      ),
                    ),
                  ),
                ),
              ),
              Container(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: const EdgeInsets.only(left: 30, bottom: 20),
                  child: SizedBox(
                    width: 350,
                    child: Container(
                      decoration: BoxDecoration(
                        color: Color(0xffFCFDF5),
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.2),
                            offset: Offset(2, 2),
                            blurRadius: 3,
                            spreadRadius: 1,
                          ),
                        ],
                      ),
                      child: TextFormField(
                        controller: _passwordController,
                        decoration: InputDecoration(
                          border:
                              OutlineInputBorder(borderSide: BorderSide.none),
                          hintText: 'Password',
                        ),
                        obscureText: true,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Please Enter Your Password";
                          } else if (value.length < 6) {
                            return "Password should be at least 6 characters";
                          }
                          return null;
                        },
                        onChanged: (value) {
                          setState(() {
                            _password = value;
                          });
                        },
                      ),
                    ),
                  ),
                ),
              ),
              Container(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: const EdgeInsets.only(left: 30, bottom: 20),
                  child: SizedBox(
                    width: 350,
                    child: Container(
                      decoration: BoxDecoration(
                        color: Color(0xffFCFDF5),
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.2),
                            offset: Offset(2, 2),
                            blurRadius: 3,
                            spreadRadius: 1,
                          ),
                        ],
                      ),
                      child: TextFormField(
                        controller: _confirmPasswordController,
                        decoration: InputDecoration(
                          border:
                              OutlineInputBorder(borderSide: BorderSide.none),
                          hintText: 'Confirm Password',
                        ),
                        obscureText: true,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Please Enter Your Confirm Password";
                          } else if (value != _password) {
                            return "Password don't match";
                          }
                          return null;
                        },
                        onChanged: (value) {
                          setState(() {
                            _confirmPassword = value;
                          });
                        },
                      ),
                    ),
                  ),
                ),
              ),
              Container(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: const EdgeInsets.only(left: 30, bottom: 20),
                  child: SizedBox(
                    width: 350,
                    height: 50,
                    child: ElevatedButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          analyticsHelper.signupLog(_email);
                          _handleSignUp(_email, _password);
                        }
                      },
                      child: Text(
                        "Sign up",
                        style: TextStyle(color: Colors.white),
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color(0xff186F65),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        SizedBox(
          height: 20,
        ),
      ],
    );
  }

  void _handleSignUp(String email, String password) async {
    bool signUp = await authSignUp(email, password);

    setState(() {
      _signUpStatus = signUp;
    });

    if (_signUpStatus)
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (_) => LoginPage(),
        ),
      );
  }
}

class OtherSignin extends StatelessWidget {
  final IconData icon;
  final VoidCallback onPressed;

  const OtherSignin({required this.icon, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 15, vertical: 12),
        decoration: BoxDecoration(
          color: Color(0xffFCFDF5),
          borderRadius: BorderRadius.circular(10.0),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.2),
              offset: Offset(2, 2),
              blurRadius: 3,
              spreadRadius: 1,
            )
          ],
        ),
        child: Icon(
          icon,
          size: 30,
          color: Color(0xff186F65),
        ),
      ),
    );
  }
}
