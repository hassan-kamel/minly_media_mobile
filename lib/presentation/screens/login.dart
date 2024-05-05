import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:minly_media_mobile/business-logic/bloc/auth/user_bloc.dart';
import 'package:minly_media_mobile/constants/minly_colors.dart';
import 'package:minly_media_mobile/presentation/widgets/button.dart';
import 'package:minly_media_mobile/presentation/widgets/form_errors.dart';
import 'package:minly_media_mobile/presentation/widgets/gradientText.dart';
import 'package:minly_media_mobile/presentation/widgets/text_field.dart';

class LoginPage extends StatefulWidget {
  final Function()? onTap;
  const LoginPage({super.key, required this.onTap});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  void signUserIn(BuildContext context) async {
    BlocProvider.of<UserBloc>(context).add(UserInitialEvent());
    // Validate returns true if the form is valid, or false otherwise.
    if (_formKey.currentState!.validate()) {
      BlocProvider.of<UserBloc>(context).add(UserLoginEvent(
          email: emailController.text, password: passwordController.text));
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<UserBloc, UserState>(
      listener: (context, state) {
        if (state is UserLoggedIn) {
          debugPrint("state ------------------ " + state.toString());
          context.go('/feeds');
        }
      },
      builder: (context, state) {
        return Scaffold(
          backgroundColor: const Color.fromARGB(255, 243, 243, 243),
          resizeToAvoidBottomInset: true,
          body: state is UserGettingAuthenticated
              ? const Center(
                  child: CircularProgressIndicator(),
                )
              : SafeArea(
                  child: SingleChildScrollView(
                    child: Center(
                      child: Form(
                        key: _formKey,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const SizedBox(height: 50),
                            //logo
                            //logo
                            Padding(
                              padding: const EdgeInsets.only(bottom: 20),
                              child: GradientText(
                                'MinlyMedia',
                                style: GoogleFonts.pacifico(
                                  fontSize: 50,
                                ),
                                gradient: LinearGradient(colors: [
                                  MinlyColor.primary_2,
                                  MinlyColor.primary_1,
                                ]),
                              ),
                            ),
                            const SizedBox(height: 10),
                            //welcome back you been missed

                            Text(
                              'Welcome back you\'ve been missed',
                              style: TextStyle(
                                color: Colors.grey[700],
                                fontSize: 15,
                              ),
                            ),
                            const SizedBox(height: 25),

                            state is UserLoginError
                                ? Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 25, vertical: 10),
                                    child: FormError(errors: [
                                      state.message,
                                      ...state.errors
                                    ]),
                                  )
                                : const SizedBox(),
                            //username
                            MyTextField(
                              controller: emailController,
                              hintText: 'email',
                              obscureText: false,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'This Field is Required';
                                }
                                return null;
                              },
                            ),

                            const SizedBox(height: 15),
                            //password
                            MyTextField(
                              controller: passwordController,
                              hintText: 'Password',
                              obscureText: true,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'This Field is Required';
                                }
                                return null;
                              },
                            ),
                            const SizedBox(height: 15),

                            //sign in button
                            MyButton(
                              onTap: () {
                                signUserIn(context);
                              },
                              text: 'Sign In',
                            ),
                            const SizedBox(height: 20),

                            const SizedBox(
                              height: 10,
                            ),

                            // not a member ? register now

                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  'Not a member? ',
                                  style: TextStyle(
                                      color: Colors.grey[600], fontSize: 12),
                                ),
                                GestureDetector(
                                  onTap: widget.onTap,
                                  child: Text(
                                    'Register now',
                                    style: TextStyle(
                                        color: Colors.blue[900],
                                        fontWeight: FontWeight.bold,
                                        fontSize: 15),
                                  ),
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
        );
      },
    );
  }
}
