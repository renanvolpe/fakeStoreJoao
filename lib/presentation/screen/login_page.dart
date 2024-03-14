import 'package:another_flushbar/flushbar.dart';
import 'package:fake_store_joao/core/default/button_default.dart';
import 'package:fake_store_joao/core/default/textfield_decoration_default.dart';
import 'package:fake_store_joao/core/themes/colors_app.dart';
import 'package:fake_store_joao/core/themes/style.dart';
import 'package:fake_store_joao/data/repositories/authentication_repository.dart';
import 'package:fake_store_joao/logic/bloc/get_user/get_user_bloc.dart';
import 'package:fake_store_joao/logic/bloc/login/login_bloc.dart';
import 'package:fake_store_joao/presentation/commum_widgets/resumed_sizedbox.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  late LoginBloc loginController;
  late GetUserBloc getUserController;
  @override
  void initState() {
    loginController = LoginBloc(AuthenticationRepository());
    getUserController = GetUserBloc(AuthenticationRepository());
    super.initState();
  }

  var emailController = TextEditingController();
  var passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        BlocListener<LoginBloc, LoginState>(
          bloc: loginController,
          listener: (context, state) async {
            if (state is LoginSuccess) {
              //it calls the get it to save Users data
              getUserController.add(GetUserStarted(state.token));
            }
            if (state is LoginFailure) {
              // ignore: use_build_context_synchronously
              Flushbar(
                title: 'Erro de login',
                backgroundColor: Colors.red,
                flushbarPosition: FlushbarPosition.BOTTOM,
                message: 'Revise as infomações de login',
                duration: const Duration(seconds: 2),
              ).show(context);
            }
          },
        ),
        BlocListener<GetUserBloc, GetUserState>(
          bloc: getUserController,
          listener: (context, state) async {
            if (state is GetUserSuccess) {
              await Flushbar(
                title: 'Login realizado com sucesso',
                backgroundColor: Colors.green,
                flushbarPosition: FlushbarPosition.BOTTOM,
                message: 'Aprecia as funcionalidades do app',
                duration: const Duration(milliseconds: 1500),
              ).show(context);
              // ignore: use_build_context_synchronously
              context.pushReplacement("/home");
            }
            if (state is GetUserFailure) {
              Flushbar(
                title: 'Erro de login',
                backgroundColor: Colors.red,
                flushbarPosition: FlushbarPosition.BOTTOM,
                message: 'Revise as infomações de login',
                duration: const Duration(seconds: 2),
              ).show(context);
            }
          },
        ),
      ],
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        backgroundColor: Colors.lightBlue,
        body: Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/images/background_image.jpg'),
              fit: BoxFit.cover, // Adjust as per your need
            ),
          ),
          child: Center(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      'Volpe´s Store',
                      style: Style.defaultLightTextStyle.copyWith(fontSize: 40, fontWeight: FontWeight.w600),
                    ),
                    20.sizeH,
                    Text(
                      'It´s a test app to show my abbilityies',
                      textAlign: TextAlign.center,
                      style: Style.defaultLightTextStyle.copyWith(fontSize: 22, fontWeight: FontWeight.w500),
                    ),
                    150.sizeH,
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        35.sizeH,
                        TextFormField(
                          controller: emailController,
                          decoration: textfieldDecorationDefault(hintText: "Email", prefixIcon: Icons.email_outlined),
                          cursorColor: Colors.grey,
                        ),
                        25.sizeH,
                        TextFormField(
                          controller: passwordController,
                          decoration:
                              textfieldDecorationDefault(hintText: "Password", prefixIcon: Icons.lock_outline_rounded),
                          cursorColor: Colors.grey,
                        ),
                        25.sizeH,
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Forgot Password',
                              style: Style.defaultLightTextStyle.copyWith(fontSize: 16, fontWeight: FontWeight.w600),
                            ),
                          ],
                        ),
                        25.sizeH,
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Expanded(
                                child: InkWell(
                              onTap: () =>
                                  loginController.add(LoginStarted(emailController.text, passwordController.text)),
                              child: const ButtonBorderPrimary(text: "Sign in"),
                            ))
                          ],
                        ),
                        25.sizeH,
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Expanded(
                              child: InkWell(
                                  onTap: () {
                                    context.push("/register");
                                  },
                                  child: RichText(
                                    textAlign: TextAlign.center,
                                    text: TextSpan(
                                      style: Style.defaultLightTextStyle,
                                      children: <TextSpan>[
                                        const TextSpan(text: 'Didn´t have any account? '),
                                        TextSpan(
                                          text: 'Sign Up here',
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            decoration: TextDecoration.underline,
                                            color: ColorsApp.kPrimary,
                                          ),
                                        ),
                                      ],
                                    ),
                                  )),
                            )
                          ],
                        )
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
