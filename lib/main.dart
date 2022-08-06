import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:instagram_clone/screens/signup_screen.dart';
import 'package:instagram_clone/utils/colors.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  if (kIsWeb) {
    await Firebase.initializeApp(
        options: const FirebaseOptions(
            apiKey: 'AIzaSyDDEZCqsZqoPqE4MSd3sZyyMsAEKCEqqxI',
            appId: '1:408786466118:web:71ead955b3a232923e6147',
            messagingSenderId: '408786466118',
            projectId: 'instagram-clone-bf124',
            storageBucket: 'instagram-clone-bf124.appspot.com'));
  } else {
    Firebase.initializeApp();
  }
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Instagram Clone',
      theme: ThemeData.dark()
          .copyWith(scaffoldBackgroundColor: mobileBackgroundColor),
      // home: const ResponsiveLayout(
      //   webScreenSLayout: WebScreenLayout(),
      //   mobileScreenSLayout: MobileScreenLayout(),
      home: SignupScreen(),
    );
  }
}
