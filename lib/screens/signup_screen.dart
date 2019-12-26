import 'package:flutter/material.dart';
import 'package:flutter_instagram_clone/services/auth_service.dart';

class SignupScreen extends StatefulWidget {
  static final String id = "signup_screen";

  @override
  _SignupScreenState createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final _formKey = GlobalKey<FormState>();
  String _name, _email, _password = '';

  void _submit() {
    if (_formKey.currentState.validate()) {
      _formKey.currentState.save();
      print("Name: $_name");
      print("Email: $_email");
      print("Password: $_password");

      AuthService.signupUser(context, _name, _email, _password);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Text(
                "Instagram",
                style: TextStyle(fontFamily: 'Billabong', fontSize: 50.0),
              ),
              Form(
                key: _formKey,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 30.0, vertical: 10.0),
                      child: TextFormField(
                        decoration: InputDecoration(
                          labelText: "Name",
                          labelStyle:
                              TextStyle(fontSize: 20.0, fontFamily: 'Verdana'),
                        ),
                        validator: (input) => !input.trim().isEmpty
                            ? null
                            : "Your name is required!",
                        onSaved: (input) => _name = input,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 30.0, vertical: 10.0),
                      child: TextFormField(
                        decoration: InputDecoration(
                          labelText: "Email",
                          labelStyle:
                              TextStyle(fontSize: 20.0, fontFamily: 'Verdana'),
                        ),
                        validator: (input) => input.contains('@')
                            ? null
                            : "Enter a valid emailID",
                        onSaved: (input) => _email = input,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 30.0, vertical: 10.0),
                      child: TextFormField(
                        decoration: InputDecoration(
                          labelText: "Password",
                          labelStyle:
                              TextStyle(fontSize: 20.0, fontFamily: 'Verdana'),
                        ),
                        validator: (input) => input.length >= 6
                            ? null
                            : "Must be atleast 6 characters",
                        onSaved: (input) => _password = input,
                        obscureText: true,
                      ),
                    ),
                    SizedBox(
                      height: 30.0,
                    ),
                    Container(
                      width: 200.0,
                      height: 40.0,
                      child: FlatButton(
                        color: Colors.redAccent,
                        onPressed: _submit,
                        child: Text(
                          "Sign Up",
                          style: TextStyle(
                            fontFamily: 'Verdana',
                            color: Colors.white,
                            fontSize: 20.0,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 20.0),
                    FlatButton(
                      child: Text(
                        "Back To Login",
                        style: TextStyle(
                            fontSize: 15.5,
                            fontFamily: 'Verdana',
                            color: Colors.blueAccent,
                            decoration: TextDecoration.underline),
                      ),
                      onPressed: () => Navigator.pop(context),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
