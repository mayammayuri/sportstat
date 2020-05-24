import 'package:flutter/material.dart';
import 'package:harsh/screens/loading.dart';
import 'innings1.dart';
import 'package:provider/provider.dart';
import '../providers/contents.dart';
import 'teamA.dart';
import '../providers/inn1.dart';
import '../providers/inn2.dart';
import '../screens/imageview360.dart';


class Toss extends StatefulWidget {
  static const routeName = '/score';

  @override
  _TossState createState() => _TossState();
}

class _TossState extends State<Toss> {
  final cont = TextEditingController();
  final fn0 = FocusNode();
  final fn1 = FocusNode();
  final fn2 = FocusNode();
  final fn3 = FocusNode();
  var toss_win;
  final _form1 = GlobalKey<FormState>();
  final _form2 = GlobalKey<FormState>();
  final _form3 = GlobalKey<FormState>();
  final _form4 = GlobalKey<FormState>();
  bool tossresult = false;
  bool toss = false;
  String teamA;
  String teamB;
  int no_of_players = 0;
  double overs = 0.0;
  var _isLoading = false;

  @override
  void _onsaved() {
    if (!_form4.currentState.validate() ||
        !_form3.currentState.validate() ||
        !_form2.currentState.validate() ||
        !_form1.currentState.validate()) return;

    FocusScope.of(context).unfocus();
    _form1.currentState.save();
    _form3.currentState.save();
    _form4.currentState.save();
    _form2.currentState.save();
    _form3.currentState.save();

//    cont.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        title: Text('Scorer'),
      ),
      body: _isLoading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    SizedBox(
                      height: 30,
                    ),
                    Card(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15)),
                        child: Form(
                          key: _form1,
                          child: ListTile(
                            leading: Text(
                              'Enter name of TEAM-A',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            title: TextFormField(
                              initialValue: 'A',
                              focusNode: fn0,
                              validator: (value) {
                                if (value.isEmpty) {
                                  return ('Please enter a valid name');
                                } else
                                  return null;
                              },
                              textInputAction: TextInputAction.next,
                              onFieldSubmitted: (_) {
                                FocusScope.of(context).requestFocus(fn1);
                              },
                              onSaved: (value) {
                                setState(() {
                                  teamA = value;
                                });
                              },
                            ),
                          ),
                        )),
                    Card(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15)),
                        child: Form(
                          key: _form2,
                          child: ListTile(
                            leading: Text(
                              'Enter name of TEAM-B',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            title: TextFormField(
                              initialValue: 'B',
                              focusNode: fn1,
                              validator: (value) {
                                if (value.isEmpty) {
                                  return ('Please enter a valid name');
                                } else
                                  return null;
                              },
                              textInputAction: TextInputAction.next,
                              onFieldSubmitted: (_) {
                                FocusScope.of(context).requestFocus(fn2);
                              },
                              onSaved: (value) {
                                setState(() {
                                  teamB = value;
                                });
                              },
                            ),
                          ),
                        )),
                    Card(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15)),
                        child: Form(
                          key: _form3,
                          child: ListTile(
                            leading: Text(
                              'Enter number of Players',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            title: TextFormField(
                              focusNode: fn2,
                              keyboardType: TextInputType.number,
                              validator: (value) {
                                if (value.isEmpty || value == 0.toString()) {
                                  return ('Empty');
                                } else if (int.parse(value) > 11) {
                                  return ('Maximum 11 players');
                                } else if (int.parse(value) < 3) {
                                  return ('Minimum 3 players');
                                } else
                                  return null;
                              },
                              textInputAction: TextInputAction.next,
                              onFieldSubmitted: (_) {
                                FocusScope.of(context).requestFocus(fn3);
                              },
                              onSaved: (value) {
                                no_of_players = int.parse(value);
                              },
                            ),
                          ),
                        )),
                    Card(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15)),
                        child: Form(
                          key: _form4,
                          child: ListTile(
                            leading: Text(
                              'Enter number of Overs',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            title: TextFormField(
                              controller: cont,
                              focusNode: fn3,
                              keyboardType: TextInputType.number,
                              validator: (value) {
                                if (value.isEmpty || value == 0.toString()) {
                                  return ('Empty');
                                } else
                                  return null;
                              },
                              onSaved: (value) {
                                setState(() {
                                  overs = double.parse(value);
                                });
                              },
                            ),
                          ),
                        )),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: RaisedButton(
                        onPressed: () {
                          _onsaved();
                          if (_form4.currentState.validate() &&
                              _form3.currentState.validate() &&
                              _form2.currentState.validate() &&
                              _form1.currentState.validate()) {
                            setState(() {
                              toss = true;
                            });
                          }
                        },
                        child: Text(
                          'Done',
                          style: TextStyle(color: Colors.white),
                        ),
                        color: Colors.lightBlue,
                      ),
                    ),
                    SizedBox(
                      height: 50,
                    ),
                    Visibility(
                      visible: toss,
                      child: Form(
                        child: Column(
                          children: <Widget>[
                            Text(
                              'Toss won by?',
                              style: TextStyle(fontSize: 20),
                            ),
                            SizedBox(
                              height: 30,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: <Widget>[
                                Container(
                                  width:
                                      MediaQuery.of(context).size.width * 0.45,
                                  child: FlatButton(
                                    onPressed: () {
                                      setState(() {
                                        toss_win = 'A';
                                        tossresult = true;
                                      });
                                    },
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(15),
                                      child: Image.asset(
                                        'images/AFINAL.png',
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                ),
                                Container(
                                  width:
                                      MediaQuery.of(context).size.width * 0.45,
                                  child: FlatButton(
                                    onPressed: () {
                                      setState(() {
                                        toss_win = 'B';
                                        tossresult = true;
                                      });
                                    },
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(15),
                                      child: Image.asset(
                                        'images/BFINAL.jpeg',
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 50,
                    ),
                    Visibility(
                        visible: tossresult,
                        child: toss_win == 'A'
                            ? Text(
                                '${teamA} choses to:',
                                style: TextStyle(fontSize: 20),
                                textAlign: TextAlign.center,
                              )
                            : Text(
                                '${teamB} choses to:',
                                style: TextStyle(fontSize: 20),
                                textAlign: TextAlign.center,
                              )),
                    SizedBox(
                      height: 35,
                    ),
                    Visibility(
                      visible: tossresult,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          Container(
                            width: MediaQuery.of(context).size.width * 0.4,
                            child: FlatButton(
                                color: Colors.lightBlue,
                                child: Text(
                                  'BAT',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w700),
                                ),
                                onPressed: () {
                                  Provider.of<Inn1>(context).overs = overs;
                                  Provider.of<Inn2>(context).overs = overs;
                                  Provider.of<Content>(context).batteam =
                                      toss_win;
                                  Provider.of<Content>(context).matchDat(
                                      teamA,
                                      teamB,
                                      overs,
                                      no_of_players,
                                      toss_win,
                                      toss_win);
                                  Navigator.of(context)
                                      .pushReplacementNamed(TeamA.routeName);
                                }),
                          ),
                          Container(
                            width: MediaQuery.of(context).size.width * 0.4,
                            child: FlatButton(
                              color: Colors.lightBlue,
                              child: Text(
                                'BALL',
                                style: TextStyle(color: Colors.white),
                              ),
                              onPressed: () {
                                Provider.of<Content>(context).batteam =
                                    toss_win == 'A' ? 'B' : 'A';
                                Provider.of<Inn1>(context).overs = overs;
                                Provider.of<Inn2>(context).overs = overs;

                                _isLoading = true;

                                Provider.of<Content>(context).matchDat(
                                    teamA,
                                    teamB,
                                    overs,
                                    no_of_players,
                                    toss_win,
                                    toss_win == 'B' ? 'A' : 'B');
                                setState(() {
                                  _isLoading = false;
                                });
                                Navigator.of(context)
                                    .pushReplacementNamed(TeamA.routeName);
                              },
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}
