import 'package:flutter/material.dart';

class WelcomeText extends StatelessWidget {
  const WelcomeText({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: const [
        Text('Descubre nuevos restaurantes', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25.0)),
        Text('Donde quiera que vayas', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25.0)),
        SizedBox(height: 15.0),
        Text('Explora los mejores restaurantes filtrados'),
        Text('buscando tu ciudad preferida')
      ],
    );
  }
}
