// import 'package:flutter/material.dart';
// import 'package:flutter_small_shop/screens/HomeScreen.dart';
//
//
// void main(){
//   runApp(MyApp());
// }
// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       debugShowCheckedModeBanner:false,
//       initialRoute:'/',
//       routes: {
//         '/':(context)=>HomeScreen(title: 'Home')
//       },
//     );
//   }
// }


import 'package:flutter/material.dart';
import 'package:flutter_small_shop/screens/HomePage.dart';
import 'package:flutter_small_shop/services/CartProvider.dart';
import 'package:provider/provider.dart';
import 'package:flutter_small_shop/screens/HomeScreen.dart';
import 'package:flutter_small_shop/services/auth.dart'; // Update with your correct path

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => Auth()),
        ChangeNotifierProvider(create: (context) => CartProvider()),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: {
        '/': (context) => HomePage(),
      },
    );
  }
}
