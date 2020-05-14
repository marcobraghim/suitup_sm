import 'package:flutter/material.dart';
import 'package:suitup_sm/src/suitup.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Suitup(
      controllers: [
        // Sim, aqui eh tipo Provider...
        CounterController(),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: MyHomePage(),
      ),
    );
  }
}

class CounterController extends SuitupController {
  int counter = 0;

  void incrementCounter() {
    counter++;

    update();
  }
}

class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("My Demo App"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'You have pushed the button this many times:',
            ),
            SuitupBuilder(
              builder: (BuildContext context, controller) {
                //
                // Se eu nao defino explicitamente o tipo do controller, tudo bem...
                //
                return Text(
                  '${controller.counter}',
                  style: Theme.of(context).textTheme.display1,
                );
              },
            ),
            //
            // Eu quero entender porque desse jeito ele nao consegue definir
            // o tipo do controller, sera isso um problema de versao? Segue
            // saida do '$ flutter --version':
            //
            // Flutter 1.12.13+hotfix.9 • channel stable • https://github.com/flutter/flutter.git
            // Framework • revision f139b11009 (6 weeks ago) • 2020-03-30 13:57:30 -0700
            // Engine • revision af51afceb8
            // Tools • Dart 2.7.2
            //
            // SuitupBuilder<CounterController>(
            //   builder: (BuildContext context, CounterController controller) {
            //     return Text(
            //       '${controller.counter}',
            //       style: Theme.of(context).textTheme.display1,
            //     );
            //   },
            // ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: Suitup.of<CounterController>(context).incrementCounter,
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ),
    );
  }
}
