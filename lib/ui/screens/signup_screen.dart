import 'package:flutter/material.dart';
import 'package:sosty/ui/common/styles/styles.dart';
import 'package:sosty/ui/common/validations/form_validations.dart';
import 'package:sosty/ui/common/validations/validation_messages.dart';
import 'package:sosty/ui/components/buttons/large_button.dart';
import 'package:sosty/ui/components/buttons/small_button_navigation.dart';
import 'package:sosty/ui/components/fields/custom_password_form_field.dart';
import 'package:sosty/ui/components/fields/custom_text_form_field.dart';
import 'package:sosty/ui/components/fields/checkbox_form_field.dart';
import 'package:sosty/ui/components/forms/custom_form.dart';
import 'package:sosty/ui/components/general/section_with_bg_logo.dart';
import 'package:sosty/ui/screens/login_screen.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({Key? key}) : super(key: key);

  @override
  _SignupScreenState createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
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
                    "Por favor, crea una cuenta con tu email y contraseña",
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
                  labelText: 'Contraseña',
                ),
                CustomTextFormField(
                  labelText: 'Nombre(s)',
                  prefixIcon: const Icon(Icons.perm_identity_rounded),
                  inputType: TextInputType.name,
                  validator: (value) {
                    if (FormValidations.isEmpty(value!)) {
                      return ValidationMessages.nameRequired;
                    }
                    if (!FormValidations.isMinLengthValid(value, 3)) {
                      return ValidationMessages.fieldMinLength(3);
                    }
                    if (!FormValidations.isMaxLengthValid(value, 30)) {
                      return ValidationMessages.fieldMaxLength(30);
                    }
                    return null;
                  },
                ),
                CustomTextFormField(
                  labelText: 'Apellido(s)',
                  prefixIcon: const Icon(Icons.perm_identity_rounded),
                  inputType: TextInputType.text,
                  validator: (value) {
                    if (FormValidations.isEmpty(value!)) {
                      return ValidationMessages.lastnameRequired;
                    }
                    if (!FormValidations.isMinLengthValid(value, 3)) {
                      return ValidationMessages.fieldMinLength(3);
                    }
                    if (!FormValidations.isMaxLengthValid(value, 30)) {
                      return ValidationMessages.fieldMaxLength(30);
                    }
                    return null;
                  },
                ),
                CustomTextFormField(
                  labelText: 'Celular',
                  prefixIcon: const Icon(Icons.call),
                  inputType: TextInputType.phone,
                  validator: (value) {
                    if (FormValidations.isEmpty(value!)) {
                      return ValidationMessages.cellphoneRequired;
                    }
                    if (!FormValidations.isCellPhoneValid(value)) {
                      return ValidationMessages.cellphoneInvalid;
                    }
                    return null;
                  },
                ),
                CheckboxFormField(
                  title: Text(
                    "Acepto Política de Privacidad y Términos y Condiciones",
                    style: Styles.bodyText2,
                  ),
                  validator: (bool? value) {
                    if (!value!) {
                      return ValidationMessages.termsAndConditionsRequired;
                    }
                    return null;
                  },
                  onSaved: (bool? newValue) {},
                ),
                const SizedBox(
                  height: 30,
                ),
                LargeButton(
                  text: "Registrarme",
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
                      "Ya tienes una cuenta? ",
                      style: Styles.bodyText2Bold,
                    ),
                    const SmallButtonNavigation(
                      buttonText: "Entra",
                      page: LoginScreen(),
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
