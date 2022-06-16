import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
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
    super.initState();
    dirFinder();
  }

  void dirFinder() async {
    doc = DocumentProvider();
    if (!kIsWeb) {
      if (defaultTargetPlatform == TargetPlatform.windows) {
        Directory appDocDir = await getApplicationDocumentsDirectory();
        String appDocPath = appDocDir.path + r'\FromDonutDev.js';
        if (File(appDocPath).exists() == true) {
          doc.openFile(appDocPath);
        } else {
          File(appDocPath);
          doc.openFile(appDocPath);
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => doc),
        Provider(create: (context) => Highlighter())
      ],
      child: InputListener(
        child: View(),
      ),
    );
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
        body: Editor(path: r'\FromDonutDev.js'),
      ),
    ),
  );
}
