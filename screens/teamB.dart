import 'package:flutter/material.dart';
import 'package:harsh/screens/bat_ball.dart';
import 'package:harsh/screens/loading.dart';
import 'package:provider/provider.dart';
import 'toss.dart';
import '../providers/contents.dart';
import 'innings1.dart';
import '../providers/inn1.dart';
import '../providers/inn2.dart';
import '../providers/player_details.dart';

class TeamB extends StatefulWidget {
  static const routeName = '/teamB';
  int n = 0;
  @override
  _TeamBState createState() => _TeamBState();
}

class _TeamBState extends State<TeamB> {
  final _key = GlobalKey<FormState>();
  var cont = TextEditingController();
  void _onsaved() {
    _key.currentState.save();
    cont.clear();
    //FocusScope.of(context).unfocus();
  }

  showAlertDialog(BuildContext context) {
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
        "Select the Captain",
        style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
      ),
      content: Text(
        "Tap on the Captain's name",
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

  var _isLoading = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('TEAM ${Provider.of<Content>(context).tB}'),
        ),
        body: _isLoading
            ? Center(
                child: CircularProgressIndicator(),
              )
            : Column(
                children: <Widget>[
                  Visibility(
                    visible:
                        widget.n >= Provider.of<Content>(context).no_of_players,
                    child: Column(
                      children: <Widget>[
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          'Select a Captain!',
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        )
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Expanded(
                    child: ListView.builder(
                      itemCount: widget.n,
                      itemBuilder: (ctx, index) => Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 15),
                        child: Card(
                          child: ListTile(
                            onTap: widget.n >=
                                    Provider.of<Content>(context).no_of_players
                                ? () {
                                    setState(() {
                                      Provider.of<Content>(context).capB =
                                          Provider.of<Content>(context)
                                              .namesB[index];
                                    });
                                  }
                                : () {},
                            leading: Text(
                                Provider.of<Content>(context).namesB[index]),
                            trailing: Provider.of<Content>(context).capB == null
                                ? SizedBox(
                                    width: 2,
                                  )
                                : Provider.of<Content>(context).capB ==
                                        Provider.of<Content>(context)
                                            .namesB[index]
                                    ? Icon(Icons.copyright)
                                    : SizedBox(
                                        width: 2,
                                      ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Visibility(
                    visible:
                        widget.n < Provider.of<Content>(context).no_of_players,
                    child: Form(
                      key: _key,
                      child: ListTile(
                        title: TextFormField(
                            validator: (value) {
                              if (value.isEmpty) {
                                return 'Please enter a name.';
                              }
                              return null;
                            },
                            onSaved: (_) {
                              _onsaved;
                            },
                            controller: cont,
                            decoration:
                                InputDecoration(hintText: 'Add Player')),
                        trailing: FlatButton(
                            child: Text(
                              'Add',
                              style: TextStyle(color: Colors.white),
                            ),
                            color: Colors.blue,
                            onPressed: () {
                              _key.currentState.validate();
                              if (_key.currentState.validate()) {
                                setState(() {
                                  widget.n++;
//                                  Provider.of<Content>(context).batteam == 'A'
//                                      ? Provider.of<Inn1>(context)
//                                          .field
//                                          .add(cont.value.text)
//                                      : Provider.of<Inn1>(context)
//                                          .bat
//                                          .add(cont.value.text);

                                  Provider.of<Content>(context)
                                      .addB(cont.value.text);
                                });
                                if (Provider.of<Content>(context).batteam ==
                                    'B') {
                                  Provider.of<Inn1>(context).addBatting(
                                      Player(name: cont.value.text, team: 'B'));
                                  Provider.of<Inn2>(context).addBowling(
                                      Player(name: cont.value.text, team: 'B'));
                                } else {
                                  Provider.of<Inn2>(context).addBatting(
                                      Player(name: cont.value.text, team: 'B'));
                                  Provider.of<Inn1>(context).addBowling(
                                      Player(name: cont.value.text, team: 'B'));
                                }

                                _onsaved();
                              }
                            }),
                      ),
                    ),
                  ),
                  Visibility(
                    visible:
                        widget.n >= Provider.of<Content>(context).no_of_players,
                    child: RaisedButton(
                        color: Colors.blue,
                        child: Text(
                          'Proceed',
                          style: TextStyle(color: Colors.white),
                        ),
                        onPressed: Provider.of<Content>(context).capB != null
                            ? () async {
                                setState(() {
                                  _isLoading = true;
                                });
                                Provider.of<Content>(context).press = true;
                                await Provider.of<Content>(context).addB('');
                                setState(() {
                                  _isLoading = false;
                                });
                                if (Provider.of<Content>(context).batteam ==
                                    'A') {
                                  Provider.of<Inn1>(context).batting_team =
                                      Provider.of<Content>(context).namesA;
                                  Provider.of<Inn1>(context).bowling_team =
                                      Provider.of<Content>(context).namesB;
                                  Provider.of<Inn2>(context).batting_team =
                                      Provider.of<Content>(context).namesB;
                                  Provider.of<Inn2>(context).bowling_team =
                                      Provider.of<Content>(context).namesA;
                                } else {
                                  Provider.of<Inn1>(context).batting_team =
                                      Provider.of<Content>(context).namesB;
                                  Provider.of<Inn1>(context).bowling_team =
                                      Provider.of<Content>(context).namesA;
                                  Provider.of<Inn2>(context).batting_team =
                                      Provider.of<Content>(context).namesA;
                                  Provider.of<Inn2>(context).bowling_team =
                                      Provider.of<Content>(context).namesB;
                                }
                                for (var i = 0;
                                    i < Provider.of<Inn1>(context).bat.length;
                                    i++) {
                                  Provider.of<Inn1>(context).batnext.add(
                                      Provider.of<Inn1>(context).bat[i].name);
                                }
                                for (var i = 0;
                                    i < Provider.of<Inn2>(context).bat.length;
                                    i++) {
                                  Provider.of<Inn2>(context).nextbat.add(
                                      Provider.of<Inn2>(context).bat[i].name);
                                }
                                Navigator.of(context)
                                    .pushReplacementNamed(BatBall.routeName);
                              }
                            : () {
                                showAlertDialog(context);
                              }),
                  ),
                  SizedBox(
                    height: 40,
                  ),
                ],
              ));
  }
}
