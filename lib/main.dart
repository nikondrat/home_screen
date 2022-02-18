import 'package:flutter/material.dart';
import 'package:home_widget/home_widget.dart';

void main(List<String> args) {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

String path = '';

Future updateImage() async {
  await HomeWidget.saveWidgetData<String>("path", path);
  await HomeWidget.updateWidget(
      name: 'AppWidgetProvider', iOSName: 'AppWidgetProvider');
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
    updateImage();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Center(
          child: Text(path.toString()),
        ),
      ),
    );
  }
}
