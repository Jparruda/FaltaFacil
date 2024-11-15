import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Ausente+',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // TRY THIS: Try running your application with "flutter run". You'll see
        // the application has a purple toolbar. Then, without quitting the app,
        // try changing the seedColor in the colorScheme below to Colors.green
        // and then invoke "hot reload" (save your changes or press the "hot
        // reload" button in a Flutter-supported IDE, or press "r" if you used
        // the command line to start the app).
        //
        // Notice that the counter didn't reset back to zero; the application
        // state is not lost during the reload. To reset the state, use hot
        // restart instead.
        //
        // This works for code too, not just values: Most code changes can be
        // tested with just a hot reload.
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blueGrey),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Falta Fácil'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;
  List<Map<String, dynamic>> turmas = [];

  void _incrementCounter() {
    setState(() {
      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values. If we changed
      // _counter without calling setState(), then the build method would not be
      // called again, and so nothing would appear to happen.
      _counter++;
    });
  }
  void _addTurmas(String nome, int horas, int freq){
    double presencaNecessaria = (freq/100) * horas;
    double faltasPossiveis = horas - presencaNecessaria;
    setState(() {
      turmas.add({
        'Nome': nome,
        'Carga Horária': horas,
        'Frequência': freq,
        'Pode Faltar': faltasPossiveis,
        'Comparecer': presencaNecessaria,
      });
    });
  }
  Color corTema = Color(0xFFDEEE0B);
  Color corFundo = Color(0xFF141617);

  // Função para exibir o diálogo
  void _mostrarDialogAdicionarTurma() {
    // Controladores de texto para capturar os dados
    TextEditingController nomeController = TextEditingController();
    TextEditingController horasController = TextEditingController();
    TextEditingController freqController = TextEditingController();

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Color(0xFFEDF3AD),
          title: const Text('Adicionar Turma'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: nomeController,
                decoration: const InputDecoration(
                  labelText: 'Nome da Turma',
                ),
              ),
              TextField(
                controller: horasController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  labelText: 'Quantidade de Horas',
                ),
              ),
              TextField(
                controller: freqController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  labelText: 'Frequência (%)',
                ),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Fecha o diálogo
              },
              child: const Text('Cancelar'),
            ),
            TextButton(
              onPressed: () {
                // Capturar os dados e chamar _addTurmas
                String nome = nomeController.text;
                int horas = int.tryParse(horasController.text) ?? 0;
                int freq = int.tryParse(freqController.text) ?? 0;

                if (nome.isNotEmpty && horas > 0 && freq > 0) {
                  _addTurmas(nome, horas, freq);
                  Navigator.of(context).pop(); // Fecha o diálogo
                } else {
                  // Você pode mostrar um erro se os dados forem inválidos
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Preencha todos os campos corretamente!')),
                  );
                }
              },
              child: const Text('Adicionar'),
            ),
          ],
        );
      },
    );
  }


  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      backgroundColor: corFundo,
      appBar: AppBar(
        // TRY THIS: Try changing the color here to a specific color (to
        // Colors.amber, perhaps?) and trigger a hot reload to see the AppBar
        // change color while the other colors stay the same.
        backgroundColor:  Colors.transparent,
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title,
          style: GoogleFonts.fugazOne(
              textStyle: TextStyle(
                fontSize: 30,
                color: corTema,

              )),),
        centerTitle: true,
      ),
       // body:,

      // Padding(padding: const EdgeInsets.all(8.0),
      // child: turmas.isEmpty
      //   ? const Center(
      //   child: Text('Nenhuma turma adicionada. Pressione "+" para começar!'),
      // )
      //    : ListView.builder(itemBuilder: itemBuilder)
      // ),
      floatingActionButton: FloatingActionButton(
        hoverColor: Color(0xFFFAF3C0),
        backgroundColor: corTema,
        onPressed: _mostrarDialogAdicionarTurma, // Exibe o diálogo ao pressionar o botão
        tooltip: 'Adicione uma turma',
        child: const Icon(Icons.add, color: Colors.black,),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
