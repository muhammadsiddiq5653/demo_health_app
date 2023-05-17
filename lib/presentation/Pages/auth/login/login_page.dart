import 'dart:io' show Platform;

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../../domain/export.dart';

class LoginPage extends StatefulWidget {
  static const routename = '/LoginPage';

  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  //  GlobalKey is used to validate the Form
  final GlobalKey<FormState> _formKey = GlobalKey();

  //  A loading variable to show the loading animation when you a function is ongoing
  bool _isLoading = false;
  bool _isLoading2 = false;

  void loading() {
    setState(() {
      _isLoading = !_isLoading;
    });
  }

  void loading2() {
    setState(() {
      _isLoading2 = !_isLoading2;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Consumer(builder: (context, ref, _) {
          //  Consuming a provider using watch method and storing it in a variable
          //  Now we will use this variable to access all the functions of the
          //  authentication
          final auth = ref.watch(authenticationProvider);

          //  Instead of creating a clutter on the onPressed Function
          //  I have decided to create a seperate function and pass them into the
          //  respective parameters.
          //  if you want you can write the exact code in the onPressed function
          //  it all depends on personal preference and code readability
          Future<void> onPressedFunction() async {
            if (!_formKey.currentState!.validate()) {
              return;
            }
            // print(_email.text); // This are your best friend for debugging things
            //  not to mention the debugging tools
            // print(_password.text);
            loading();
            await auth
                .signInWithApple(context)
                .whenComplete(() => auth.authStateChange.listen((event) async {
                      if (event == null) {
                        loading();
                        return;
                      }
                    }));

            //  I had said that we would be using a Loading spinner when
            //  some functions are being performed. we need to check if some
            //  error occured then we need to stop loading spinner so we can retry
            //  Authenticating
          }

          Future<void> loginWithGoogle() async {
            loading2();
            await auth
                .signInWithGoogle(context)
                .whenComplete(() => auth.authStateChange.listen((event) async {
                      if (event == null) {
                        loading2();
                        return;
                      }
                    }));
          }

          return Form(
            key: _formKey,
            child: Column(
              children: [
                Expanded(
                  flex: 3,
                  child: Container(
                    margin: const EdgeInsets.only(top: 48),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: const [
                        Center(child: FlutterLogo(size: 81)),
                        Spacer(flex: 1),
                        Spacer()
                      ],
                    ),
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: Container(
                      width: double.infinity,
                      decoration: const BoxDecoration(color: Colors.white),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Platform.isIOS
                              ? Container(
                                  padding: const EdgeInsets.only(top: 32.0),
                                  margin: const EdgeInsets.symmetric(
                                      horizontal: 16),
                                  width: double.infinity,
                                  child: _isLoading
                                      ? const Center(
                                          child: CircularProgressIndicator())
                                      : MaterialButton(
                                          onPressed: onPressedFunction,
                                          textColor: Colors.blue.shade700,
                                          textTheme: ButtonTextTheme.primary,
                                          minWidth: 100,
                                          padding: const EdgeInsets.all(18),
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(25),
                                            side: BorderSide(
                                                color: Colors.blue.shade700),
                                          ),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: const [
                                              FaIcon(FontAwesomeIcons.apple),
                                              SizedBox(width: 10),
                                              Text(
                                                'Login with Apple',
                                                style: TextStyle(
                                                    fontWeight:
                                                        FontWeight.w600),
                                              ),
                                            ],
                                          ),
                                        ),
                                )
                              : const SizedBox.shrink(),
                          Container(
                            padding: const EdgeInsets.only(top: 32.0),
                            margin: const EdgeInsets.symmetric(horizontal: 16),
                            width: double.infinity,
                            child: _isLoading2
                                ? const Center(
                                    child: CircularProgressIndicator())
                                : MaterialButton(
                                    onPressed: loginWithGoogle,
                                    textColor: Colors.blue.shade700,
                                    textTheme: ButtonTextTheme.primary,
                                    minWidth: 100,
                                    padding: const EdgeInsets.all(18),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(25),
                                      side: BorderSide(
                                          color: Colors.blue.shade700),
                                    ),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: const [
                                        //  A google icon here
                                        //  an External Package used here
                                        //  Font_awesome_flutter package used
                                        FaIcon(FontAwesomeIcons.google),
                                        SizedBox(width: 10),
                                        Text(
                                          ' Login with Google',
                                          style: TextStyle(
                                              fontWeight: FontWeight.w600),
                                        ),
                                      ],
                                    ),
                                  ),
                          ),
                          const Spacer(),
                        ],
                      )),
                )
              ],
            ),
          );
        }),
      ),
    );
  }
}
