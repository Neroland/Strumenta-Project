import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'view.dart';
import 'input.dart';
import 'highlighter.dart';

class Editor extends StatefulWidget {
  Editor({Key? key, String this.path = ''}) : super(key: key);
  String path = '';
  @override
  _Editor createState() => _Editor();
}

class _Editor extends State<Editor> {
  late DocumentProvider doc;
  @override
  void initState() {
    doc = DocumentProvider();

    // if (defaultTargetPlatform == TargetPlatform.iOS ||
    //     defaultTargetPlatform == TargetPlatform.android) {
    //   // Some android/ios specific code
    // } else if (defaultTargetPlatform == TargetPlatform.linux ||
    //     defaultTargetPlatform == TargetPlatform.macOS ||
    //     defaultTargetPlatform == TargetPlatform.windows) {
    //   // Some desktop specific code there
    // } else {
    //   // Some web specific code there
    // }

    if (!kIsWeb) {
      print("Test");
      if (defaultTargetPlatform == TargetPlatform.windows) {
        if (File(widget.path).exists() == true) {
          doc.openFile(widget.path);
        } else {
          File(widget.path);
          doc.openFile(widget.path);
        }
      }
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(providers: [
      ChangeNotifierProvider(create: (context) => doc),
      Provider(create: (context) => Highlighter())
    ], child: InputListener(child: View()));
  }
}

void main() async {
  ThemeData themeData = ThemeData(
    fontFamily: 'FiraCode',
    primaryColor: foreground,
    backgroundColor: background,
    scaffoldBackgroundColor: background,
  );
  return runApp(
    MaterialApp(
      title: 'Strumenta Editor',
      debugShowCheckedModeBanner: false,
      theme: themeData,
      home: Scaffold(
        body: Editor(path: './tests/temp.js'),
      ),
    ),
  );
}
