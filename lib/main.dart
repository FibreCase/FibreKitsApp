import 'package:fibre_kits/pages/main_struct.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:dynamic_color/dynamic_color.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  static final _defaultLightColorScheme = ColorScheme.fromSeed(
    seedColor: Colors.cyan,
  );
  static final _defaultDarkColorScheme = ColorScheme.fromSeed(
    seedColor: Colors.cyan,
    brightness: Brightness.dark,
  );

  @override
  Widget build(BuildContext context) {
    return DynamicColorBuilder(
      builder: (ColorScheme? lightDynamic, ColorScheme? darkDynamic) {
        return GetMaterialApp(
          title: 'FibreKits',
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            colorScheme: lightDynamic ?? _defaultLightColorScheme,
            useMaterial3: true,
            textTheme: GoogleFonts.notoSansTextTheme(
              ThemeData(
                colorScheme: lightDynamic,
                useMaterial3: true,
              ).textTheme,
            ),
          ),
          darkTheme: ThemeData(
            colorScheme: darkDynamic ?? _defaultDarkColorScheme,
            useMaterial3: true,
            textTheme: GoogleFonts.notoSansTextTheme(
              ThemeData(colorScheme: darkDynamic, useMaterial3: true).textTheme,
            ),
          ),
          home: const MainStruct(),
        );
      },
    );
  }
}
