import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:food_order_app/src/providers/auth.dart';
import 'package:food_order_app/src/screens/home.dart';
import 'package:food_order_app/src/screens/login.dart';
import 'package:food_order_app/src/widgets/loading.dart';
import 'package:provider/provider.dart';

void main() async {
  /*
  Flutter는 main 메소드를 앱의 시작점으로 사용합니다. main 메소드에서
  서버나 SharedPreferences 등 비동기로 데이터를 다룬 다음 runApp을
  실행해야하는 경우 아래 한줄을 반드시 추가해야합니다.
   */
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  // Provider를 인식 못하기 때문에 변경함.(firebase 관련된 건 다 안 됨.)
  // 앱 전역에서 사용할 Provider 목
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [ChangeNotifierProvider.value(value: AuthProvider.initialize())],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Food App',
        theme: ThemeData(
          primarySwatch: Colors.red,
        ),
        home: LoginScreen(),
      ),
    );
  }
}


class ScreensController extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final auth = Provider.of<AuthProvider>(context);
    switch (auth.status) {
      case Status.Uninitialized:
        return Loading();
      case Status.Unauthenticated:
      case Status.Authenticating:
        return LoginScreen();
      case Status.Authenticated:
        return Home();
      default: return LoginScreen();
    }
  }
}

