import 'package:flutter/material.dart';
import '../callApi/checkRegisteredEmail.dart';
import '../callApi/createAccount.dart';

class SignUp extends StatelessWidget {
  SignUp({Key? key}) : super(key: key);

  String _name = "";
  String _email = "";
  String _pw = "";
  String _dateOfBirthday = "";
  bool duplicate = false;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      child: Scaffold(
          appBar: AppBar(
            title: const Text("Регистрация"),
            centerTitle: true,
          ),
          body: SafeArea(
            child: ListView(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                children: <Widget>[
                  TextField(
                    decoration: const InputDecoration(labelText: "Имя"),
                    onChanged: (String value) => {_name = value},
                  ),
                  TextField(
                    decoration: const InputDecoration(labelText: "Email"),
                    onChanged: (String value) => {_email = value},
                  ),
                  TextField(
                    decoration:
                        const InputDecoration(labelText: "Дата рождения(ГГГГ-ММ-ДД)"),
                    onChanged: (String value) => {_dateOfBirthday = value},
                  ),
                  TextField(
                    obscureText: true,
                    decoration: const InputDecoration(labelText: "Пароль"),
                    onChanged: (String value) => {_pw = value},
                  ),
                  TextField(
                    obscureText: true,
                    decoration:
                        const InputDecoration(labelText: "Повторите пароль"),
                    onChanged: (String value) =>
                        {(value == _pw ? duplicate = true : duplicate = false)},
                  ),
                  OverflowBar(
                    alignment: MainAxisAlignment.end,
                    children: [
                      TextButton(
                          onPressed: () {
                            Navigator.pushNamed(context, '/log_in');
                          },
                          child: const Text("НАЗАД")),
                      ElevatedButton(
                        child: const Text("ЗАРЕГИСТРИРОВАТЬСЯ"),
                        onPressed: () async {
                          if (duplicate) {
                            if (await checkRegisteredEmail(_email) == null) {
                              if (await createAccount(
                                  _name, _email, _dateOfBirthday, _pw) !=
                                  null) {
                                Navigator.pushNamed(context, "/");
                              }
                              else {
                                showDialog(
                                    context: context,
                                    builder: (BuildContext context) => AlertDialog(
                                      title: const Text(
                                          "Ошибка сервера, попробуйте снова!"),
                                      content: const Text(
                                          "Заходи не бойся, уходи не плачь"),
                                      actions: <Widget>[
                                        TextButton(
                                          onPressed: () =>
                                              Navigator.pop(context, 'sign_up'),
                                          child: const Text('Понял'),
                                        )
                                      ],
                                    ));
                              }
                            } else {
                              showDialog(
                                  context: context,
                                  builder: (BuildContext context) => AlertDialog(
                                    title: const Text(
                                        "Данная почта уже зарегистрирована!"),
                                    content: const Text(
                                        "Заходи не бойся, уходи не плачь"),
                                    actions: <Widget>[
                                      TextButton(
                                        onPressed: () =>
                                            Navigator.pop(context, 'sign_up'),
                                        child: const Text('Понял'),
                                      )
                                    ],
                                  ));
                            }
                          }
                          else {
                            showDialog(
                                context: context,
                                builder: (BuildContext context) => AlertDialog(
                                  title: const Text(
                                      "Пароли не совпадают!"),
                                  content: const Text(
                                      "Заходи не бойся, уходи не плачь"),
                                  actions: <Widget>[
                                    TextButton(
                                      onPressed: () =>
                                          Navigator.pop(context, 'sign_up'),
                                      child: const Text('Извиняюсь'),
                                    )
                                  ],
                                ));
                          }
                        },
                      ),
                    ],
                  ),
                ]),
          )),
      onWillPop: () async {
        Navigator.pushNamedAndRemoveUntil(context, '/', (r) => false);
        return Future.value(true);
      },
    );
  }
}
