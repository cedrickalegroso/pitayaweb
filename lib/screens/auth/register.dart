import 'package:flutter/material.dart';
import 'package:pitaya_web/services/auth.dart';
import 'package:provider/provider.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _mun = TextEditingController();
  final _email = TextEditingController();
  final _pass = TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(color: Colors.greenAccent),
        child: Center(
          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  //LOGO
                  const SizedBox(height: 16),
                  // Align(
                  //   alignment: Alignment.center,
                  //   child: Image.asset(
                  //     'assets/logo-white.png',
                  //     width: 124,
                  //     height: 124,
                  //   ),
                  // ),

                  const Text(
                    'Register',
                    style: TextStyle(
                      fontFamily: 'Inter',
                      fontSize: 16,
                      fontWeight: FontWeight.normal,
                      color: Color(0xFFFFFFFF),
                    ),
                  ),

                  //ALIGNMENT for Register,user, and pass
                  const SizedBox(height: 30),
                  Container(
                    width: 400,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(8)),
                    padding: const EdgeInsets.only(
                        left: 16.0, right: 16.0, top: 24.0, bottom: 24.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5.0),
                            border: Border.all(
                              color: Colors.blueGrey.withOpacity(0.3),
                            ),
                          ),
                          width: double.infinity,
                          child: TextFormField(
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'This is a required field.';
                              }
                              return null;
                            },
                            decoration: InputDecoration(
                                hintText: 'John Doe',
                                labelText: 'Name',
                                focusedErrorBorder: OutlineInputBorder(
                                  borderSide: const BorderSide(
                                      width: 2,
                                      style: BorderStyle.solid,
                                      color: Color.fromARGB(255, 0, 0, 0)),
                                  borderRadius: BorderRadius.circular(4.0),
                                ),
                                errorStyle: const TextStyle(
                                  fontSize: 16,
                                  height: 1,
                                  color: Color.fromARGB(255, 255, 33, 17),
                                ),
                                errorBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(4.0),
                                  borderSide: const BorderSide(
                                      width: 2,
                                      style: BorderStyle.solid,
                                      color: Color.fromARGB(255, 255, 33, 17)),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: const BorderSide(
                                      width: 2,
                                      style: BorderStyle.solid,
                                      color: Color.fromARGB(255, 0, 0, 0)),
                                  borderRadius: BorderRadius.circular(4.0),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(4.0),
                                  borderSide: const BorderSide(
                                      width: 2,
                                      style: BorderStyle.solid,
                                      color:
                                          Color.fromARGB(255, 236, 236, 236)),
                                ),
                                filled: true,
                                labelStyle: const TextStyle(
                                  fontSize: 14,
                                  color: Color.fromARGB(255, 0, 0, 0),
                                ),
                                fillColor: Colors.white),
                            controller: _mun,
                          ),
                        ),

                        //Email
                        const SizedBox(height: 16),

                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5.0),
                            border: Border.all(
                              color: Colors.blueGrey.withOpacity(0.3),
                            ),
                          ),
                          width: double.infinity,
                          child: TextFormField(
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'This is a required field.';
                              }
                              return null;
                            },
                            decoration: InputDecoration(
                                hintText: 'pitaya@gmail.com',
                                labelText: 'Email',
                                focusedErrorBorder: OutlineInputBorder(
                                  borderSide: const BorderSide(
                                      width: 2,
                                      style: BorderStyle.solid,
                                      color: Color.fromARGB(255, 0, 0, 0)),
                                  borderRadius: BorderRadius.circular(4.0),
                                ),
                                errorStyle: const TextStyle(
                                  fontSize: 16,
                                  height: 1,
                                  color: Color.fromARGB(255, 255, 33, 17),
                                ),
                                errorBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(4.0),
                                  borderSide: const BorderSide(
                                      width: 2,
                                      style: BorderStyle.solid,
                                      color: Color.fromARGB(255, 255, 33, 17)),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: const BorderSide(
                                      width: 2,
                                      style: BorderStyle.solid,
                                      color: Color.fromARGB(255, 0, 0, 0)),
                                  borderRadius: BorderRadius.circular(4.0),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(4.0),
                                  borderSide: const BorderSide(
                                      width: 2,
                                      style: BorderStyle.solid,
                                      color:
                                          Color.fromARGB(255, 236, 236, 236)),
                                ),
                                filled: true,
                                labelStyle: const TextStyle(
                                  fontSize: 14,
                                  color: Color.fromARGB(255, 0, 0, 0),
                                ),
                                fillColor: Colors.white),
                            controller: _email,
                          ),
                        ),

                        //Password
                        const SizedBox(height: 16),

                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5.0),
                            border: Border.all(
                              color: Colors.blueGrey.withOpacity(0.3),
                            ),
                          ),
                          width: double.infinity,
                          child: TextFormField(
                            obscureText: true,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'This is a required field.';
                              }
                              return null;
                            },
                            decoration: InputDecoration(
                                hintText: '*******',
                                labelText: 'Password',
                                focusedErrorBorder: OutlineInputBorder(
                                  borderSide: const BorderSide(
                                      width: 2,
                                      style: BorderStyle.solid,
                                      color: Color.fromARGB(255, 0, 0, 0)),
                                  borderRadius: BorderRadius.circular(4.0),
                                ),
                                errorStyle: const TextStyle(
                                  fontSize: 16,
                                  height: 1,
                                  color: Color.fromARGB(255, 255, 33, 17),
                                ),
                                errorBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(4.0),
                                  borderSide: const BorderSide(
                                      width: 2,
                                      style: BorderStyle.solid,
                                      color: Color.fromARGB(255, 255, 33, 17)),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: const BorderSide(
                                      width: 2,
                                      style: BorderStyle.solid,
                                      color: Color.fromARGB(255, 0, 0, 0)),
                                  borderRadius: BorderRadius.circular(4.0),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(4.0),
                                  borderSide: const BorderSide(
                                      width: 2,
                                      style: BorderStyle.solid,
                                      color:
                                          Color.fromARGB(255, 236, 236, 236)),
                                ),
                                filled: true,
                                labelStyle: const TextStyle(
                                  fontSize: 14,
                                  color: Color.fromARGB(255, 0, 0, 0),
                                ),
                                fillColor: Colors.white),
                            controller: _pass,
                          ),
                        ),

                        // SIGN IN BUTTON
                        const SizedBox(height: 24),
                        Container(
                          height: 50,
                          width: double.infinity, // <-- match_parent
                          child: ElevatedButton(
                            onPressed: () async {
                              if (_formKey.currentState!.validate()) {
                                var response = await context
                                    .read<AuthService>()
                                    .registerAdmin(
                                        context: context,
                                        displayName: _mun.text.trim(),
                                        password: _pass.text.trim(),
                                        email: _email.text.trim());

                                response == 'Success'
                                    ? _showMessageSuccess()
                                    : _showMessageError(response);
                              }
                            },
                            style: ElevatedButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8.0),
                              ),
                            ),
                            child: const Text('Register'),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 32),
                  Text(
                    '© Pitaya 2023',
                    style: TextStyle(color: Colors.white),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _showMessageError(msg) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        backgroundColor: Colors.red,
        content: Text(
          msg,
          style: const TextStyle(color: Colors.white),
        )));
  }

  void _showMessageSuccess() {
    Navigator.pushNamed(context, '/authCheck');
  }
}
