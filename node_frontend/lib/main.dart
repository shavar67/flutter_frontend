import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import 'providers/content_provider.dart';
import 'view/home.dart';

Future<void> main() async {
  Provider.debugCheckInvalidValueType = null;

  WidgetsFlutterBinding.ensureInitialized();

  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider<DataProvider>(create: (_) => DataProvider()),
    ],
    child: const MyApp(),
  ));
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final DataProvider _dataProvider = DataProvider();
  @override
  void initState() {
    super.initState();
  }

  @override
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<DataProvider>(
        create: (_) => _dataProvider,
        child: Consumer<DataProvider>(
            builder: (BuildContext context, value, Widget? child) {
          return MaterialApp(
              localizationsDelegates: const [],
              supportedLocales: const [
                Locale('en'),
                Locale('zh'),
              ],
              theme: ThemeData(
                  appBarTheme: const AppBarTheme(
                      elevation: 0, backgroundColor: Colors.white)),
              debugShowCheckedModeBanner: true,
              home: const HomePage());
        }));
  }
}
