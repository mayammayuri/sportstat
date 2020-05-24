import 'package:flutter/material.dart';
import 'package:harsh/screens/innings1.dart';
import 'package:provider/provider.dart';
import '../providers/contents.dart';
import '../providers/inn1.dart';
import '../providers/inn2.dart';
import 'innings2.dart';

class BatBall extends StatefulWidget {
  static const routeName = '/batball';
  @override
  _BatBallState createState() => _BatBallState();
}

class _BatBallState extends State<BatBall> {
  String a, b, c;
  showAlertDialog(BuildContext context, int select) {
    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      content: Container(
        height: MediaQuery.of(context).size.height * 0.8,
        width: MediaQuery.of(context).size.width * 0.7,
        child: ListView.builder(
          itemBuilder: (_, i) {
            return Column(
              children: <Widget>[
                ListTile(
                  title: Text(
                    select == 1 || select == 2
                        ? Provider.of<Content>(context).start
                            ? Provider.of<Inn1>(context).batting_team[i]
                            : Provider.of<Inn2>(context).batting_team[i]
                        : Provider.of<Content>(context).start
                            ? Provider.of<Inn1>(context).bowling_team[i]
                            : Provider.of<Inn2>(context).bowling_team[i],
                    style: TextStyle(
                      fontFamily: 'NimbusRomNo9L',
                      fontWeight: FontWeight.w500,
                      //fontSize: 25,
                    ),
                  ),
                  onTap: () {
                    select == 1
                        ? Provider.of<Content>(context).start
                            ? setState(() {
                                a = Provider.of<Inn1>(context).batting_team[i];
                              })
                            : setState(() {
                                a = Provider.of<Inn2>(context).batting_team[i];
                              })
                        : select == 2
                            ? Provider.of<Content>(context).start
                                ? setState(() {
                                    b = Provider.of<Inn1>(context)
                                        .batting_team[i];
                                  })
                                : setState(() {
                                    b = Provider.of<Inn2>(context)
                                        .batting_team[i];
                                  })
                            : Provider.of<Content>(context).start
                                ? setState(() {
                                    c = Provider.of<Inn1>(context)
                                        .bowling_team[i];
                                  })
                                : setState(() {
                                    c = Provider.of<Inn2>(context)
                                        .bowling_team[i];
                                  });

                    Navigator.of(context).pop();
                  },
                ),
                Divider(
                  thickness: 1,
                ),
              ],
            );
          },
          itemCount: Provider.of<Content>(context, listen: false).no_of_players,
        ),
      ),
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final prov = Provider.of<Content>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Start Innings'),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 25),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Text(
              'Batting Team: ${prov.batteam == 'A' ? prov.tA : prov.tB}',
              style: TextStyle(fontSize: 25),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: GestureDetector(
                    onTap: () {
                      showAlertDialog(context, 1);
                    },
                    child: Container(
                        color: Colors.green[300],
                        height: MediaQuery.of(context).size.height * 0.25,
                        width: MediaQuery.of(context).size.width * 0.40,
                        child: Center(
                          child: Text(
                            a != null ? a : 'STRIKE',
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        )),
                  ),
                ),
                ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: GestureDetector(
                    onTap: () {
                      showAlertDialog(context, 2);
                    },
                    child: Container(
                        height: MediaQuery.of(context).size.height * 0.25,
                        width: MediaQuery.of(context).size.width * 0.40,
                        color: Colors.orange[300],
                        child: Center(
                            child: Text(
                          b != null ? b : 'NON-STRIKE',
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                          ),
                        ))),
                  ),
                ),
              ],
            ),
            Text(
              'Fielding Team: ${prov.batteam == 'A' ? prov.tB : prov.tA}',
              style: TextStyle(fontSize: 25),
            ),
            ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: GestureDetector(
                onTap: () {
                  showAlertDialog(context, 3);
                },
                child: Container(
                    height: MediaQuery.of(context).size.height * 0.25,
                    width: MediaQuery.of(context).size.width * 0.40,
                    color: Colors.purple[300],
                    child: Center(
                        child: Text(
                      c != null ? c : 'BOWLER',
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                    ))),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
          child: Icon(Icons.done_all),
          backgroundColor: Colors.blue,
          onPressed: () {
            if (a == null)
              showAlertDialog2(
                  context, "Select a batsman for strike", "STRIKE??");
            else if (b == null)
              showAlertDialog2(
                  context, "Select a batsman for non-strike", "NON-STRIKE??");
            else if (c == null)
              showAlertDialog2(
                  context, "Select the current bowler", "BOWLER??");
            else if (a == b) {
              showAlertDialog2(
                  context,
                  "Select different batsman for strike/non-strike!",
                  "Same Batsmen!");
            } else if (Provider.of<Content>(context).start) {
              Provider.of<Inn1>(context).strike = a;
              Provider.of<Inn1>(context).index_strike =
                  (Provider.of<Inn1>(context).findbatsmanByName(a));

              Provider.of<Inn1>(context).non_strike = b;
              Provider.of<Inn1>(context).index_nonstrike =
                  (Provider.of<Inn1>(context).findbatsmanByName(b));

              Provider.of<Inn1>(context).bowler = c;
              Provider.of<Inn1>(context).index_bowler =
                  (Provider.of<Inn1>(context).findbowlerByName(c));

              Navigator.of(context).pushReplacementNamed(Innings1.routeName);
            } else if (!Provider.of<Content>(context).start) {
              Provider.of<Inn2>(context).strike = a;
              Provider.of<Inn2>(context).index_strike =
                  (Provider.of<Inn2>(context).findbatsmanByName(a));

              Provider.of<Inn2>(context).non_strike = b;
              Provider.of<Inn2>(context).index_nonstrike =
                  (Provider.of<Inn2>(context).findbatsmanByName(b));
//
              Provider.of<Inn2>(context).bowler = c;
              Provider.of<Inn2>(context).index_bowler =
                  (Provider.of<Inn2>(context).findbowlerByName(c));
              Navigator.of(context).pushReplacementNamed(Innings2.routeName);
            }
          }),
    );
  }

  showAlertDialog2(BuildContext context, String text, String content) {
    // set up the button
    Widget okButton = FlatButton(
      child: Text("OK"),
      onPressed: () {
        Navigator.of(context).pop();
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text(
        content,
        style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
      ),
      content: Text(
        text,
        style: TextStyle(color: Colors.grey),
      ),
      actions: [
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
