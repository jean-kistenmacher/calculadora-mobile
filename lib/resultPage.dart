import 'package:calculadora_mobile/calculdoraService.dart';
import 'package:flutter/material.dart';

class ResultPage extends StatelessWidget {
  final Resultado resultado;

  const ResultPage({Key? key, required this.resultado});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue[900],
        iconTheme: IconThemeData(
          color: Colors.white, // Change the back icon color here
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Padding(
              padding: EdgeInsets.all(20.0),
              child: Text("Resultado:",
                  style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold)),
            ),
            Padding(
              padding: const EdgeInsetsDirectional.fromSTEB(20.0, 0, 20.0, 0),
              child: Container(
                decoration: BoxDecoration(
                    color: Colors.blue.shade100,
                    border: Border.all(color: Colors.blue, width: 2)),
                width: double.infinity,
                padding: const EdgeInsets.all(20),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      decoration: BoxDecoration(
                          color: Colors.blue[700],
                          borderRadius:
                              const BorderRadius.all(Radius.circular(5))),
                      padding: const EdgeInsets.all(20),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            "Aspirar ${resultado.aspirar}ml de solução para atingir os ${resultado.dose}mg da dose prescrita",
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                          )
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      'Reconstituição:',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Text("${resultado.reconstituicao}"),
                    const SizedBox(
                      height: 15,
                    ),
                    Text(
                      'Diluição:',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Text("${resultado.diluicao}"),
                    const SizedBox(
                      height: 15,
                    ),
                    Text(
                      'Estbilidade:',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Text("${resultado.estabilidade}"),
                    const SizedBox(
                      height: 15,
                    ),
                    Text(
                      'Tempo de Administração:',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Text("${resultado.tempoAdm}"),
                    const SizedBox(
                      height: 15,
                    ),
                    Text(
                      'Observação:',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Text("${resultado.observacao}"),
                  ],
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(20.0),
              child: Center(
                child: FilledButton(
                    style: TextButton.styleFrom(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 100, vertical: 20),
                    ),
                    onPressed: () => {goBack(context)},
                    child: const Text(
                      'Voltar',
                      style: TextStyle(fontSize: 16),
                    )),
              ),
            ),
          ],
        ),
      ),
    );
  }

  goBack(context) {
    Navigator.pop(context);
  }
}
