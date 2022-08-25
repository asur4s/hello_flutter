import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final FocusNode _focusNode = FocusNode();
  String _message = "";

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  void _handleRawKeyEvent(RawKeyEvent event) {
    debugPrint(event.toString());
    debugPrint(event.character);
    debugPrint(event.data.toString());
    setState(() {
      _message =
          'KeyName: ${event.logicalKey.debugName}  KeyId: ${event.logicalKey.keyId}';
    });
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("RawKeyboardListener Sample"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            RawKeyboardListener(
                focusNode: _focusNode,
                onKey: _handleRawKeyEvent,
                child: AnimatedBuilder(
                  animation: _focusNode,
                  builder: (BuildContext context, Widget? child) {
                    if (!_focusNode.hasFocus) {
                      return GestureDetector(
                        onTap: () {
                          FocusScope.of(context).requestFocus(_focusNode);
                        },
                        child: const Text('Tap to focus'),
                      );
                    }
                    ;
                    return Text(_message);
                  },
                ))
          ],
        ),
      ),
    );
  }
}
