import 'package:flutter/material.dart';

class Welcome extends StatelessWidget {
  const Welcome({Key? key}) : super(key: key);

  //final _sizeTextBlack = const TextStyle(fontSize: 20.0, color: Colors.black);
  final _sizeTextWhite = const TextStyle(fontSize: 20.0, color: Colors.white);
  final _sizeHeadingTextBlue =
  const TextStyle(fontSize: 30.0, color: Colors.blue);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text("Welcome", style: _sizeHeadingTextBlue),
                Padding(
                  padding: EdgeInsets.only(top: 25.0),
                  child: MaterialButton(
                    color: Theme.of(context).colorScheme.secondary,
                    height: 50.0,
                    minWidth: 150.0,
                    child: Text(
                      "Log in",
                      style: _sizeTextWhite,
                    ),
                    onPressed: () {
                      Navigator.pushNamed(context, '/log_in');
                    },
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 25.0),
                  child: MaterialButton(
                    color: Theme.of(context).colorScheme.secondary,
                    height: 50.0,
                    minWidth: 150.0,
                    child: Text(
                      "Sign up",
                      style: _sizeTextWhite,
                    ),
                    onPressed: () {
                      Navigator.pushNamed(context, '/register');
                    },
                  ),
                )
              ],
            )));
  }
}