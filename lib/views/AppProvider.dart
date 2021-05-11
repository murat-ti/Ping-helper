import 'package:flutter/material.dart';
import 'package:ping_helper/bloc/url_future_provider.dart';
import 'package:provider/provider.dart';
import 'provider/home_provider.dart';

class AppProvider extends StatelessWidget {
  final UrlFutureProvider provider = UrlFutureProvider();

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(value: provider),
      ],
      child: MaterialApp(
        title: 'Ping Helper',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: HomeProvider(title: 'Websites availability checker'),
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}