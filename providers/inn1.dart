import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:harsh/screens/innings1.dart';
import 'package:provider/provider.dart';
import 'contents.dart';
import 'package:http/http.dart' as http;
import '../screens/break.dart';
import 'Avatar.dart';
import 'player_details.dart';
import '../screens/change_bowler.dart';

List<Avatar> avatars = [];

class Inn1 with ChangeNotifier {
  bool isWicket = false;
  int runs = 0;
  int undo_0 = 0;
  int balls = 0;
  String curr_over;
  double curr_overs;
  double overs;
  bool allout = false;
  int wickets = 0;
  int undo_r = 0;
  int undo_s = 0;
  int undo_bow = 0;
  int undo_sb = 0;
  int undo_bowb = 0;
  int undobound = 0;
  int undosix = 0;
  double runrate = 0;
  int extrarun=0;
  String strike;
  List nextbat = [];
  String non_strike;
  List batting_team;
  List<double> runratelist = List<double>();
  List<double> curroverlist = List<double>();
  List<int> runslist = List<int>();
  List bowling_team;
  List<Player> bat = [];
  List<Player> bowl = [];
  List<String> batnext = [];
  int index_strike, index_nonstrike, index_bowler = 0;
  String bowler;
  bool isb = false;
  bool iss = false;
  bool isExtra = false;
  bool isWide = false;
  void addrun(int ru) {
    undo_r = runs;
    runs += ru;
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
    extraruns(isExtra);
    notifyListeners();
  }

  void extraruns(bool isExtra){
    if (isExtra == 1){
      extrarun=extrarun+1;
    }
  }

  void add_balls(context) {
    undo_0 = balls;
    balls++;
    curr_over = (balls / 6).floor().toString() + '.' + (balls % 6).toString();
    run_rate(runs,curr_over);

    notifyListeners();
  }

  void run_rate(int runs,String curr_over){
    runrate=runs/double.parse(curr_over);
    runratelist.add(runrate);
    curroverlist.add(double.parse(curr_over));
    runslist.add(runs);
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
      runs = undo_r;
      balls = undo_0;

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
    extraruns(isExtra);
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
    batnext.removeWhere((name) => name == bat[index_strike].name);
    batnext.removeWhere((name) => name == bat[index_nonstrike].name);
    if (batnext.length == 0) allout = true;
    if (allout) {
      Navigator.of(context).pushReplacementNamed(Break.routeName);
    } else {
      if (type == 1) {
        add_balls(context);
        bat[index_strike].balls_played++;
        bat[index_strike].how_out = 'Bowled-${bowl[index_bowler]}';
        bowl[index_bowler].wickets++;
        bowl[index_bowler].balls_thrown++;
        if (double.parse(curr_over) == overs) {

          Navigator.of(context).pushReplacementNamed(Break.routeName);
          
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
          Navigator.of(context).pushReplacementNamed(Break.routeName);
        } else
          showAlertDialogwicket(context, type);
      }
      if (type == 3 || type == 9) {
        bat[index_strike].runs += runs;
        bowl[index_bowler].runs_given += runs;
        this.runs += runs;}
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
          Navigator.of(context).pushReplacementNamed(Break.routeName);
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
          Navigator.of(context).pushReplacementNamed(Break.routeName);
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
          Navigator.of(context).pushReplacementNamed(Break.routeName);
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
          Navigator.of(context).pushReplacementNamed(Break.routeName);
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
          Navigator.of(context).pushReplacementNamed(Break.routeName);
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
        showAlertDialogwicket(context, 11);
      }
      wickets++;

      notifyListeners();
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
                  title: Text(batnext[i]),
                  onTap: () {
                    index_strike = findbatsmanByName(batnext[i]);

                    notifyListeners();
                    Navigator.of(context).pop();
                    print("rrrrrrrrrrrrrrrrrrrrr");
                    print(balls % 6);
                    if (balls % 6 == 0) {
                      Navigator.of(context)
                          .pushReplacementNamed(ChangeBowler.routeName);
                    } else
                      Navigator.of(context)
                          .pushReplacementNamed(Innings1.routeName);
                  },
                );
              },
              itemCount: batnext.length,
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
