import 'package:adsifiedhub/services/auth_service.dart';
import 'package:adsifiedhub/services/database_service.dart';
import 'package:adsifiedhub/widgets/loading_widget.dart';
import 'package:adsifiedhub/widgets/ok_dialog_widget.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../constants.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    return _isLoading
        ? LoadingWidget()
        : Scaffold(
            body: SafeArea(
                child: SingleChildScrollView(
              padding: EdgeInsets.all(20),
              child: Column(
                children: [
                  Container(
                    height: 150,
                    decoration: BoxDecoration(
                        image: DecorationImage(
                            image: AssetImage('images/logo.png'),
                            fit: BoxFit.contain)),
                  ),
                  Text(
                    'Register',
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    'Please enter all details',
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.grey),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  TextField(
                    decoration: InputDecoration(
                        labelText: 'Full Name / Company Name',
                        border: OutlineInputBorder()),
                    keyboardType: TextInputType.text,
                    controller: _nameController,
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  TextField(
                    decoration: InputDecoration(
                        labelText: 'Email Address',
                        border: OutlineInputBorder()),
                    keyboardType: TextInputType.emailAddress,
                    controller: _emailController,
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  TextField(
                    decoration: InputDecoration(
                        labelText: 'Password', border: OutlineInputBorder()),
                    keyboardType: TextInputType.visiblePassword,
                    controller: _passwordController,
                    obscureText: true,
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  TextField(
                    decoration: InputDecoration(
                        labelText: 'Confirm Password',
                        border: OutlineInputBorder()),
                    keyboardType: TextInputType.visiblePassword,
                    controller: _confirmPasswordController,
                    obscureText: true,
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  SizedBox(
                    height: 45,
                    width: double.infinity,
                    child: ElevatedButton(
                        onPressed: () async {
                          setState(() {
                            _isLoading = true;
                          });
                          if (_nameController.text.isNotEmpty &&
                              _emailController.text.isNotEmpty &&
                              _passwordController.text.isNotEmpty &&
                              _confirmPasswordController.text.isNotEmpty) {
                            if (_passwordController.text ==
                                _confirmPasswordController.text) {
                              final result = await AuthService().register(
                                  email: _emailController.text,
                                  password: _passwordController.text);
                              if (result != null) {
                                await DatabaseService(uid: result.uid)
                                    .setAdvertiserProfile(
                                        image: Constants().ads,
                                        emailAddress: _emailController.text,
                                        companyName: _nameController.text,
                                        phoneNumber: '+26879499014',
                                        secondaryNumber: '+26876960405',
                                        region: 'Manzini',
                                        city: 'Lobamba Lomdzala',
                                        streetName: 'Mahlanya',
                                        websiteLink: 'https://adsifiedhub.com/',
                                        businessType: 'Sole Proprietorship',
                                        numberOfFreeAds: 0,
                                        totalAds: 0)
                                    .then((value) {
                                  setState(() {
                                    _isLoading = false;
                                  });
                                  Navigator.pop(context);
                                }).catchError((onError) {
                                  setState(() {
                                    _isLoading = false;
                                  });
                                  showDialog(
                                      context: context,
                                      builder: (_) => okDialogWidget(
                                          context: context,
                                          message: onError.toString()));
                                });
                              } else {
                                setState(() {
                                  _isLoading = false;
                                });
                                showDialog(
                                    context: context,
                                    builder: (_) => okDialogWidget(
                                        context: context,
                                        message:
                                            'Something went wrong, Please try again'));
                              }
                            } else {
                              setState(() {
                                _isLoading = false;
                              });
                              _passwordController.clear();
                              _confirmPasswordController.clear();
                              showDialog(
                                  context: context,
                                  builder: (_) => okDialogWidget(
                                      context: context,
                                      message: 'Passwords do not match'));
                            }
                          } else {
                            setState(() {
                              _isLoading = false;
                            });
                            showDialog(
                                context: context,
                                builder: (_) => okDialogWidget(
                                    context: context,
                                    message:
                                        'Please enter all required details.'));
                          }
                        },
                        child: Text(
                          'Create Your Account',
                          style: TextStyle(fontSize: 18, color: Colors.white),
                        )),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Divider(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      IconButton(
                          onPressed: () {},
                          icon: FaIcon(FontAwesomeIcons.facebook)),
                      IconButton(
                          onPressed: () {},
                          icon: FaIcon(FontAwesomeIcons.google)),
                    ],
                  ),
                  SizedBox(
                    height: 20,
                  )
                ],
              ),
            )),
          );
  }
}
