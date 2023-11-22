import 'package:calculadora_mobile/calculdoraService.dart';
import 'package:calculadora_mobile/resultPage.dart';
import 'package:calculadora_mobile/loading.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late Future<List<Medicamento>> futureMedicamentos;
  late Future<List<Via>> futureVias;
  late Future<List<Acesso>> futureAcessos;
  late Future<List<Apresentacao>>? futureApresentacoes;

  final TextEditingController medicamentoController = TextEditingController();

  bool isLoading = false;

  Medicamento? selectedMedicamento;
  Apresentacao? selectedApresentacao;
  Via? selectedVia;
  Acesso? selectedAcesso;
  String dosePrescrita = "";

  @override
  void initState() {
    super.initState();
    futureMedicamentos = CalculadoraService().getMedicamentos();
    futureVias = CalculadoraService().getVias();
    futureAcessos = CalculadoraService().getAcessos();
    futureApresentacoes = CalculadoraService().getApresentacaos(0);
  }

  @override
  Widget build(BuildContext context) => isLoading
      ? const LoadingPage()
      : Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.blue[900],
          ),
          body: SingleChildScrollView(
            child: Center(
              child: Column(
                children: [
                  Image.asset(
                    'assets/images/unisc_logo.png',
                    height: 100,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  const Text("Calculdora de Medicamentos",
                      textAlign: TextAlign.center,
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
                  const SizedBox(
                    height: 10,
                  ),
                  FutureBuilder<List<Medicamento>>(
                      future: futureMedicamentos,
                      builder: ((context, AsyncSnapshot snapshot) {
                        if (snapshot.hasData) {
                          return DropdownMenu<Medicamento>(
                            width: 300,
                            enableFilter: true,
                            enableSearch: true,
                            controller: medicamentoController,
                            requestFocusOnTap: true,
                            label: const Text("Medicamento"),
                            onSelected: (Medicamento? newValue) async {
                              getApresentacoesSetValue(newValue);
                            },
                            dropdownMenuEntries: snapshot.data
                                .map<DropdownMenuEntry<Medicamento>>(
                                    (Medicamento medicamento) {
                              return DropdownMenuEntry<Medicamento>(
                                value: medicamento,
                                label: medicamento.nome,
                              );
                            }).toList(),
                          );
                        } else if (snapshot.hasError) {
                          return Text('ERROR: ${snapshot.error}');
                        }
                        return const CircularProgressIndicator();
                      })),
                  const SizedBox(
                    height: 10,
                  ),
                  FutureBuilder<List<Apresentacao>>(
                      future: futureApresentacoes,
                      builder: ((context, AsyncSnapshot snapshot) {
                        if (snapshot.hasData) {
                          return DropdownMenu<Apresentacao>(
                            width: 300,
                            label: snapshot.data.length == 0
                                ? const Text('Selecione um Medicamento')
                                : const Text('Apresentação'),
                            onSelected: (Apresentacao? newValue) {
                              setState(() {
                                selectedApresentacao = newValue;
                              });
                            },
                            dropdownMenuEntries: snapshot.data
                                .map<DropdownMenuEntry<Apresentacao>>(
                                    (Apresentacao apresentacao) {
                              return DropdownMenuEntry<Apresentacao>(
                                value: apresentacao,
                                label:
                                    "${apresentacao.marca} - ${apresentacao.laboratorio} - ${apresentacao.qtdApresentacao}",
                              );
                            }).toList(),
                          );
                        } else if (snapshot.hasError) {
                          return Text('ERROR: ${snapshot.error}');
                        }
                        return const CircularProgressIndicator();
                      })),
                  const SizedBox(
                    height: 10,
                  ),
                  FutureBuilder<List<Via>>(
                      future: futureVias,
                      builder: ((context, AsyncSnapshot snapshot) {
                        if (snapshot.hasData) {
                          return DropdownMenu<Via>(
                            width: 300,
                            label: const Text("Via de Administração"),
                            onSelected: (Via? newValue) {
                              setState(() {
                                selectedVia = newValue;
                              });
                            },
                            dropdownMenuEntries: snapshot.data
                                .map<DropdownMenuEntry<Via>>((Via via) {
                              return DropdownMenuEntry<Via>(
                                value: via,
                                label: via.nome,
                              );
                            }).toList(),
                          );
                        } else if (snapshot.hasError) {
                          return Text('ERROR: ${snapshot.error}');
                        }
                        return const CircularProgressIndicator();
                      })),
                  const SizedBox(
                    height: 10,
                  ),
                  FutureBuilder<List<Acesso>>(
                      future: futureAcessos,
                      builder: ((context, AsyncSnapshot snapshot) {
                        if (snapshot.hasData) {
                          return DropdownMenu<Acesso>(
                            width: 300,
                            label: const Text("Acesso"),
                            onSelected: (Acesso? newValue) {
                              setState(() {
                                selectedAcesso = newValue;
                              });
                            },
                            dropdownMenuEntries: snapshot.data
                                .map<DropdownMenuEntry<Acesso>>(
                                    (Acesso acesso) {
                              return DropdownMenuEntry<Acesso>(
                                value: acesso,
                                label: acesso.nome,
                              );
                            }).toList(),
                          );
                        } else if (snapshot.hasError) {
                          return Text('ERROR: ${snapshot.error}');
                        }
                        return const CircularProgressIndicator();
                      })),
                  const SizedBox(
                    height: 10,
                  ),
                  SizedBox(
                    width: 300,
                    child: TextField(
                      onChanged: (value) {
                        setState(() {
                          dosePrescrita = value;
                        });
                      },
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          hintText: 'Dose prescrita',
                          suffixText: '(mg ou UI)'),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  FilledButton(
                      style: TextButton.styleFrom(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 100, vertical: 20),
                      ),
                      onPressed: () =>
                          {calculate(context, selectedMedicamento!)},
                      child: const Text(
                        'Calcular',
                        style: TextStyle(fontSize: 16),
                      )),
                ],
              ),
            ),
          ),
        );

  getApresentacoesSetValue(newValue) async {
    CalculadoraService()
        .getApresentacaos(newValue?.id)
        .then((List<Apresentacao> apresentacoes) {
      setState(() {
        selectedMedicamento = newValue;
        futureApresentacoes = Future.value(apresentacoes);
      });
    }).catchError((error) {
      // Handle errors if necessary
      print('Error fetching apresentacoes: $error');
    });
  }

  calculate(context, Medicamento medicamento) async {
    setState(() {
      isLoading = true;
    });

    FormCalculo form = FormCalculo(
        idApresentacao: selectedApresentacao!.id,
        idVia: selectedVia!.id,
        idAcesso: selectedAcesso!.id,
        dose: dosePrescrita);

    Resultado resultado = await CalculadoraService().calcularDiluicao(form);

    setState(() {
      isLoading = false;
    });

    if (resultado.naoEncontrado) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Row(
              children: [
                Icon(Icons.warning,
                    color: Colors.orange), // Add your desired icon here
                SizedBox(width: 8.0), // Adjust spacing as needed
                Text('Atenção'),
              ],
            ),
            content: const Text(
                'Está diluição não está cadastrada no sistema! Entre em contato com o farmacêutico responsável.'),
            actions: [
              TextButton(
                onPressed: () {
                  // Close the alert dialog
                  Navigator.of(context).pop();
                },
                child: const Text('OK'),
              ),
            ],
          );
        },
      );
    } else {
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => ResultPage(resultado: resultado)));
    }
  }
}
