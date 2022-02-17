import 'package:flutter/material.dart';
import 'package:home_widget/home_widget.dart';

String path =
    "/storage/emulated/0/DCIM/Camera/images/${names[index]}"; // путь до папки с данными ОБЯЗАТЕЛЬНО!
int index = 0; // не удалять, если переименовывать, то везде
List names = [
  'cat.jpg',
  'cat2.jpg',
  'cert3d.png',
  'home.png',
]; // сюда добавлять все файлы из папки
//желательно сделать(навсякий) проверку изображение это или нет

void main() {
  // не убирать
  WidgetsFlutterBinding.ensureInitialized();
  HomeWidget.registerBackgroundCallback(backgroundCallback);
  //

  runApp(const MyApp());
}

// не удалять и не трогать кроме пути до папки
Future<void> backgroundCallback(Uri? uri) async {
  if (uri!.host == "updateimage") {
    await HomeWidget.getWidgetData<int>("index", defaultValue: 0).then((value) {
      index = value!;
      if (index < names.length) {
        index++;
      }
      if (index >= names.length) {
        index = 0;
      }
      path =
          "/storage/emulated/0/DCIM/Camera/images/${names[index]}"; // здесь тоже путь до папки ОБЯЗАТЕЛЬНО!
    });
    saveAppWidget();
    await HomeWidget.getWidgetData<String>("path", defaultValue: "")
        .then((value) {
      path = value!;
    });
  }
}

Future saveAppWidget() async {
  await HomeWidget.saveWidgetData<int>("index", index);
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
  // тоже не трогать
  void loadData() async {
    await HomeWidget.getWidgetData<int>("index", defaultValue: 0).then((value) {
      index = value!;
      if (index >= names.length) {
        index = 0;
      }
      path = "/storage/emulated/0/DCIM/Camera/images/${names[index]}";
    });
    saveAppWidget();
    await HomeWidget.getWidgetData<String>("path", defaultValue: "")
        .then((value) {
      path = value!;
    });
    setState(() {});
  }

  @override
  void initState() {
    HomeWidget.widgetClicked.listen((Uri? uri) => loadData());
    loadData();
    super.initState();
  }

  // само приложение
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: Scaffold(
          body: Center(child: Text(index.toString())),
        ));
  }
}
