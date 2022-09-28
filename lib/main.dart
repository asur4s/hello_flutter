import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

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

  void _handleRawKeyEvent(RawKeyEvent e) {
    debugPrint(e.data.toString());
    int scanCode;
    int keyCode;
    bool down;

    if (e.data is RawKeyEventDataMacOs) {
      RawKeyEventDataMacOs newData = e.data as RawKeyEventDataMacOs;
      scanCode = newData.keyCode;
      keyCode = newData.keyCode;
    } else if (e.data is RawKeyEventDataWindows) {
      RawKeyEventDataWindows newData = e.data as RawKeyEventDataWindows;
      scanCode = newData.scanCode;
      keyCode = newData.keyCode;
    } else if (e.data is RawKeyEventDataLinux) {
      RawKeyEventDataLinux newData = e.data as RawKeyEventDataLinux;
      scanCode = newData.scanCode;
      keyCode = newData.keyCode;
    } else if (e.data is RawKeyEventDataAndroid){
      RawKeyEventDataAndroid newData = e.data as RawKeyEventDataAndroid;
      scanCode = newData.scanCode + 8;
      keyCode = newData.keyCode;
    }else {
      scanCode = -1;
      keyCode = -1;
    }

    debugPrint(scanCode.toString() + " " + keyCode.toString());
    setState(() {
      _message =
          'KeyName: ${e.logicalKey.debugName}  KeyId: ${e.logicalKey.keyId}';
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
