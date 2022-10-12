import 'package:flutter/material.dart';
import 'package:sosty/ui/common/styles/styles.dart';
import 'package:sosty/ui/common/validations/form_validations.dart';
import 'package:sosty/ui/common/validations/validation_messages.dart';
import 'package:sosty/ui/components/buttons/large_button.dart';
import 'package:sosty/ui/components/buttons/small_button_navigation.dart';
import 'package:sosty/ui/components/fields/custom_password_form_field.dart';
import 'package:sosty/ui/components/fields/custom_text_form_field.dart';
import 'package:sosty/ui/components/forms/custom_form.dart';
import 'package:sosty/ui/components/general/section_with_bg_logo.dart';
import 'package:sosty/ui/screens/signup_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SectionWithBgLogo(
              title: "Bienvenido",
            ),
            CustomForm(
              formKey: _formKey,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: 40.0,
                  ),
                  child: Text(
                    "Por favor, entra con tu email y contraseña",
                    style: Styles.bodyText2Bold,
                  ),
                ),
                CustomTextFormField(
                  labelText: 'Email',
                  prefixIcon: const Icon(Icons.email),
                  inputType: TextInputType.emailAddress,
                  validator: (value) {
                    if (FormValidations.isEmpty(value!)) {
                      return ValidationMessages.emailRequired;
                    }
                    if (!FormValidations.isEmailValid(value)) {
                      return ValidationMessages.emailInvalid;
                    }
                    return null;
                  },
                ),
                const CustomPasswordFormField(
                  prefixIcon: Icon(Icons.lock_outline),
                  labelText: "Contraseña",
                ),
                const SizedBox(
                  height: 30,
                ),
                LargeButton(
                  text: "Login",
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Processing Data')),
                      );
                    }
                  },
                ),
                const SizedBox(
                  height: 50,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Nuevo en Sosty? ",
                      style: Styles.bodyText2Bold,
                    ),
                    const SmallButtonNavigation(
                      buttonText: "Crear una cuenta",
                      page: SignupScreen(),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 50,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
