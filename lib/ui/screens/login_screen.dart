import 'package:flutter/material.dart';
import 'package:sosty/ui/components/buttons/large_button.dart';
import 'package:sosty/ui/common/styles/styles.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Column(
              children: [
                const Image(
                  image: AssetImage("assets/images/logo_with_decoration.jpg"),
                  fit: BoxFit.cover,
                ),
                Transform.translate(
                  offset: const Offset(0.0, -25.0),
                  child: Text(
                    "Bienvenido",
                    style: headline1,
                    textAlign: TextAlign.left,
                  ),
                ),
              ],
            ),
            Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30),
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          vertical: 40.0,
                        ),
                        child: Text(
                          "Por favor, entra con tu email y contraseña",
                          style: bodyText2Bold,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 5),
                        child: TextFormField(
                          decoration: const InputDecoration(
                            prefixIcon: Icon(Icons.email),
                            labelText: 'Email',
                            border: OutlineInputBorder(),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 5),
                        child: TextFormField(
                          obscureText: true,
                          decoration: const InputDecoration(
                            prefixIcon: Icon(Icons.lock_outline),
                            labelText: 'Contraseña',
                            border: OutlineInputBorder(),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      LargeButton(
                        text: "Login",
                        onPressed: () {},
                      ),
                      const SizedBox(
                        height: 50,
                      ),
                      Text(
                        "Nuevo en Sosty? Crear una cuenta",
                        style: bodyText2Bold,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
