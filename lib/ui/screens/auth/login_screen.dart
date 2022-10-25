import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sosty/app_bottom_navigation_bar.dart';
import 'package:sosty/config/provider/user_provider.dart';
import 'package:sosty/domain/models/user/user.dart';
import 'package:sosty/infraestructure/helpers/api_client/exception/api_exception.dart';
import 'package:sosty/ui/common/styles/styles.dart';
import 'package:sosty/ui/common/validations/form_validations.dart';
import 'package:sosty/ui/common/validations/validation_messages.dart';
import 'package:sosty/ui/components/buttons/large_button.dart';
import 'package:sosty/ui/components/buttons/small_button_navigation.dart';
import 'package:sosty/ui/components/fields/custom_password_form_field.dart';
import 'package:sosty/ui/components/fields/custom_text_form_field.dart';
import 'package:sosty/ui/components/forms/custom_form.dart';
import 'package:sosty/ui/components/general/footer.dart';
import 'package:sosty/ui/components/general/section_with_bg_logo.dart';
import 'package:sosty/ui/helpers/shared_preferences_helper.dart';
import 'package:sosty/ui/screens/auth/signup_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool _isLoading = false;
  final _formKey = GlobalKey<FormState>();
  final _emailCtrl = TextEditingController();
  final _passwordCtrl = TextEditingController();

  void _login() async {
    if (_formKey.currentState!.validate()) {
      try {
        setState(() {
          _isLoading = true;
        });

        final userProvider = Provider.of<UserProvider>(context, listen: false);
        User user = await userProvider.userUseCase.login(
          _emailCtrl.text,
          _passwordCtrl.text,
        );

        // Store user session data
        await SharedPreferencesHelper.saveUserSessionData(
          user.accessToken,
          user.userId,
          user.userType.value,
          user.balance ?? 0,
        );

        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(
              builder: (context) => const AppBottomNavigationBar(),
            ),
            (route) => false);
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
    super.dispose();
  }

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
                    "Por favor, entra con tu correo electrónico y contraseña",
                    style: Styles.bodyText2Bold,
                  ),
                ),
                CustomTextFormField(
                  labelText: 'Correo electrónico',
                  prefixIcon: const Icon(Icons.email),
                  inputType: TextInputType.emailAddress,
                  controller: _emailCtrl,
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
                  labelText: "Contraseña",
                  controller: _passwordCtrl,
                ),
                const SizedBox(
                  height: 30,
                ),
                LargeButton(
                  text: "Iniciar sesión",
                  isLoading: _isLoading,
                  onPressed: _login,
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
                const Footer(),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
