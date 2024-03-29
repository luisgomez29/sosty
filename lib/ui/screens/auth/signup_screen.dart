import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sosty/app/app_bottom_navigation_bar.dart';
import 'package:sosty/config/providers/user_provider.dart';
import 'package:sosty/domain/models/common/enums/user_role_enum.dart';
import 'package:sosty/domain/models/user/user.dart';
import 'package:sosty/infraestructure/helpers/api_client/exception/api_exception.dart';
import 'package:sosty/ui/common/styles/styles.dart';
import 'package:sosty/ui/common/validations/form_validations.dart';
import 'package:sosty/ui/common/validations/validation_messages.dart';
import 'package:sosty/ui/components/buttons/large_button.dart';
import 'package:sosty/ui/components/buttons/small_button.dart';
import 'package:sosty/ui/components/fields/checkbox_form_field.dart';
import 'package:sosty/ui/components/fields/custom_password_form_field.dart';
import 'package:sosty/ui/components/fields/custom_text_form_field.dart';
import 'package:sosty/ui/components/forms/custom_form.dart';
import 'package:sosty/ui/components/general/section_with_bg_logo.dart';
import 'package:sosty/ui/config/theme/app_theme.dart';
import 'package:sosty/ui/helpers/shared_preferences_helper.dart';
import 'package:sosty/ui/screens/auth/login_screen.dart';

class SignupScreen extends ConsumerStatefulWidget {
  const SignupScreen({
    Key? key,
  }) : super(key: key);

  @override
  ConsumerState createState() => _SignupScreenState();
}

class _SignupScreenState extends ConsumerState<SignupScreen> {
  bool _isLoading = false;
  final _formKey = GlobalKey<FormState>();
  final _emailCtrl = TextEditingController();
  final _passwordCtrl = TextEditingController();
  final _firstNameCtrl = TextEditingController();
  final _lastNameCtrl = TextEditingController();
  final _phoneNumberCtrl = TextEditingController();

  void _signup() async {
    if (_formKey.currentState!.validate()) {
      try {
        setState(() {
          _isLoading = true;
        });

        User user = await ref.watch(userProvider).signup(
              _emailCtrl.text,
              _passwordCtrl.text,
              UserRoleEnum.investor.value,
              _firstNameCtrl.text,
              _lastNameCtrl.text,
              _phoneNumberCtrl.text,
            );

        // Store user session data
        await SharedPreferencesHelper.saveUserSessionData(
          user.accessToken,
          user.userId,
          user.userType.value,
          user.balance ?? 0,
        );

        if (context.mounted) {
          Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(
                builder: (context) => const AppBottomNavigationBar(),
              ),
              (route) => false);
        }
      } on ApiException catch (e) {
        setState(() {
          _isLoading = false;
        });
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(e.getError().reason),
          ),
        );
      }
    }
  }

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    _emailCtrl.dispose();
    _passwordCtrl.dispose();
    _firstNameCtrl.dispose();
    _lastNameCtrl.dispose();
    _phoneNumberCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: AppTheme.getSystemUiOverlayStyle(),
      child: Scaffold(
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
                    controller: _emailCtrl,
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
                  CustomPasswordFormField(
                    prefixIcon: const Icon(Icons.lock_outline),
                    labelText: 'Contraseña',
                    controller: _passwordCtrl,
                  ),
                  CustomTextFormField(
                    labelText: 'Nombre(s)',
                    prefixIcon: const Icon(Icons.perm_identity_rounded),
                    controller: _firstNameCtrl,
                    inputType: TextInputType.name,
                    validator: (value) {
                      if (FormValidations.isEmpty(value!)) {
                        return ValidationMessages.firstNameRequired;
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
                    controller: _lastNameCtrl,
                    inputType: TextInputType.text,
                    validator: (value) {
                      if (FormValidations.isEmpty(value!)) {
                        return ValidationMessages.lastNameRequired;
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
                    controller: _phoneNumberCtrl,
                    inputType: TextInputType.phone,
                    validator: (value) {
                      if (FormValidations.isEmpty(value!)) {
                        return ValidationMessages.cellPhoneRequired;
                      }
                      if (!FormValidations.isCellPhoneValid(value)) {
                        return ValidationMessages.cellPhoneInvalid;
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
                    isLoading: _isLoading,
                    onPressed: _signup,
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
                      SmallButton(
                        buttonText: "Entra",
                        onPressed: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const LoginScreen(),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 40,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
