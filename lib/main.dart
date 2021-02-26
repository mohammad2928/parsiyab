
import 'package:flutter/material.dart';
import 'package:parsiyab/pages/about.dart';
import 'package:parsiyab/pages/contact_us.dart';
import 'package:parsiyab/pages/daily_word.dart';
import 'package:parsiyab/pages/faverit.dart';
import 'package:parsiyab/pages/poyesh.dart';
import 'package:parsiyab/pages/search_page.dart';
import 'package:parsiyab/pages/splash_screen.dart';
import 'package:provider/provider.dart';
import 'package:parsiyab/pages/cart.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
        ChangeNotifierProvider(create: (_) => Cart()),
        
    ],
    child: Consumer<Cart>(
    builder: (context, cart, _) {

    return MaterialApp(
    title: 'Welcome to Flutter',
    theme: ThemeData(
    primarySwatch: Colors.blue,

    ),
    debugShowCheckedModeBanner: false,
    initialRoute: "/splash_screen",
    routes: {
    "/": (context) =>
    new Directionality(
    textDirection: TextDirection.rtl, child: SearchPage()),

    "/splash_screen" : (context) =>
    new Directionality(textDirection: TextDirection.rtl, child: SplshScreen()),

      "/about" : (context) =>
      new Directionality(textDirection: TextDirection.rtl, child: about()),

      "/faverit" : (context) =>
      new Directionality(textDirection: TextDirection.rtl, child: faverit()),

      "/poyesh" : (context) =>
      new Directionality(textDirection: TextDirection.rtl, child: poyesh()),

      "/daily_word" : (context) =>
      new Directionality(textDirection: TextDirection.rtl, child: dailyWord()),

      "/contact_us" : (context) =>
      new Directionality(textDirection: TextDirection.rtl, child: contactUs()),
    },






    );
    },
    )
    );
  }
}