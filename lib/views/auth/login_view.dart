import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';
import 'package:tyba_flutter_challenge/models/export_models.dart';
import 'package:tyba_flutter_challenge/providers/export_providers.dart';
import 'package:tyba_flutter_challenge/utils/export_utils.dart';
import 'package:tyba_flutter_challenge/views/export_views.dart';

class LoginView extends StatefulWidget {
  final VoidCallback goBack;
  const LoginView({required this.goBack, Key? key}) : super(key: key);

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {

  final _formKey = GlobalKey<FormState>();

  bool isHiddenPassword = false;

  void _togglePassword() {
    isHiddenPassword = !isHiddenPassword;
    setState(() {});
  }

  UserLoginDto _toSend = UserLoginDto("", "");

  void _saveForm() async {
    final isValid = _formKey.currentState!.validate();
    if(isValid){
      Provider.of<LoginProvider>(context, listen: false).setLoader(true);
      _formKey.currentState!.save();
      await Provider.of<LoginProvider>(context, listen: false).loginUser(_toSend).then((value){
        if(value != null) {
          Provider.of<LoginProvider>(context, listen: false).setLoader(false);
          Navigator.pushReplacement(
              context,
              PageTransition(
                  duration: const Duration(milliseconds: 200),
                  reverseDuration: const Duration(milliseconds: 200),
                  type: PageTransitionType.rightToLeft,
                  child: const LoggedInHomeView()
              )
          );
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {

    final parentSize = MediaQuery.of(context).size;

    return Form(
      key: _formKey,
      child: SizedBox(
        height: parentSize.height,
        width: parentSize.width,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Column(
                children: const [
                  Text('¡Hola otra vez!', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22.5)),
                  Text('¡Bienvenid@, ', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22.5)),
                  Text('te hemos extrañado!', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22.5))
                ],
              ),
              Column(
                children: [
                  SizedBox(
                    height: 75,
                    width: parentSize.width * 0.75,
                    child: TextFormField(
                      style: const TextStyle(
                          fontSize: 14,
                          height: 0.5
                      ),
                      decoration: const InputDecoration(
                        contentPadding: EdgeInsets.all(25.0),
                        isDense: true,
                        hintText: 'example@example.com',
                        labelText: 'Correo electrónico',
                        border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(15.0))),
                      ),
                      initialValue: 'ra.molerocaceda1901@gmail.com',
                      keyboardType: TextInputType.emailAddress,
                      textInputAction: TextInputAction.next,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Ingrese un correo";
                        }
                        if (!value.contains("@")) {
                          return "Ingrese un correo valido";
                        }
                      },
                      onSaved: (value) {
                        _toSend = UserLoginDto(value!, _toSend.password);
                      },
                    ),
                  ),
                  const SizedBox(height: 25.0),
                  SizedBox(
                    height: 75,
                    width: parentSize.width * 0.75,
                    child: TextFormField(
                      style: const TextStyle(
                          fontSize: 14,
                          height: 0.5
                      ),
                      decoration: InputDecoration(
                        contentPadding: const EdgeInsets.all(25.0),
                        isDense: true,
                        labelText: 'Contraseña',
                        border: const OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(15.0))),
                        suffixIcon: InkWell(
                          child: isHiddenPassword
                              ? const Icon(Icons.visibility)
                              : const Icon(Icons.visibility_off),
                          onTap: _togglePassword,
                        ),
                      ),
                      initialValue: '123456',
                      obscureText: !isHiddenPassword,
                      textInputAction: TextInputAction.done,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Ingrese una contraseña";
                        }
                      },
                      onSaved: (value) {
                        _toSend = UserLoginDto(_toSend.email, value!);
                      },
                    ),
                  ),
                ],
              ),
              ElevatedButton(
                onPressed: (){
                  _saveForm();
                },
                child: const Padding(
                    padding: EdgeInsets.all(12.0),
                    child: Text('Iniciar Sesión', style: TextStyle(fontSize: 20.0))
                ),
                style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),
                    primary: secondaryColor,
                    elevation: 0
                ),
              ),
              TextButton(
                onPressed: widget.goBack,
                child: const Text(
                  'Volver', style: TextStyle(
                    fontWeight: FontWeight.bold, fontSize: 20.0,
                    color: secondaryColor
                  )
                )
              )
            ],
          ),
        )
      ),
    );
  }
}
