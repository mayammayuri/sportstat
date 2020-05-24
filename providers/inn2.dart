import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'contents.dart';
import 'package:http/http.dart' as http;
import '../screens/break.dart';
import 'Avatar.dart';
import 'inn1.dart';
import 'player_details.dart';
import '../screens/innings2.dart';
import '../screens/change_bowler.dart';
import '../screens/end_result.dart';

class Inn2 with ChangeNotifier {
  // String batteam;

  int target = 0;
  int wickets = 0;
  double ball_left = 0;
  int runs = 0;
  int undo_0 = 0;
  int balls = 0;
  String curr_over;
  double overs;
  int undo_r = 0;
  bool isWicket = false;
  int undo_s = 0;
  int undo_bow = 0;
  int undo_sb = 0;
  int undo_bowb = 0;
  double runrate = 0;
  int undobound = 0;
  int undosix = 0;
  String strike;
  List nextbat = [];
  List<double> runratelist = List<double>();
  List<double> curroverlist = List<double>();
  List<int> runslist = List<int>();
  bool win = false;
  bool lose = false;
  String non_strike;
  List batting_team;
  List bowling_team;
  List<Player> bat = [];
  List<Player> bowl = [];
  int index_strike, index_nonstrike, index_bowler = 0;
  String bowler;
  bool isb = false;
  bool iss = false;
  bool isExtra = false;
  bool isWide = false;
  void addrun(int ru) {
    undo_r = runs;
    target -= ru;
    print('undo runs:' + undo_r.toString());
    runs += ru;
    if (target <= runs) {
      win = true;
    }
    run_rate(runs,curr_over);
    notifyListeners();
  }

  void addstrikerun(int ru) {
    undo_s = bat[index_strike].runs;
    bat[index_strike].runs += ru;
    notifyListeners();
  }

  void addbowlerruns(int ru, bool isextra) {
    undo_bow = bowl[index_bowler].runs_given;
    bowl[index_bowler].runs_given += ru;
    isExtra = isextra;
    notifyListeners();
  }

  void run_rate(int runs,String curr_over){
    runrate=runs/double.parse(curr_over);
    runratelist.add(runrate);
    curroverlist.add(double.parse(curr_over));
    runslist.add(runs);
  }

  void add_balls(context) {
    undo_0 = balls;
    balls++;
    ball_left--;
    curr_over = (balls / 6).floor().toString() + '.' + (balls % 6).toString();
    run_rate(runs, curr_over);

    if (target > runs + 1 && double.parse(curr_over) == overs) {
      lose = true;
    }
    notifyListeners();
  }

  int findbatsmanByName(String name) {
    return bat.indexWhere((b) => b.name == name);
  }

  int findbowlerByName(String name) {
    return bowl.indexWhere((b) => b.name == name);
  }

