import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopper/utils/dark_theme_styles.dart';
import 'package:shopper/helpers/route_helper.dart';
import 'package:shopper/providers/dark_theme_provider.dart';
import 'package:shopper/providers/product_provider.dart';
import 'package:shopper/widgets/btm_nav_bar.dart';

import 'providers/cart_provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  DarkThemeProvider themeChangeProvider = DarkThemeProvider();

  @override
  void initState() {
    RouteHelper.setupRouter();
    getCurrentAppTheme();
    super.initState();
  }

  void getCurrentAppTheme() async {
    themeChangeProvider.darkTheme =
        await themeChangeProvider.darkThemePreference.getTheme();
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => ProductProvider()),
        ChangeNotifierProvider(create: (context) => CartProvider()),
        ChangeNotifierProvider(create: (context) => themeChangeProvider),
      ],
      child: Consumer<DarkThemeProvider>(
        builder: (context, value, child) {
          return MaterialApp(
            title: 'Shopper',
            debugShowCheckedModeBanner: false,
            theme: Styles.themeData(themeChangeProvider.darkTheme, context),
            home: const BottomNavBar(),
            //initialRoute: RouteHelper.getBaseRoute(),
            onGenerateRoute: RouteHelper.router.generator,
          );
        },
      ),
    );
  }
}
