import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import './header/header.dart';
import './footer/footer.dart';
import './content/content.dart';
import './utils/state.dart';
import './utils/theme.consts.dart';

void main() {
  runApp(ExchangeApp());
}

class ExchangeApp extends StatefulWidget {
  const ExchangeApp({super.key});
  
  @override
  State<StatefulWidget> createState() => ExchangeAppState();

  static ExchangeAppState? of(BuildContext context) => context.findAncestorStateOfType<ExchangeAppState>();
}

class ExchangeAppState extends State<ExchangeApp> {
  ThemeMode themeMode = ThemeMode.light;

  void setTheme(bool isDark) {
    if (isDark) {
      setState(() => themeMode = ThemeMode.dark);
    } else {
      setState(() => themeMode = ThemeMode.light);
    }
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => ExchangeAppGlobalState(), 
      child:MaterialApp(
        title: 'Exchange App', 
        theme: ThemeData.light(useMaterial3: true).copyWith(
          badgeTheme: BadgeThemeData(backgroundColor: Colors.lightGreenAccent),
          scaffoldBackgroundColor: Color.fromARGB(255, 222, 227, 230),
          textTheme: GoogleFonts.outfitTextTheme(Theme.of(context).textTheme)
        ),
        darkTheme: ThemeData.dark(useMaterial3: true).copyWith(
          badgeTheme: BadgeThemeData(backgroundColor: Colors.deepPurple),
          scaffoldBackgroundColor: Color.fromARGB(255, 33, 43, 48),
          colorScheme: ColorScheme.dark().copyWith(surface: Colors.blueGrey) 
        ),
        themeMode: themeMode,
        home: AppRootContainer(),
      ),
    );
  }
}

class AppRootContainer extends StatefulWidget {
  const AppRootContainer({super.key});

  @override
  State<StatefulWidget> createState() => AppRootState();
}

class AppRootState extends State<AppRootContainer> {

  @override
  Widget build(BuildContext context) {
    //var globalState = context.watch<ExchangeAppGlobalState>();
    var colorsList = gradientColors[Theme.of(context).brightness] as List<Color>;

    var gradient = LinearGradient(
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
      colors: colorsList,
    );

    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Header(gradient: gradient),
            Content(),
          ]
        ),
      ),
      bottomNavigationBar: Footer(gradient: gradient),
    );
  }
}


