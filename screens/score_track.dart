import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:harsh/screens/innings2.dart';
import 'package:harsh/screens/wickets.dart';
import 'package:provider/provider.dart';
import '../providers/contents.dart';
import 'break.dart';
import '../providers/Avatar.dart';
import '../providers/inn1.dart';
import '../providers/inn2.dart';
import 'change_bowler.dart';
import 'wickets.dart';
import 'end_result.dart';

class Scoretrack extends StatefulWidget {
//  const Scoretrack({
//    Key key,
//  }) : super(key: key);
  int inning;
  Scoretrack(int innings) {
    inning = innings;
  }

  @override
  _ScoretrackState createState() => _ScoretrackState();
}

class _ScoretrackState extends State<Scoretrack> {
  @override
  void initState() {
    super.initState();
  }

  bool byes = false;
  bool undo = true;
  int ball_check = 0;
  final alertcont = TextEditingController();
  final alertkey = GlobalKey();
  String alert_type;
  void _onsave() {
    FocusScope.of(context).unfocus();
  }

  @override
  Widget build(BuildContext context) {
    final prov = Provider.of<Content>(context);
    final prov2 = Provider.of<Inn1>(context);
    final prov3 = Provider.of<Inn2>(context);
    final bheight = MediaQuery.of(context).size.height * .065;
    return Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: <
        Widget>[
      Column(
        children: <Widget>[
          Row(
            children: <Widget>[
              Container(
                decoration: BoxDecoration(
                    color: Colors.grey,
                    border: Border.all(color: Colors.black, width: 0.5)),
                height: bheight,
                width: MediaQuery.of(context).size.width * .25,
                child: RaisedButton(
                  onPressed: () {
                    byes = false;

                    prov.avatars
                        .add(Avatar(col_ava: Colors.yellow[100], con: '0'));
                    prov.add_balls(context);
                    if (widget.inning == 1) {
                      prov2.isWicket = false;
                      prov2.add_balls(context);
                      prov2.bat[prov2.index_strike].balls_played++;
                      prov2.bowl[prov2.index_bowler].balls_thrown++;
                      prov2.addbowlerruns(0, false);
                      if (double.parse(prov2.curr_over) == prov2.overs) {
                        prov2.curr_over = '0.0';
                        Navigator.of(context)
                            .pushReplacementNamed(Break.routeName);
                      } else if (prov2.balls % 6 == 0) {
                        Navigator.of(context)
                            .pushReplacementNamed(ChangeBowler.routeName);
                      }
                    } else {
                      prov3.isWicket = false;
                      prov3.add_balls(context);
                      prov3.bat[prov3.index_strike].balls_played++;
                      prov3.bowl[prov3.index_bowler].balls_thrown++;
                      prov3.addbowlerruns(0, false);
                      if (double.parse(prov3.curr_over) == prov3.overs) {
                        prov3.curr_over = '0.0';
                        Navigator.of(context)
                            .pushReplacementNamed(EndResult.routeName);
                      } else if (prov3.balls % 6 == 0) {
                        Navigator.of(context)
                            .pushReplacementNamed(ChangeBowler.routeName);
                      }
                    }
                  },
                  child: Center(
                    child: Text(
                      '0',
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              ),
              Container(
                decoration: BoxDecoration(
                    color: Colors.grey,
                    border: Border.all(color: Colors.black, width: 0.5)),
                height: bheight,
                width: MediaQuery.of(context).size.width * .25,
                child: RaisedButton(
                  onPressed: () {
                    byes = false;
                    prov.add_balls(context);
                    prov.avatars.add(Avatar(col_ava: Colors.white, con: '1'));
                    prov.addrun(1);
                    if (widget.inning == 1) {
                      prov2.isWicket = false;
                      prov2.add_balls(context);
                      prov2.addrun(1);
                      prov2.addstrikerun(1);
                      prov2.iss = false;
                      prov2.isb = false;
                      prov2.addbowlerruns(1, false);
                      prov2.bat[prov2.index_strike].balls_played++;
                      prov2.bowl[prov2.index_bowler].balls_thrown++;
                      prov2.change_strike();
                      if (double.parse(prov2.curr_over) == prov2.overs) {
                        prov2.curr_over = '0.0';
                        Navigator.of(context)
                            .pushReplacementNamed(Break.routeName);
                      } else if (prov2.balls % 6 == 0) {
                        Navigator.of(context)
                            .pushReplacementNamed(ChangeBowler.routeName);
                      }
                    } else {
                      prov3.isWicket = false;

                      prov3.add_balls(context);
                      prov3.addrun(1);
                      prov3.addstrikerun(1);
                      prov3.iss = false;
                      prov3.isb = false;
                      prov3.addbowlerruns(1, false);
                      prov3.bat[prov3.index_strike].balls_played++;
                      prov3.bowl[prov3.index_bowler].balls_thrown++;
                      prov3.change_strike();
                      if (double.parse(prov3.curr_over) == prov3.overs ||
                          prov3.runs >= prov3.target) {
                        prov3.curr_over = '0.0';
                        Navigator.of(context)
                            .pushReplacementNamed(EndResult.routeName);
                      } else if (prov3.balls % 6 == 0) {
                        Navigator.of(context)
                            .pushReplacementNamed(ChangeBowler.routeName);
                      }
                    }
                  },
                  child: Center(
                    child: Text(
                      '1',
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              ),
              Container(
                decoration: BoxDecoration(
                    color: Colors.grey,
                    border: Border.all(color: Colors.black, width: 0.5)),
                height: bheight,
                width: MediaQuery.of(context).size.width * .25,
                child: RaisedButton(
                  onPressed: () {
                    byes = false;

                    prov.add_balls(context);
                    prov.avatars.add(Avatar(
                      col_ava: Colors.white,
                      con: '2',
                    ));
                    prov.addrun(2);
                    if (widget.inning == 1) {
                      prov2.isWicket = false;
                      prov2.add_balls(context);
                      prov2.addrun(2);
                      prov2.iss = false;
                      prov2.isb = false;
                      prov2.addstrikerun(2);
                      prov2.bat[prov2.index_strike].balls_played++;
                      prov2.bowl[prov2.index_bowler].balls_thrown++;
                      prov2.addbowlerruns(2, false);
                      if (double.parse(prov2.curr_over) == prov2.overs) {
                        prov2.curr_over = '0.0';
                        Navigator.of(context)
                            .pushReplacementNamed(Break.routeName);
                      } else if (prov2.balls % 6 == 0) {
                        Navigator.of(context)
                            .pushReplacementNamed(ChangeBowler.routeName);
                      }
                    } else {
                      prov3.isWicket = false;

                      prov3.add_balls(context);
                      prov3.addrun(2);
                      prov3.iss = false;
                      prov3.isb = false;
                      prov3.addstrikerun(2);
                      prov3.bat[prov3.index_strike].balls_played++;
                      prov3.bowl[prov3.index_bowler].balls_thrown++;
                      prov3.addbowlerruns(2, false);
                      if (double.parse(prov3.curr_over) == prov3.overs ||
                          prov3.runs >= prov3.target) {
                        prov3.curr_over = '0.0';
                        Navigator.of(context)
                            .pushReplacementNamed(EndResult.routeName);
                      } else if (prov3.balls % 6 == 0) {
                        Navigator.of(context)
                            .pushReplacementNamed(ChangeBowler.routeName);
                      }
                    }
                  },
                  child: Center(
                    child: Text(
                      '2',
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              ),
              Container(
                decoration: BoxDecoration(
                    color: Colors.redAccent,
                    border: Border.all(color: Colors.black, width: 0.5)),
                height: bheight,
                width: MediaQuery.of(context).size.width * .25,
                child: RaisedButton(
                  color: Colors.redAccent,
                  onPressed: () {
                    showAlertDialog2(context);
                  },
                  child: Center(
                    child: Text(
                      'OUT',
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              ),
            ],
          ),
          Row(
            children: <Widget>[
              Container(
                decoration: BoxDecoration(
                    color: Colors.grey,
                    border: Border.all(color: Colors.black, width: 0.5)),
                height: bheight,
                width: MediaQuery.of(context).size.width * .25,
                child: RaisedButton(
                  onPressed: () {
                    byes = false;
                    prov.add_balls(context);
                    prov.avatars.add(Avatar(col_ava: Colors.white, con: '3'));
                    prov.addrun(3);
                    if (widget.inning == 1) {
                      prov2.isWicket = false;

                      prov2.add_balls(context);
                      prov2.addrun(3);
                      prov2.addstrikerun(3);
                      prov2.iss = false;
                      prov2.isb = false;
                      prov2.addbowlerruns(3, false);
                      prov2.bat[prov2.index_strike].balls_played++;
                      prov2.bowl[prov2.index_bowler].balls_thrown++;
                      prov2.change_strike();
                      if (double.parse(prov2.curr_over) == prov2.overs) {
                        prov2.curr_over = '0.0';
                        Navigator.of(context)
                            .pushReplacementNamed(Break.routeName);
                      } else if (prov2.balls % 6 == 0) {
                        Navigator.of(context)
                            .pushReplacementNamed(ChangeBowler.routeName);
                      }
                    } else {
                      prov3.isWicket = false;

                      prov3.add_balls(context);
                      prov3.addrun(3);
                      prov3.addstrikerun(3);
                      prov3.iss = false;
                      prov3.isb = false;
                      prov3.addbowlerruns(3, false);
                      prov3.bat[prov3.index_strike].balls_played++;
                      prov3.bowl[prov3.index_bowler].balls_thrown++;
                      prov3.change_strike();
                      if (double.parse(prov3.curr_over) == prov3.overs ||
                          prov3.runs >= prov3.target) {
                        prov3.curr_over = '0.0';
                        Navigator.of(context)
                            .pushReplacementNamed(EndResult.routeName);
                      } else if (prov3.balls % 6 == 0) {
                        Navigator.of(context)
                            .pushReplacementNamed(ChangeBowler.routeName);
                      }
                    }
                  },
                  child: Center(
                    child: Text(
                      '3',
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              ),
              Container(
                decoration: BoxDecoration(
                    color: Colors.blue[600],
                    border: Border.all(color: Colors.black, width: 0.5)),
                height: bheight,
                width: MediaQuery.of(context).size.width * .25,
                child: RaisedButton(
                  color: Colors.pink[600],
                  onPressed: () {
                    byes = false;
                    prov.add_balls(context);
                    prov.avatars.add(Avatar(col_ava: Colors.orange, con: '4'));
                    prov.addrun(4);
                    if (widget.inning == 1) {
                      prov2.isWicket = false;

                      prov2.add_balls(context);
                      prov2.addrun(4);
                      prov2.addstrikerun(4);
                      prov2.bat[prov2.index_strike].bound += 1;
                      prov2.bat[prov2.index_strike].balls_played++;
                      prov2.bowl[prov2.index_bowler].balls_thrown++;
                      prov2.isb = true;
                      prov2.iss = false;
                      prov2.addbowlerruns(4, false);
                      if (double.parse(prov2.curr_over) == prov2.overs) {
                        prov2.curr_over = '0.0';
                        Navigator.of(context)
                            .pushReplacementNamed(Break.routeName);
                      } else if (prov2.balls % 6 == 0) {
                        Navigator.of(context)
                            .pushReplacementNamed(ChangeBowler.routeName);
                      }
                    } else {
                      prov3.isWicket = false;

                      prov3.add_balls(context);
                      prov3.addrun(4);
                      prov3.addstrikerun(4);
                      prov3.bat[prov3.index_strike].bound += 1;
                      prov3.bat[prov3.index_strike].balls_played++;
                      prov3.bowl[prov3.index_bowler].balls_thrown++;
                      prov3.isb = true;
                      prov3.iss = false;
                      prov3.addbowlerruns(4, false);
                      if (double.parse(prov3.curr_over) == prov3.overs ||
                          prov3.runs >= prov3.target) {
                        prov3.curr_over = '0.0';
                        Navigator.of(context)
                            .pushReplacementNamed(EndResult.routeName);
                      } else if (prov3.balls % 6 == 0) {
                        Navigator.of(context)
                            .pushReplacementNamed(ChangeBowler.routeName);
                      }
                    }
                  },
                  child: Center(
                    child: Text(
                      '4',
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              ),
              Container(
                decoration: BoxDecoration(
                    border: Border.all(color: Colors.black, width: 0.5)),
                height: bheight,
                width: MediaQuery.of(context).size.width * .25,
                child: RaisedButton(
                  color: Colors.purple.withOpacity(.8),
                  onPressed: () {
                    byes = false;
                    prov.add_balls(context);
                    prov.avatars
                        .add(Avatar(col_ava: Colors.blueAccent, con: '6'));
                    prov.addrun(6);
                    if (widget.inning == 1) {
                      prov2.isWicket = false;

                      prov2.add_balls(context);
                      prov2.addrun(6);
                      prov2.bat[prov2.index_strike].balls_played++;
                      prov2.bowl[prov2.index_bowler].balls_thrown++;
                      prov2.bat[prov2.index_strike].runs += 6;
                      prov2.bat[prov2.index_strike].six += 1;
                      prov2.iss = true;

                      prov2.isb = false;
                      prov2.addbowlerruns(6, false);
                      if (double.parse(prov2.curr_over) == prov2.overs) {
                        prov2.curr_over = '0.0';
                        Navigator.of(context)
                            .pushReplacementNamed(Break.routeName);
                      } else if (prov2.balls % 6 == 0) {
                        Navigator.of(context)
                            .pushReplacementNamed(ChangeBowler.routeName);
                      }
                    } else {
                      prov3.isWicket = false;

                      prov3.add_balls(context);
                      prov3.addrun(6);
                      prov3.bat[prov3.index_strike].balls_played++;
                      prov3.bowl[prov3.index_bowler].balls_thrown++;
                      prov3.bat[prov3.index_strike].runs += 6;
                      prov3.bat[prov3.index_strike].six += 1;
                      prov3.iss = true;

                      prov3.isb = false;
                      prov3.addbowlerruns(6, false);
                      if (double.parse(prov3.curr_over) == prov3.overs ||
                          prov3.runs >= prov3.target) {
                        prov3.curr_over = '0.0';
                        Navigator.of(context)
                            .pushReplacementNamed(EndResult.routeName);
                      } else if (prov3.balls % 6 == 0) {
                        Navigator.of(context)
                            .pushReplacementNamed(ChangeBowler.routeName);
                      }
                    }
                  },
                  child: Center(
                    child: Text(
                      '6',
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              ),
              Container(
                decoration: BoxDecoration(
                    color: Colors.grey,
                    border: Border.all(color: Colors.black, width: 0.5)),
                height: bheight,
                width: MediaQuery.of(context).size.width * .25,
                child: RaisedButton(
                  onPressed: () {
                    byes = false;
                    prov.add_balls(context);
                    if (widget.inning == 1) {
                      prov2.isWicket = false;

                      prov2.add_balls(context);
                      prov2.bat[prov2.index_strike].balls_played += 1;
                      prov2.bowl[prov2.index_bowler].balls_thrown += 1;
                      prov2.iss = false;
                      prov2.isb = false;
                    } else {
                      prov3.isWicket = false;

                      prov3.add_balls(context);
                      prov3.bat[prov3.index_strike].balls_played += 1;
                      prov3.bowl[prov3.index_bowler].balls_thrown += 1;
                      prov3.iss = false;
                      prov3.isb = false;
                    }
                    showAlertDialog(context, 'Scored by running', '0');
                  },
                  child: Row(
                    children: <Widget>[
                      Text(
                        '    5|7',
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          Row(
            children: <Widget>[
              Container(
                decoration: BoxDecoration(
                    color: Colors.grey,
                    border: Border.all(color: Colors.black, width: 0.5)),
                height: bheight,
                width: MediaQuery.of(context).size.width * .25,
                child: RaisedButton(
                  onPressed: () {
                    byes = false;
                    ball_check = 1;
                    if (widget.inning == 1) {
                      Provider.of<Inn1>(context).isWide = true;
                      prov2.isWicket = false;
                    } else {
                      prov3.isWicket = false;

                      Provider.of<Inn2>(context).isWide = true;
                    }
                    showAlertDialog(context, 'Wide Ball', '1');
                  },
                  child: Center(
                    child: Text(
                      'WD',
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              ),
              Container(
                decoration: BoxDecoration(
                    color: Colors.grey,
                    border: Border.all(color: Colors.black, width: 0.5)),
                height: bheight,
                width: MediaQuery.of(context).size.width * .25,
                child: RaisedButton(
                  onPressed: () {
                    byes = false;
                    ball_check = 1;
                    if (widget.inning == 1) {
                      prov2.bat[prov2.index_strike].balls_played++;
                      prov2.isWicket = false;
                    } else {
                      prov3.isWicket = false;
                      prov3.bat[prov3.index_strike].balls_played++;
                    }
                    showAlertDialog(context, 'No Ball', '1');
                  },
                  child: Center(
                    child: Text(
                      'NB',
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              ),
              Container(
                decoration: BoxDecoration(
                    color: Colors.grey,
                    border: Border.all(color: Colors.black, width: 0.5)),
                height: bheight,
                width: MediaQuery.of(context).size.width * .25,
                child: RaisedButton(
                  onPressed: () {
                    byes = true;
                    prov.add_balls(context);
                    if (widget.inning == 1) {
                      prov2.isWicket = false;
                      prov2.add_balls(context);
                      prov2.bat[prov2.index_strike].balls_played++;
                      prov2.bowl[prov2.index_bowler].balls_thrown++;
                    } else {
                      prov3.isWicket = false;

                      prov3.add_balls(context);
                      prov3.bat[prov3.index_strike].balls_played++;
                      prov3.bowl[prov3.index_bowler].balls_thrown++;
                    }
                    showAlertDialog(context, 'Bye', '-1');
                  },
                  child: Center(
                    child: Text(
                      'BYE',
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              ),
              Container(
                decoration: BoxDecoration(
                    color: Colors.grey,
                    border: Border.all(color: Colors.black, width: 0.5)),
                height: bheight,
                width: MediaQuery.of(context).size.width * .25,
                child: RaisedButton(
                  onPressed: () {
                    byes = true;
                    prov.add_balls(context);
                    if (widget.inning == 1) {
                      prov2.isWicket = false;
                      prov2.add_balls(context);
                      prov2.bat[prov2.index_strike].balls_played++;
                      prov2.bowl[prov2.index_bowler].balls_thrown++;
                    } else {
                      prov3.isWicket = false;

                      prov3.add_balls(context);
                      prov3.bat[prov3.index_strike].balls_played++;
                      prov3.bowl[prov3.index_bowler].balls_thrown++;
                    }
                    showAlertDialog(context, 'Leg Bye', '-2');
                  },
                  child: Center(
                    child: Text(
                      'LB',
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
      Container(
        padding: EdgeInsets.only(bottom: 10),
        height: 50,
        color: Colors.black87,
        child: FlatButton(
          onPressed: () {
            if (byes) {
              widget.inning == 1
                  ? prov2.change_strike()
                  : prov3.change_strike();
            }
            if (!prov2.isWicket && !prov3.isWicket) prov.undoo(context);

            if (widget.inning == 1) {
              if (!prov2.isWicket) prov2.undostrike();
            } else if (!prov3.isWicket) prov3.undostrike();
            widget.inning == 1 ? prov2.undoo(context) : prov3.undoo(context);
          },
          child: Text(
            'UNDO',
            style: TextStyle(color: Colors.white),
          ),
        ),
      ),
    ]);
  }

  showAlertDialog(BuildContext context, String title, String type) {
    // set up the buttons
    Widget cancelButton = Container(
        width: MediaQuery.of(context).size.width * 0.3,
        child: RaisedButton(
          color: Colors.red,
          child: Text("Cancel"),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ));
    Widget continueButton = Container(
      width: MediaQuery.of(context).size.width * 0.3,
      child: RaisedButton(
        color: Colors.blue,
        child: Text("OK"),
        onPressed: () {
          Provider.of<Content>(context).addrun(int.parse(type) > 0
              ? int.parse(type) + int.parse(alertcont.text)
              : 0 + int.parse(alertcont.text) + int.parse(alertcont.text));
          Provider.of<Content>(context).avatars.add(Avatar(
              col_ava: Colors.white,
              con: int.parse(type) > 0
                  ? title == 'No Ball'
                      ? 'NB ${alertcont.text}'
                      : 'WD ${alertcont.text}'
                  : int.parse(type) < 0
                      ? int.parse(type) == -1
                          ? '${alertcont.text} b'
                          : '${alertcont.text} lb'
                      : '${alertcont.text}'));

          if (widget.inning == 1) {
            if (int.parse(type) < 1) {
              Provider.of<Inn1>(context).addbowlerruns(
                  (int.parse(type) > 0
                      ? int.parse(type) + int.parse(alertcont.text)
                      : 0 + int.parse(alertcont.text)),
                  false);
            }
            if (int.parse(type) > 0) {
              if (title == 'Wide Ball') {
//                Provider.of<Inn1>(context)
//                    .bat[Provider.of<Inn1>(context).index_strike]
//                    .balls_played--;
              } else
                Provider.of<Inn1>(context).isWide = false;
              Provider.of<Inn1>(context).addbowlerruns(
                  int.parse(type) > 0
                      ? int.parse(type) + int.parse(alertcont.text)
                      : 0 + int.parse(alertcont.text),
                  true);
            }
            print(type);
            if (type != '-1' && type != '-2') {
              Provider.of<Inn1>(context)
                  .addstrikerun(int.parse(alertcont.text));
            }

            if (int.parse(alertcont.text).isOdd)
              Provider.of<Inn1>(context).change_strike();
            Provider.of<Inn1>(context).addrun(int.parse(type) > 0
                ? int.parse(type) + int.parse(alertcont.text)
                : 0 + int.parse(alertcont.text));
            Provider.of<Inn1>(context).isb = false;
            Provider.of<Inn1>(context).iss = false;
          } else if (widget.inning == 2) {
            if (int.parse(type) < 1) {
              Provider.of<Inn2>(context).addbowlerruns(
                  (int.parse(type) > 0
                      ? int.parse(type) + int.parse(alertcont.text)
                      : 0 + int.parse(alertcont.text)),
                  false);
            }
            if (int.parse(type) > 0) {
              if (title == 'Wide Ball') {
//                Provider.of<Inn1>(context)
//                    .bat[Provider.of<Inn1>(context).index_strike]
//                    .balls_played--;
              } else
                Provider.of<Inn2>(context).isWide = false;
              Provider.of<Inn2>(context).addbowlerruns(
                  int.parse(type) > 0
                      ? int.parse(type) + int.parse(alertcont.text)
                      : 0 + int.parse(alertcont.text),
                  true);
            }
            if (type != '-1' && type != '-2') {
              Provider.of<Inn2>(context)
                  .addstrikerun(int.parse(alertcont.text));
            }

            if (int.parse(alertcont.text).isOdd)
              Provider.of<Inn2>(context).change_strike();
            Provider.of<Inn2>(context).addrun(int.parse(type) > 0
                ? int.parse(type) + int.parse(alertcont.text)
                : 0 + int.parse(alertcont.text));
            Provider.of<Inn2>(context).isb = false;
            Provider.of<Inn2>(context).iss = false;
          }
          alertcont.clear();
          Navigator.of(context).pop();
          if (widget.inning == 1) {
            if (double.parse(Provider.of<Inn1>(context).curr_over) ==
                Provider.of<Inn1>(context).overs) {
              Provider.of<Inn1>(context).curr_over = '0.0';
              Navigator.of(context).pushReplacementNamed(Break.routeName);
            } else if (Provider.of<Inn1>(context).balls % 6 == 0) {
              Navigator.of(context)
                  .pushReplacementNamed(ChangeBowler.routeName);
            }
          } else {
            if (double.parse(Provider.of<Inn2>(context).curr_over) ==
                    Provider.of<Inn2>(context).overs ||
                Provider.of<Inn2>(context).runs >=
                    Provider.of<Inn2>(context).target) {
              Provider.of<Inn2>(context).curr_over = '0.0';
              Navigator.of(context).pushReplacementNamed(EndResult.routeName);
            } else if (Provider.of<Inn2>(context).balls % 6 == 0) {
              Navigator.of(context)
                  .pushReplacementNamed(ChangeBowler.routeName);
            }
          }
        },
      ),
    );
    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text(
        title,
        style: TextStyle(color: Colors.red),
      ),
      content: Row(
        children: <Widget>[
          Visibility(
            visible: int.parse(type) > 0,
            child: int.parse(type) > 0
                ? title == 'No Ball' ? Text('NB +') : Text('WD +')
                : SizedBox(
                    width: 1,
                  ),
          ),
          Container(
            padding: EdgeInsets.only(top: 5, left: 5),
            width: MediaQuery.of(context).size.width * 0.15,
            height: MediaQuery.of(context).size.height * 0.04,
            decoration:
                BoxDecoration(border: Border.all(color: Colors.grey, width: 1)),
            child: Form(
              child: TextFormField(
                keyboardType: TextInputType.number,
                // initialValue: '0',
                controller: alertcont,
                onChanged: (value) => value,
                autofocus: true,
                decoration: InputDecoration(hintText: '0'),
              ),
            ),
          ),
          SizedBox(
            width: 10,
          ),
          Text(' runs')
        ],
      ),
      actions: [cancelButton, continueButton],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  showAlertDialog2(BuildContext context) {
    // set up the button
    Widget okButton = FlatButton(
      child: Text("YES"),
      onPressed: () {
        Provider.of<Content>(context).start
            ? Provider.of<Inn1>(context).isWicket = true
            : Provider.of<Inn2>(context).isWicket = true;
        byes = false;
        Provider.of<Content>(context).a = 'Fielder1';
        Provider.of<Content>(context).b = 'Fielder2';
        Navigator.of(context).pop();
        Navigator.of(context).pushReplacementNamed(Wickets.routeName);
      },
    );
    Widget cancelButton = FlatButton(
      child: Text("NO"),
      onPressed: () {
        Navigator.of(context).pop();
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text(
        "Are you sure?",
        style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
      ),
      content: Text(
        'Please make sure to tap after the batsman left the field!Once done, can\'t be undone! ',
        style: TextStyle(color: Colors.grey),
      ),
      actions: [
        cancelButton,
        okButton,
      ],
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
