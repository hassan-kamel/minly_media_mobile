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

class SignupPage extends StatefulWidget {
  final Function() onTap;
  const SignupPage({super.key, required this.onTap});

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  final fullNameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  final _signUpFormKey = GlobalKey<FormState>();

  void signUserUp() async {
    BlocProvider.of<UserBloc>(context).add(UserInitialEvent());
    // Validate returns true if the form is valid, or false otherwise.
    if (_signUpFormKey.currentState!.validate()) {
      if (passwordController.text == confirmPasswordController.text) {
        BlocProvider.of<UserBloc>(context).add(UserSignupEvent(
            fullName: fullNameController.text,
            email: emailController.text,
            password: passwordController.text));
      } else {
        BlocProvider.of<UserBloc>(context)
            .add(const UserAuthErrorEvent(message: 'passwords do not match'));
      }
    } else {
      debugPrint('form not valid');
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<UserBloc, UserState>(
      listener: (context, state) {
        if (state is UserLoggedIn) {
          debugPrint("state ------------------ $state");
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
                        key: _signUpFormKey,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const SizedBox(height: 50),
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
                              controller: fullNameController,
                              hintText: 'full name',
                              obscureText: false,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'This Field is Required';
                                }
                                return null;
                              },
                            ),
                            const SizedBox(height: 15),
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

                            MyTextField(
                              controller: confirmPasswordController,
                              hintText: 'Confirm Password',
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
                              onTap: signUserUp,
                              text: 'Sign Up',
                            ),
                            const SizedBox(height: 20),

                            // not a member ? register now

                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  'Already have an account? ',
                                  style: TextStyle(
                                      color: Colors.grey[600], fontSize: 12),
                                ),
                                GestureDetector(
                                  onTap: widget.onTap,
                                  child: Text(
                                    'Login now',
                                    style: TextStyle(
                                        color: Colors.blue[900],
                                        fontWeight: FontWeight.bold,
                                        fontSize: 14),
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
