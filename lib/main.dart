import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';

import 'core/routes/routes.dart';
import 'core/theme/theme_colors.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'TRACTIAN',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: ThemeColors.primary),
        useMaterial3: true,
        textTheme: GoogleFonts.robotoTextTheme(),
        appBarTheme: AppBarTheme(
          backgroundColor: ThemeColors.appBarBackground,
          centerTitle: true,
          titleTextStyle: GoogleFonts.roboto(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.w400,
          ),
          foregroundColor: Colors.white,
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: ThemeColors.primary,
            foregroundColor: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(5),
            ),
          ),
        ),
        searchBarTheme: SearchBarThemeData(
          backgroundColor: WidgetStateColor.resolveWith(
            (_) => ThemeColors.seachBarBackground,
          ),
          elevation: WidgetStateProperty.resolveWith<double>((_) => 0),
          shape: WidgetStateProperty.resolveWith<RoundedRectangleBorder>(
            (_) => RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(4),
            ),
          ),
          padding: WidgetStateProperty.resolveWith<EdgeInsets>(
            (_) => const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
          ),
          constraints: const BoxConstraints.tightForFinite(),
          textStyle: WidgetStateProperty.resolveWith<TextStyle>(
            (_) => TextStyle(color: ThemeColors.searchBarContent),
          ),
        ),
        chipTheme: ChipThemeData(
          padding: const EdgeInsets.fromLTRB(16, 6, 14, 6),
          labelPadding: const EdgeInsets.only(left: 6),
          labelStyle: TextStyle(
            color: ThemeColors.filterContent,
            fontWeight: FontWeight.w500,
            fontSize: 14,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(3),
          ),
          side: WidgetStateBorderSide.resolveWith(
            (state) {
              if (EditableText.debugDeterministicCursor) {
                return null;
              }

              return BorderSide(
                color: ThemeColors.filterBorder,
                width: 1,
              );
            },
          ),
          showCheckmark: false,
          selectedColor: ThemeColors.primary,
        ),
        dividerTheme: DividerThemeData(
          color: ThemeColors.filterBorder,
          thickness: 1,
          space: 0,
        ),
        expansionTileTheme: ExpansionTileThemeData(
          childrenPadding: const EdgeInsets.only(left: 16),
          textColor: ThemeColors.appBarBackground,
          collapsedTextColor: ThemeColors.appBarBackground,
        ),
        listTileTheme: ListTileThemeData(
          dense: true,
          textColor: ThemeColors.appBarBackground,
        ),
      ),
      debugShowCheckedModeBanner: false,
      routes: routes,
      initialRoute: COMPANY,
    );
  }
}
