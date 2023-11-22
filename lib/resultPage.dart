import 'package:calculadora_mobile/calculdoraService.dart';
import 'package:flutter/material.dart';

class ResultPage extends StatelessWidget {
  final Resultado resultado;

  const ResultPage({Key? key, required this.resultado});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Resultado'),
        backgroundColor: Colors.blue,
      ),
      body: Center(
        child: Column(
          children: [
            const SizedBox(
              height: 30,
            ),
            Image.asset('assets/images/unisc_logo.png'),
            const SizedBox(
              height: 30,
            ),
            Text(resultado.naoEncontrado
                ? "Resultado não encontrado"
                : "Aspirar ${resultado.dose}ml")
          ],
        ),
      ),
    );
  }

  goBack(context) {
    Navigator.pop(context);
  }
}
