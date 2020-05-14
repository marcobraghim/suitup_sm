import 'package:flutter/material.dart';

class Suitup extends InheritedWidget {
  final List<SuitupController> controllers;

  Suitup({Widget child, this.controllers})
      : assert(controllers != null),
        super(child: child);

  static T of<T extends SuitupController>(BuildContext context) {
    var suitup = context.dependOnInheritedWidgetOfExactType<Suitup>();

    return suitup.controllers.firstWhere((test) {
      return test is T;
    });
  }

  @override
  bool updateShouldNotify(Suitup oldWidget) {
    return controllers.length != oldWidget.controllers.length;
  }
}

abstract class SuitupController extends State {
  final List<State> _builderState = [];

  void addState(State state) {
    //
    // So adiciona o estado na lista se ele nunca foi adicionado antes
    bool contains = false;
    for (final item in _builderState) {
      if (identical(state, item)) {
        contains = true;
        break;
      }
    }

    if (!contains) {
      _builderState.add(state);
    }
  }

  // Remove o estado da lista em caso de dispose do builder
  void removeState(State state) {
    _builderState.removeWhere((test) => identical(state, test));
  }

  void update() {
    // Mostra a quantidade de estados adicionados a lista
    print("Qtd de estados na lista: ${_builderState.length}");

    _builderState.forEach((i) {
      if (i.mounted) {
        i.setState(() {});
      }
    });
  }

  @override
  Widget build(BuildContext context) => throw ("It shouldn't be happen...");
}

class SuitupBuilder<T extends SuitupController> extends StatefulWidget {
  final Widget Function(BuildContext, T) builder;

  SuitupBuilder({
    Key key,
    @required this.builder,
  })  : assert(builder != null),
        super(key: key);

  @override
  _SuitupBuilderState createState() => _SuitupBuilderState();
}

class _SuitupBuilderState<T extends SuitupController> extends State<SuitupBuilder<T>> {
  T controller;

  @override
  Widget build(BuildContext context) {
    controller = Suitup.of<T>(context);
    controller.addState(this);

    return widget.builder(context, controller);
  }

  @override
  void dispose() {
    controller.removeState(this);
    super.dispose();
  }
}
