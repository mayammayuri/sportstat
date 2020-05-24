
import 'package:flutter/material.dart';
import 'package:harsh/providers/inn1.dart';
import 'package:provider/provider.dart';
import 'package:harsh/providers/inn2.dart';
import '../screens/innings1.dart';
import '../providers/inn2.dart';
import '../providers/inn1.dart';
import '../screens/innings2.dart';
import '../screens/break.dart';
import 'Avatar.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Content with ChangeNotifier {
  bool start = true;
  List<String> namesA = [];
  List<String> namesB = [];
  int in1tot = 0;
  int in2tot = 0;
  int undo_r = 0;
  int undo_0 = 0;
  int target = 0;
  int no_of_players = 0;
  double overs = 0;
  String tA;
  String tB;
  String capA;
  String capB;
  String bat_strike;
  double runrate = 0;
  List<double> runratelist = List<double>();
  String bat_non;
  List<int> score_update;
  int total = 0;
  int balls = 0;
  bool fin = false;
  String chosen_batsman = 'no';
  String a = 'Fielder1';
  String b = 'Fielder2';
  int wrun = 0;
  String wbt;
  final key = GlobalKey<FormState>();
  final cont = TextEditingController();
  String curr_over = '0.0';

  List<Avatar> avatars = [];

  void addrun(int runs) {
    undo_r = total;
    total += runs;
    target += runs;
    notifyListeners();
  }

 

  void add_balls(context) {
    undo_0 = balls;
    balls++;
    curr_over = (balls / 6).floor().toString() + '.' + (balls % 6).toString();
    if (double.parse(curr_over) == overs) {
      curr_over = '0.0';
      balls = 0;
      total = 0;
      batteam == 'A' ? 'B' : 'A';
      notifyListeners();
    }
    notifyListeners();
  }

  int i = 0;
  bool press = false;
  addA(String n) {
    i++;
    if (n != '') {
      namesA.add(n);
      notifyListeners();
    }

//    if (i >= no_of_players && press) {
//      final url = 'https://scorepad-6fe38.firebaseio.com/matchData/teamA.json';
//      final response = await http.post(url,
//          body: json.encode({'names': namesA, 'captain': capA}));
//      print(json.decode(response.body));
//      i = 0;
//      press = false;
//    }
  }

  String select;
  String batteam;
  void matchDat(String ta, String tb, double overs, int no, String toss_win,
      String batting_team) {
    select = batting_team;
    batteam = batting_team;
    tA = ta;
    tB = tb;
    no_of_players = no;
    this.overs = overs;
  }

  int j = 0;
  void addB(String n) {
    j++;
    if (n != '') {
      namesB.add(n);
      notifyListeners();
    }
  }

  void undoo(context) {
    if (total == undo_r && balls == undo_0) {
      showAlertDialog(context);
    } else {
      avatars.removeLast();
      total = undo_r;
      balls = undo_0;
      curr_over = (balls / 6).floor().toString() + '.' + (balls % 6).toString();
    }
    notifyListeners();
  }

  showAlertDialog(context) {
    // set up the buttons
    Widget continueButton = RaisedButton(
      color: Colors.blue,
      child: Text("OK"),
      onPressed: () {
        Navigator.of(context).pop();
      },
    );
    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text(
        'Can\'t UNDO further!',
      ),
      actions: [continueButton],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
}
