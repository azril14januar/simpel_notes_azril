import 'package:flutter/material.dart';
import 'package:pertemuan_9/db/database_service.dart';
import 'package:pertemuan_9/models/note.dart';
import 'package:pertemuan_9/utils/app_routes.dart';
import 'package:hive_flutter/hive_flutter.dart';

void main() async {
  await Hive.initFlutter();
  Hive.registerAdapter(NoteAdapter());
  await Hive.openBox(DatabaseService.boxName);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Simple Notes',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      debugShowCheckedModeBanner: false,
      routeInformationParser: AppRoutes.goRouter.routeInformationParser,
      routeInformationProvider: AppRoutes.goRouter.routeInformationProvider,
      routerDelegate: AppRoutes.goRouter.routerDelegate,
    );
  }
}
