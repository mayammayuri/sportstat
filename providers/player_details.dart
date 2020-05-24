import 'package:flutter/material.dart';
import 'contents.dart';
import 'inn1.dart';
import 'inn2.dart';
import '../screens/end_result.dart';
import 'package:flutter/foundation.dart';

class Player with ChangeNotifier {
  final String name;
  final String team;

  int runs = 0;
  double strike_rate;
  int balls_played = 0;
  int bound = 0;
  int six = 0;
  String how_out = '';
  double overs = 0.0;
  int balls_thrown = 0;
  int runs_given = 0;
  int maiden = 0;
  int wickets = 0;
  int economy = 0;
  Player({@required this.name, @required this.team});
}
