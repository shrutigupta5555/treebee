import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:treebee/screens/home.dart';
import 'package:treebee/screens/login.dart';
import 'package:treebee/screens/welcome.dart';

// import 'firebase_options.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const App());
}

class App extends StatefulWidget {
  const App({Key? key}) : super(key: key);

  @override
  _AppState createState() => _AppState();
}

class _AppState extends State<App> {
  @override
  Widget build(BuildContext context) {
    String appName = "Treebee";
    return MaterialApp(
      theme: ThemeData(textTheme: GoogleFonts.poppinsTextTheme()),
      title: appName,
      home: decide(),
      debugShowCheckedModeBanner: false,
    );
  }
}

decide() {
  if (FirebaseAuth.instance.currentUser != null) {
    return Home();
  } else {
    // return Login();
    return Welcome();
  }
}