  showAlertDialog(context) {
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

  void undoo(context) {
    if (runs == undo_r && balls == undo_0) {
      showAlertDialog(context);
    } else if (isWicket) {
      showAlertDialog(context);
    } else {
      target += runs - undo_r;
      runs = undo_r;
      balls = undo_0;
      ball_left++;

      //avatars.removeLast();

      bowl[index_bowler].runs_given = undo_bow;
      bat[index_strike].runs = undo_s;
      if (!isWide) bat[index_strike].balls_played--;
      if (!isExtra) {
        bowl[index_bowler].balls_thrown--;
      }

      if (isb) {
        bat[index_strike].bound--;
        isb = false;
      }

      if (iss) {
        bat[index_strike].six--;
        iss = false;
      }

      curr_over = (balls / 6).floor().toString() + '.' + (balls % 6).toString();
      run_rate(runs, curr_over);
    }
    // isWide = false;

    notifyListeners();
  }

  

  addBatting(Player player) {
    final newPlayer = Player(name: player.name, team: player.team);
    bat.add(newPlayer);
    notifyListeners();
  }

  addBowling(Player player) {
    final newPlayer = Player(name: player.name, team: player.team);
    bowl.add(newPlayer);
    notifyListeners();
  }

  undostrike() {
    if (isExtra ? (runs - 1 - undo_r).isOdd : (runs - undo_r).isOdd)
      change_strike();
  }

  void change_strike() {
    String a = strike;
    strike = non_strike;
    non_strike = a;
    int b = index_strike;
    index_strike = index_nonstrike;
    index_nonstrike = b;
    notifyListeners();
  }

  void out(BuildContext context, int type, int indexbat, int runs, String ball,
      String a, String b) {
    print(ball);
    nextbat.removeWhere((name) => name == bat[index_strike].name);
    nextbat.removeWhere((name) => name == bat[index_nonstrike].name);
    if (nextbat.length == 0) {
      Navigator.of(context).pushReplacementNamed(EndResult.routeName);
    } else {
      if (type == 1) {
        add_balls(context);
        bat[index_strike].balls_played++;
        bat[index_strike].how_out = 'Bowled-${bowl[index_bowler]}';
        bowl[index_bowler].wickets++;
        bowl[index_bowler].balls_thrown++;
        if (double.parse(curr_over) == overs) {
          Navigator.of(context).pushReplacementNamed(EndResult.routeName);
        } else
          showAlertDialogwicket(context, type);
      }
      if (type == 2) {
        add_balls(context);
        bat[index_strike].balls_played++;
        bat[index_strike].how_out = 'Caught-$a';
        bowl[index_bowler].wickets++;
        bowl[index_bowler].balls_thrown++;
        if (double.parse(curr_over) == overs) {
          Navigator.of(context).pushReplacementNamed(EndResult.routeName);
        } else
          showAlertDialogwicket(context, type);
      }
      if (type == 3 || type == 9) {
        bat[index_strike].runs += runs;
        bowl[index_bowler].runs_given += runs;
        this.runs += runs;
        if (ball == 'legal') {
          bat[index_strike].balls_played++;
          bowl[index_bowler].balls_thrown++;
          add_balls(context);
        }
        if (ball == 'No Ball') {
          bat[index_strike].balls_played++;
          this.runs++;
          bowl[index_bowler].runs_given++;
        }
        if (ball == 'Wide') {
          this.runs++;
          bowl[index_bowler].runs_given++;
        }
        if (ball == 'LB' || ball == 'Bye') {
          bat[index_strike].balls_played++;
          add_balls(context);
          bowl[index_bowler].balls_thrown++;
        }
        type == 3
            ? bat[indexbat].how_out =
                b != null ? 'Run Out:-$a,$b' : 'Run Out:-$a'
            : bat[indexbat].how_out = 'Obstrcted field';
        if (double.parse(curr_over) == overs) {
          Navigator.of(context).pushReplacementNamed(EndResult.routeName);
        } else
          showAlertDialogwicket(context, type);
      }

      if (type == 4) {
        bat[index_strike].balls_played++;
        add_balls(context);
        bat[index_strike].how_out = 'LBW-${bowl[index_bowler]}';
        bowl[index_bowler].wickets++;
        bowl[index_bowler].balls_thrown++;
        if (double.parse(curr_over) == overs) {
          Navigator.of(context).pushReplacementNamed(EndResult.routeName);
        } else
          showAlertDialogwicket(context, type);
      }
      if (type == 5) {
        if (ball == 'legal') {
          bat[index_strike].balls_played++;
          add_balls(context);
          bat[index_strike].how_out = 'Stumped-$a';
          bowl[index_bowler].wickets++;
          bowl[index_bowler].balls_thrown++;
        } else {
          this.runs++;
          bowl[index_bowler].wickets++;
          bowl[index_bowler].runs_given++;
        }
        if (double.parse(curr_over) == overs) {
          Navigator.of(context).pushReplacementNamed(EndResult.routeName);
        } else
          showAlertDialogwicket(context, type);
      }
      if (type == 6) {
        if (ball == 'Wide') {
          runs++;
          bowl[index_bowler].runs_given++;
        }
        if (ball == 'legal') {
          bat[index_strike].balls_played++;
          add_balls(context);
        }
        bat[index_strike].how_out = 'Hit wicket';
        bowl[index_bowler].wickets++;
        if (ball == 'legal') bowl[index_bowler].balls_thrown++;
        if (double.parse(curr_over) == overs) {
          Navigator.of(context).pushReplacementNamed(EndResult.routeName);
        } else
          showAlertDialogwicket(context, type);
      }
      if (type == 7) {
        bat[index_strike].balls_played++;
        add_balls(context);
        bat[index_strike].how_out = 'Hitted ball twice';
        bowl[index_bowler].wickets++;
        bowl[index_bowler].balls_thrown++;
        if (double.parse(curr_over) == overs) {
          Navigator.of(context).pushReplacementNamed(EndResult.routeName);
        } else
          showAlertDialogwicket(context, type);
      }
      if (type == 8) {
        bat[indexbat].how_out = 'Mankaded(Action-out)';
        showAlertDialogwicket(context, 8);
      }
      if (type == 10) {
        bat[indexbat].how_out = 'Retired';
        showAlertDialogwicket(context, 10);
      }
      if (type == 11) {
        wickets++;
        showAlertDialogwicket(context, 11);
      }
      wickets++;
      notifyListeners();
    }
  }

  showAlertDialogwicket(context, int type) {
    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
        content: Container(
      height: MediaQuery.of(context).size.height * 0.8,
      width: MediaQuery.of(context).size.width * 0.7,
      child: Column(
        children: <Widget>[
          Container(
            padding: EdgeInsets.all(20),
            child: Text(
              'Next Batsman',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemBuilder: (ctx, i) {
                return ListTile(
                  title: Text(nextbat[i]),
                  onTap: () {
                    index_strike = findbatsmanByName(nextbat[i]);

                    notifyListeners();
                    Navigator.of(context).pop();
                    print(balls % 6);
                    if (balls % 6 == 0) {
                      Navigator.of(context)
                          .pushReplacementNamed(ChangeBowler.routeName);
                    } else
                      Navigator.of(context)
                          .pushReplacementNamed(Innings2.routeName);
                  },
                );
              },
              itemCount: nextbat.length,
            ),
          )
        ],
      ),
    ));

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
}
