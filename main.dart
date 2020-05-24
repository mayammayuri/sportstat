import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:harsh/screens/details.dart';
import 'package:provider/provider.dart';
import './screens/login_screen.dart';
import './screens/registration_screen.dart';
import './screens/innings1.dart';
import './screens/innings2.dart';
import './screens/toss.dart';
import './providers/contents.dart';
import './screens/break.dart';
import './screens/teamA.dart';
import './screens/teamB.dart';
import './screens/bat_ball.dart';
import './providers/inn1.dart';
import './providers/inn2.dart';
import './screens/change_bowler.dart';
import './screens/end_result.dart';
import './screens/wickets.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          builder: (_) => Content(),
        ),
        ChangeNotifierProvider(
          builder: (_) => Inn1(),
        ),
        ChangeNotifierProvider(
          builder: (_) => Inn2(),
        ),

//        ChangeNotifierProvider(
//          builder: (_) => Inn1(
//              Provider.of<Content>(context).batteam,
//              Provider.of<Content>(context).namesA,
//              Provider.of<Content>(context).namesA),
//        ),
      ],
      child: MaterialApp(
        title: 'ScorePad',
        theme: ThemeData(primaryColor: Colors.blue),
        home: Toss(),
        routes: {
          RegistrationScreen.routeName: (ctx) => RegistrationScreen(),
          Toss.routeName: (ctx) => Toss(),
          Innings1.routeName: (ctx) => Innings1(),
          Innings2.routeName: (ctx) => Innings2(),
          Break.routeName: (ctx) => Break(),
          TeamA.routeName: (ctx) => TeamA(),
          TeamB.routeName: (ctx) => TeamB(),
          BatBall.routeName: (ctx) => BatBall(),
          Wickets.routeName: (ctx) => Wickets(),
          EndResult.routeName: (ctx) => EndResult(),
          ChangeBowler.routeName: (ctx) => ChangeBowler(),
          Details.routeName: (ctx) => Details(),
        },
      ),
    );
  }
}
