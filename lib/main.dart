import 'package:financas/src/screens/splash_screen.dart';
import 'package:financas/src/tema.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences.getInstance().then((prefs) {
    var isDark = prefs.getBool("darkTheme") ?? false;
    return runApp(
      ChangeNotifierProvider<Tema>(
        child: MyApp(),
        create: (BuildContext context) {
          return Tema(isDark);
        },
      ),
    );
  });
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<Tema>(
      builder: (context, value, child) {
        return MaterialApp(
          title: 'Organizze',
          debugShowCheckedModeBanner: false,
          theme: value.getTheme(),
          home: SplashScreen(),
        );
      },
    );
  }
}
