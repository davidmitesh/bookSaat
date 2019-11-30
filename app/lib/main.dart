import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'home.dart';
import 'viewmodels/recommended.dart';
import 'models/loading.dart';

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Book App',
      debugShowCheckedModeBanner: false,
      theme: new ThemeData(
          primarySwatch: Colors.blue,
          platform: TargetPlatform.iOS,
          iconTheme: IconThemeData(color: Colors.black),
          appBarTheme: AppBarTheme(color: Colors.white),
          fontFamily: 'Sans'),
      home: ChangeNotifierProvider<RecommendedState>(
        create: (_) => RecommendedState(loadingState.IS_LOADING, null),
        child: Home(),
      ),
    );
  }
}
