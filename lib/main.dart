import 'package:EnergyBunker/Constants/language_provider.dart';
import 'package:EnergyBunker/Screens/Service.dart';
import 'package:EnergyBunker/Screens/Splash.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'Screens/Home.dart';



void main() {
  runApp(ChangeNotifierProvider(
      create: (context) => LanguageProvider(),
      child:  MyApp(),
  ));
}

class MyApp extends StatelessWidget {


  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      supportedLocales: const [
        Locale('en'),
        Locale('es'),
        Locale('ca'),
      ],

      locale: context.watch<LanguageProvider>().selectedLocale,

      localizationsDelegates: [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate, // Provides localized strings and formatting for Material widgets
        GlobalCupertinoLocalizations.delegate, // Provides localized strings and formatting for Cupertino widgets
        GlobalWidgetsLocalizations.delegate,  // Provides localized text direction, etc., for widgets
      ],

      title: 'Energy Bunker',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // TRY THIS: Try running your application with "flutter run". You'll see
        // the application has a purple toolbar. Then, without quitting the app,
        // try changing the seedColor in the colorScheme below to Colors.green
        // and then invoke "hot reload" (save your changes or press the "hot
        // reload" button in a Flutter-supported IDE, or press "r" if you used
        // the command line to start the app).
        //
        // Notice that the counter didn't reset back to zero; the application
        // state is not lost during the reload. To reset the state, use hot
        // restart instead.
        //
        // This works for code too, not just values: Most code changes can be
        // tested with just a hot reload.
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: Splash(),
    );
  }
}

