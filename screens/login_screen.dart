import 'package:flutter/material.dart';
import 'registration_screen.dart';
import 'package:provider/provider.dart';
import './toss.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final key1 = GlobalKey<FormState>();
  final _passFocusNode = FocusNode();
  var username = '';

  void _saveForm() {
    final isValid = key1.currentState.validate();
    if (!isValid) {
      return;
    }
    key1.currentState.save();
    Navigator.of(context).pushReplacementNamed(Toss.routeName);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Score-Pad'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.assignment_ind),
            onPressed: () {
              Navigator.of(context).pushNamed(RegistrationScreen.routeName);
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Form(
          key: key1,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                SizedBox(
                  height: 50,
                ),
                Text(
                  'Login',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: Colors.grey[800],
                      fontSize: 40,
                      fontWeight: FontWeight.w800),
                ),
                SizedBox(
                  height: 50,
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 30, vertical: 4),
                  child: Card(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15)),
                    child: Padding(
                      padding: const EdgeInsets.only(left: 10.0, bottom: 5),
                      child: TextFormField(
                        textInputAction: TextInputAction.next,
                        onFieldSubmitted: (_) {
                          FocusScope.of(context).requestFocus(_passFocusNode);
                        },
                        validator: (value) {
                          if (value != 'harsh') {
                            return ('Username is invalid');
                          } else
                            return null;
                        },
                        decoration: InputDecoration(
                            border: InputBorder.none,
                            labelText: 'username',
                            labelStyle: TextStyle(color: Colors.grey)),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 30, vertical: 4),
                  child: Card(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15)),
                    child: Padding(
                      padding: const EdgeInsets.only(left: 10.0, bottom: 5),
                      child: TextFormField(
                        focusNode: _passFocusNode,
                        obscureText: true,
                        validator: (value) {
                          if (value != 'harsh') {
                            return ('The password is incorrect!');
                          } else
                            return null;
                        },
                        onFieldSubmitted: (_) {
                          _saveForm();
                        },
                        decoration: InputDecoration(
                            border: InputBorder.none,
                            labelText: 'password',
                            labelStyle: TextStyle(color: Colors.grey)),
                      ),
                    ),
                  ),
                ),
                Divider(),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 30, vertical: 4),
                  child: Card(
                    color: Colors.lightBlue,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15)),
                    child: Padding(
                      padding: const EdgeInsets.only(
                          left: 10.0, bottom: 10, top: 10),
                      child: FlatButton(
                        onPressed: _saveForm,
                        child: Text(
                          'LOGIN',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w800,
                              color: Colors.white),
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 30,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
