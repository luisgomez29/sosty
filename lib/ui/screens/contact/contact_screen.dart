import 'package:flutter/material.dart';
import 'package:sosty/ui/common/constants/constants.dart';
import 'package:sosty/ui/common/styles/styles.dart';
import 'package:sosty/ui/common/validations/form_validations.dart';
import 'package:sosty/ui/common/validations/validation_messages.dart';
import 'package:sosty/ui/components/buttons/large_button.dart';
import 'package:sosty/ui/components/fields/custom_text_form_field.dart';
import 'package:sosty/ui/components/fields/select_text_form_field.dart';
import 'package:sosty/ui/components/forms/custom_form.dart';
import 'package:sosty/ui/components/general/content_section.dart';
import 'package:sosty/ui/components/general/section_title.dart';
import 'package:sosty/ui/components/navbar/navbar_clipper.dart';
import 'package:sosty/ui/components/navbar/navbar_detail.dart';

class ContactScreen extends StatefulWidget {
  const ContactScreen({Key? key}) : super(key: key);

  @override
  _ContactScreenState createState() => _ContactScreenState();
}

class _ContactScreenState extends State<ContactScreen> {
  bool _isLoading = false;
  final _formKey = GlobalKey<FormState>();
  final _emailCtrl = TextEditingController();
  final _nameCtrl = TextEditingController();
  final _phoneNumberCtrl = TextEditingController();
  final _cityCtrl = TextEditingController();
  final _messageCtrl = TextEditingController();

  void _sendInfo() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _isLoading = true;
      });
    }
  }

  @override
  void dispose() {
    _emailCtrl.dispose();
    _nameCtrl.dispose();
    _phoneNumberCtrl.dispose();
    _cityCtrl.dispose();
    _messageCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    const double _sizedBoxValue = 30.0;
    return Scaffold(
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            const NavbarDetail(),
            SliverToBoxAdapter(
              child: Column(
                children: [
                  const NavbarClipper(),
                  ContentSection(
                    offsetY: -90.0,
                    child: Column(
                      children: [
                        const SizedBox(
                          height: _sizedBoxValue,
                        ),
                        const SectionTitle(
                          title: "Requiero información",
                        ),
                        const SizedBox(
                          height: _sizedBoxValue,
                        ),
                        CustomForm(
                          formKey: _formKey,
                          padding: const EdgeInsets.all(0.0),
                          children: [
                            Text(
                              "Gracias por tu interés en Sosty y en la ganadería regenerativa, nos contactaremos contigo los más pronto posible.",
                              style: Styles.bodyText2Bold,
                            ),
                            const SizedBox(
                              height: 30,
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
                            CustomTextFormField(
                              labelText: 'Nombre',
                              prefixIcon:
                                  const Icon(Icons.perm_identity_rounded),
                              controller: _nameCtrl,
                              inputType: TextInputType.name,
                              validator: (value) {
                                if (FormValidations.isEmpty(value!)) {
                                  return ValidationMessages.firstNameRequired;
                                }
                                if (!FormValidations.isMinLengthValid(
                                    value, 3)) {
                                  return ValidationMessages.fieldMinLength(3);
                                }
                                if (!FormValidations.isMaxLengthValid(
                                    value, 30)) {
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
                            CustomTextFormField(
                              labelText: 'Ciudad',
                              prefixIcon: const Icon(Icons.location_city),
                              controller: _cityCtrl,
                              inputType: TextInputType.text,
                              validator: (value) {
                                if (FormValidations.isEmpty(value!)) {
                                  return ValidationMessages.cityRequired;
                                }
                                if (!FormValidations.isMinLengthValid(
                                    value, 3)) {
                                  return ValidationMessages.fieldMinLength(3);
                                }
                                if (!FormValidations.isMaxLengthValid(
                                    value, 30)) {
                                  return ValidationMessages.fieldMaxLength(30);
                                }
                                return null;
                              },
                            ),
                            const SelectTextFormField(
                              options: Constants.foundUsOptions,
                            ),
                            CustomTextFormField(
                              labelText: 'Mensaje',
                              prefixIcon: const Icon(Icons.location_city),
                              controller: _messageCtrl,
                              inputType: TextInputType.text,
                              maxLines: 5,
                              validator: (value) {
                                if (FormValidations.isEmpty(value!)) {
                                  return ValidationMessages.messageRequired;
                                }
                                if (!FormValidations.isMinLengthValid(
                                    value, 3)) {
                                  return ValidationMessages.fieldMinLength(3);
                                }
                                return null;
                              },
                            ),
                            const SizedBox(
                              height: _sizedBoxValue,
                            ),
                            LargeButton(
                              text: "Enviar",
                              isLoading: _isLoading,
                              onPressed: _sendInfo,
                            ),
                            const SizedBox(
                              height: _sizedBoxValue * 2,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}