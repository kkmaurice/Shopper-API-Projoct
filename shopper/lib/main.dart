import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopper/helpers/route_helper.dart';
import 'package:shopper/providers/product_provider.dart';
import 'package:shopper/widgets/btm_nav_bar.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  @override
  void initState() {
    RouteHelper.setupRouter();
    super.initState(); 
  }
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => ProductProvider()),
      ],
      child: MaterialApp(
          title: 'Flutter Demo',
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            primarySwatch: Colors.blue,
          ),
          home: const BottomNavBar(),
          //initialRoute: RouteHelper.getBaseRoute(),
          onGenerateRoute: RouteHelper.router.generator,
          ),
    );
  }
}
