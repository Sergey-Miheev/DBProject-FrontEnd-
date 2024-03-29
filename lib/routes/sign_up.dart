import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import '../callApi/check_registered_email.dart';
import '../callApi/create_account.dart';

class SignUp extends StatelessWidget {
  SignUp({Key? key}) : super(key: key);

  String _name = "";
  String _email = "";
  String _pw = "";
  String _dateOfBirthday = "";
  bool isDuplicate = false;

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
                        {(value == _pw ? isDuplicate = true : isDuplicate = false)},
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
                          final bool isValid = EmailValidator.validate(_email);
                          if (isValid) {
                            if (isDuplicate) {
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
                          } else {
                            showDialog(
                                context: context,
                                builder: (BuildContext context) => AlertDialog(
                                  title: const Text(
                                      "Email адрес некорректен"),
                                  content: const Text(
                                      "Проверьте, пожалуйста, введённый адрес почты"),
                                  actions: <Widget>[
                                    TextButton(
                                      onPressed: () =>
                                          Navigator.pop(context, 'sign_up'),
                                      child: const Text('Хорошо'),
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
