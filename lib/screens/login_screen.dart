import 'package:adsifiedhub/services/auth.dart';
import 'package:adsifiedhub/widgets/ok_dialog_widget.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _isLoading = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
              'Login',
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
                  labelText: 'Email Address', border: OutlineInputBorder()),
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
              obscureText: true,
              controller: _passwordController,
            ),
            SizedBox(
              height: 20,
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
                    if (_emailController.text.isNotEmpty &&
                        _passwordController.text.isNotEmpty) {
                      final result = await AuthService().login(
                          email: _emailController.text,
                          password: _passwordController.text);

                      if (result != null) {
                        setState(() {
                          _isLoading = false;
                        });
                        Navigator.pop(context);
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
                      showDialog(
                          context: context,
                          builder: (_) => okDialogWidget(
                              context: context,
                              message: 'Please enter all required details.'));
                    }
                  },
                  child: Text(
                    'Access Your Account',
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
                    onPressed: () {}, icon: FaIcon(FontAwesomeIcons.facebook)),
                IconButton(
                    onPressed: () {}, icon: FaIcon(FontAwesomeIcons.google)),
              ],
            ),
            SizedBox(
              height: 20,
            ),
          ],
        ),
      )),
    );
  }
}
