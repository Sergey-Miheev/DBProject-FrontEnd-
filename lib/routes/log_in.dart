import 'package:flutter/material.dart';
import '../callApi/checkingExistenceOfAccount.dart';
import '../models/account.dart';

class Authorization extends StatelessWidget {
  Authorization({Key? key}) : super(key: key);

  String _email = "";
  String _pw = "";
  Account? account;
  int role = 0;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Log in"),
          centerTitle: true,
        ),
        body: SafeArea(
          child: ListView(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            children: [
              const SizedBox(
                height: 80,
              ),
              TextField(
                decoration: const InputDecoration(labelText: "Email"),
                onChanged: (String value) => {_email = value},
              ),
              const SizedBox(
                height: 12,
              ),
              TextField(
                obscureText: true,
                decoration: const InputDecoration(labelText: "Password"),
                onChanged: (String value) => {_pw = value},
              ),
              OverflowBar(
                alignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                      onPressed: () {
                        Navigator.pushNamed(context, '/');
                      },
                      child: const Text("CANCEL")),
                  ElevatedButton(
                    child: const Text("LOG IN"),
                    onPressed: () async {
                      account = await checkingExistenceOfAccount(_email.trim(), _pw.trim());
                      if ((account != null)) {
                        role = account!.role;
                        Navigator.pushNamed(context, "/cities", arguments: role);
                      }
                      //if (await checkRegisterOfEmail(_email, _pw) != null) {
                      else {
                        showDialog(
                            context: context,
                            builder: (BuildContext context) => AlertDialog(
                              title: const Text("Слышь тебе сюда нельзя"),
                              content:
                              const Text("Заходи не бойся, уходи не плачь"),
                              actions: <Widget>[
                                TextButton(
                                  onPressed: () =>
                                      Navigator.pop(context, 'sign_in'),
                                  child: const Text('Понял'),
                                )
                              ],
                            ));
                      }
                    },
                  ),
                ],
              )
            ],
          ),
        ),
      ),
      onWillPop: () async {
        Navigator.pushNamedAndRemoveUntil(context, '/', (r) => false);
        return Future.value(true);
      },
    );
  }
}
