import 'package:flutter/material.dart';

<<<<<<< Updated upstreamgit;
void main() {
  runApp(const MainApp());
=======
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    //options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MainApp()); 
>>>>>>> Stashed changesc
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @overrideyw
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: Scaffold(
        body: Center(
          child: Text('Hello World!'),
        ),
      ),
    );
  }
}
