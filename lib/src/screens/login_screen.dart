import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vuelos_fl/src/providers/login_form_provider.dart';
import 'package:vuelos_fl/src/screens/home_tab_screen.dart';
import 'package:vuelos_fl/src/services/notifications_service.dart';
import 'package:vuelos_fl/src/services/user_service.dart';
import 'package:vuelos_fl/src/ui/box_decorations.dart';
import 'package:vuelos_fl/src/ui/input_decorations.dart';

import '../widgets/widgets.dart';

class LoginScreen extends StatelessWidget {
  static const routeName = "login-screen";

  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
        backgroundColor: Color.fromRGBO(238, 238, 238, 1),
        body: SafeArea(
          child: SingleChildScrollView(
              child: Center(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 30),
              child: _LoginContainer(),
            ),
          )),
        ));
  }
}

class _LoginContainer extends StatelessWidget {
  const _LoginContainer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      width: double.infinity,
      decoration: BoxDecorations.cardDecoration,
      child: Column(
        children: [
          Image.asset('assets/mi-logo.png'),
          const SizedBox(height: 24),
          ChangeNotifierProvider(
            create: (_) => LoginFormProvider(),
            child: const _LoginForm(),
          )
        ],
      ),
    );
  }
}

class _LoginForm extends StatelessWidget {
  const _LoginForm({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final loginForm = Provider.of<LoginFormProvider>(context);
    final userService = Provider.of<UserService>(context);

    return Form(
      key: loginForm.formKey,
      child: Column(children: [
        TextFormField(
          onChanged: (value) => loginForm.email = value,
          autocorrect: false,
          keyboardType: TextInputType.emailAddress,
          decoration: InputDecorations.authInputDecoration(
              hintText: 'monster@mail.com',
              labelText: 'Correo Electrónico',
              prefixIcon: Icons.email_outlined),
        ),
        const SizedBox(height: 30),
        TextFormField(
            onChanged: (value) => loginForm.password = value,
            obscureText: true,
            decoration: InputDecorations.authInputDecoration(
                hintText: '',
                labelText: 'Contraseña',
                prefixIcon: Icons.lock_outline)),
        const SizedBox(height: 30),
        FormButton(
          text: 'Iniciar Sesión',
          isLoading: userService.isLoading,
          onPressed: () async {
            FocusScope.of(context).unfocus();

            if (!loginForm.isValidForm()) {
              return;
            }

            final response = await userService.loginWithEmailAndPassword(
                loginForm.email, loginForm.password);

            if (response?.status == null || response?.status != 200) {
              NotificationsService.showSnackbar(response?.message ?? 'Error');
              return;
            }

            Navigator.pushReplacementNamed(context, HomeTabScreen.routeName);
          },
        )
      ]),
    );
  }
}
