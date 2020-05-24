import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:harsh/screens/innings1.dart';
import 'package:provider/provider.dart';
import '../providers/contents.dart';
import '../providers/inn1.dart';
import '../providers/inn2.dart';
import 'innings1.dart';
import 'innings2.dart';

class Wicketdetails extends StatefulWidget {
  var typ;
  var wicketballtype;
  Wicketdetails(int type) {
    this.typ = type;
  }
  @override
  _WicketdetailsState createState() => _WicketdetailsState();
}

class _WicketdetailsState extends State<Wicketdetails> {
  @override
  Widget build(BuildContext context) {
    final type = widget.typ;
    final prov = Provider.of<Content>(context);
    final prov2 = Provider.of<Inn1>(context);
    final prov3 = Provider.of<Inn2>(context);
    var title;
    if (type == 2) {
      title = 'Caught Out';
    } else if (type == 3) {
      title = 'Run-out';
    } else if (type == 5) {
      title = 'Stumped';
      //prov.a = 'Wicket-keeper';
    } else if (type == 9) {
      title = 'Obstructing the field!';
    } else if (type == 6) {
      title = 'HIT WICKET!';
    } else if (type == 10) {
      title = 'Retired!';
    }
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
        actions: <Widget>[
          IconButton(
            onPressed: () {
              if (type == 2) {
                if (prov.a != 'Fielder1') {
                  prov.start
                      ? prov2.out(context, type, prov2.index_strike, 0, 'legal',
                          null, null)
                      : prov3.out(context, type, prov3.index_strike, 0, 'legal',
                          null, null);
                } else {
                  showAlertDialog2(
                      context, 'Who caught the ball?', 'Caught by?');
                }
              }
              if (type == 3 || type == 9) {
                if (prov.chosen_batsman != 'no') {
                  if (prov.a != 'Fielder1') {
                    prov.key.currentState.validate();
                    if (prov.key.currentState.validate()) {
                      prov.addrun(int.parse(prov.cont.value.text));
                      prov.start
                          ? prov2.out(
                              context,
                              type,
                              prov2.findbatsmanByName(prov.chosen_batsman),
                              int.parse(prov.cont.value.text),
                              widget.wicketballtype != null
                                  ? widget.wicketballtype
                                  : 'legal',
                              prov.a,
                              prov.b != 'Fielder2' ? prov.b : null)
                          : prov3.out(
                              context,
                              type,
                              prov3.findbatsmanByName(prov.chosen_batsman),
                              int.parse(prov.cont.value.text),
                              widget.wicketballtype != null
                                  ? widget.wicketballtype
                                  : 'legal',
                              prov.a,
                              prov.b != 'Fielder2' ? prov.b : null);
                      prov.cont.clear();
                      prov.chosen_batsman = 'no';
                      widget.wicketballtype = null;
                    }
                  } else
                    showAlertDialog2(context, 'Fielder',
                        'Which fielder dismissed the batsman?');
                } else
                  showAlertDialog2(context, 'Who?', 'Who got run out?');
              }
              if (type == 5) {
                if (widget.wicketballtype != 'Wide') prov.add_balls(context);

                if (prov.a != 'Fielder1') {
                  prov.start
                      ? prov2.out(
                          context,
                          type,
                          prov2.index_strike,
                          0,
                          widget.wicketballtype != null
                              ? widget.wicketballtype
                              : 'legal',
                          prov.a,
                          null)
                      : prov3.out(
                          context,
                          type,
                          prov3.index_strike,
                          0,
                          widget.wicketballtype != null
                              ? widget.wicketballtype
                              : 'legal',
                          prov.a,
                          null);
                  widget.wicketballtype = null;
                } else {
                  showAlertDialog2(
                      context, 'Who is the wicket-keeper?', 'Keeper?');
                }
              }
              if (type == 6) {
                prov.start
                    ? prov2.out(
                        context,
                        type,
                        prov2.index_strike,
                        0,
                        widget.wicketballtype != null
                            ? widget.wicketballtype
                            : 'legal',
                        null,
                        null)
                    : prov3.out(
                        context,
                        type,
                        prov3.index_strike,
                        0,
                        widget.wicketballtype != null
                            ? widget.wicketballtype
                            : 'legal',
                        null,
                        null);
                if (widget.wicketballtype == null) prov.add_balls(context);

                widget.wicketballtype = null;
              }
              if (type == 10) {
                if (prov.chosen_batsman != 'no') {
                  prov.start
                      ? prov2.out(
                          context,
                          type,
                          prov2.findbatsmanByName(prov.chosen_batsman),
                          0,
                          null,
                          null,
                          null)
                      : prov3.out(
                          context,
                          type,
                          prov3.findbatsmanByName(prov.chosen_batsman),
                          0,
                          null,
                          null,
                          null);
                }
              }
            },
            icon: Icon(
              Icons.navigate_next,
              color: Colors.white,
            ),
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 15.0, horizontal: 25),
        child: ListView(
          //mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Visibility(
              visible: type == 3 || type == 8 || type == 9 || type == 10,
              child: Padding(
                padding: EdgeInsets.all(20),
                child: Text(
                  'Who?',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Visibility(
                  visible: type == 3 || type == 8 || type == 9,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(15),
                    child: GestureDetector(
                      onTap: () {
                        Provider.of<Content>(context).chosen_batsman =
                            prov.start
                                ? prov2.bat[prov2.index_nonstrike].name
                                : prov3.bat[prov3.index_nonstrike].name;
                      },
                      child: Container(
                        color: Colors.orange[300],
                        width: MediaQuery.of(context).size.width * 0.35,
                        height: MediaQuery.of(context).size.height * 0.20,
                        child: Center(
                            child: Text(prov.start
                                ? prov2.bat[prov2.index_strike].name + '*'
                                : prov3.bat[prov3.index_strike].name + '*')),
                      ),
                    ),
                  ),
                ),
                Visibility(
                  visible: type == 3 || type == 8 || type == 9,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(15),
                    child: GestureDetector(
                      onTap: () {
                        Provider.of<Content>(context).chosen_batsman =
                            prov.start
                                ? prov2.bat[prov2.index_nonstrike].name
                                : prov3.bat[prov3.index_nonstrike].name;
                      },
                      child: Container(
                        color: Colors.green[300],
                        width: MediaQuery.of(context).size.width * 0.35,
                        height: MediaQuery.of(context).size.height * 0.20,
                        child: Center(
                            child: Text(prov.start
                                ? prov2.bat[prov2.index_nonstrike].name
                                : prov3.bat[prov3.index_nonstrike].name)),
                      ),
                    ),
                  ),
                )
              ],
            ),
            Visibility(
              visible: type == 3 || type == 8 || type == 9 || type == 2,
              child: Padding(
                padding: EdgeInsets.all(20),
                child: Text(
                  'Fielder/s',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Visibility(
                  visible: type == 2 || type == 3 || type == 9 || type == 5,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(15),
                    child: GestureDetector(
                      onTap: () {
                        showAlertDialog3(context, 1);
                      },
                      child: Container(
                        color: Colors.purple[300],
                        width: MediaQuery.of(context).size.width * 0.35,
                        height: MediaQuery.of(context).size.height * 0.20,
                        child: Center(
                            child: Text(Provider.of<Content>(context).a)),
                      ),
                    ),
                  ),
                ),
                Visibility(
                  visible: type == 3 || type == 9,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(15),
                    child: GestureDetector(
                      onTap: () {
                        showAlertDialog3(context, 2);
                      },
                      child: Container(
                        color: Colors.blue[300],
                        width: MediaQuery.of(context).size.width * 0.35,
                        height: MediaQuery.of(context).size.height * 0.20,
                        child: Center(
                            child: Text(Provider.of<Content>(context).b)),
                      ),
                    ),
                  ),
                )
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Visibility(
              visible: type == 3 || type == 9,
              child: Container(
                height: MediaQuery.of(context).size.height * 0.2,
                width: double.infinity,
                child: GridView(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 5 / 2,
                    crossAxisSpacing: 2,
                    mainAxisSpacing: 2,
                  ),
                  children: <Widget>[
                    GestureDetector(
                      onTap: () {
                        widget.wicketballtype = 'Wide';
                        prov.addrun(1);
                      },
                      child: Card(
                        borderOnForeground: true,
                        child: Center(child: Text('WD')),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        widget.wicketballtype = 'No Ball';
                        prov.addrun(1);
                      },
                      child: Card(
                        child: Center(child: Text('NB')),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        widget.wicketballtype = 'LB';
                        prov.add_balls(context);
                      },
                      child: Card(
                        child: Center(child: Text('LB')),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        widget.wicketballtype = 'Bye';
                        prov.add_balls(context);
                      },
                      child: Card(
                        child: Center(child: Text('BYE')),
                      ),
                    )
                  ],
                ),
              ),
            ),
            Visibility(
              visible: type == 3 || type == 9,
              child: Form(
                key: Provider.of<Content>(context).key,
                child: TextFormField(
                  controller: Provider.of<Content>(context).cont,
                  decoration: InputDecoration(
                    labelText: 'Runs',
                  ),
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    if (value.isEmpty) {
                      return ('Empty');
                    } else {
                      return null;
                    }
                  },
                ),
              ),
            ),
            SizedBox(
              height: 15,
            ),
            Visibility(
              visible: type == 5 || type == 6,
              child: GestureDetector(
                onTap: () {
                  widget.wicketballtype = 'Wide';
                  prov.addrun(1);
                },
                child: Container(
                  color: Colors.grey,
                  height: MediaQuery.of(context).size.height * 0.05,
                  width: MediaQuery.of(context).size.width * 0.05,
                  child: Center(child: Text('Wide')),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  showAlertDialog3(BuildContext context, int num) {
    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
        content: Container(
      height: MediaQuery.of(context).size.height * 0.5,
      width: MediaQuery.of(context).size.width * 0.8,
      child: ListView.builder(
        itemCount: Provider.of<Content>(context).no_of_players,
        itemBuilder: (context, i) {
          return ListTile(
              onTap: () {
                setState(() {
                  if (num == 1) {
                    Provider.of<Content>(context).a =
                        Provider.of<Content>(context).start
                            ? Provider.of<Inn1>(context).bowl[i].name
                            : Provider.of<Inn2>(context).bowl[i].name;
                  } else {
                    Provider.of<Content>(context).b =
                        Provider.of<Content>(context).start
                            ? Provider.of<Inn1>(context).bowl[i].name
                            : Provider.of<Inn2>(context).bowl[i].name;
                  }
                });
                Navigator.of(context).pop();
              },
              title: Text(Provider.of<Content>(context).start
                  ? Provider.of<Inn1>(context).bowl[i].name
                  : Provider.of<Inn2>(context).bowl[i].name));
        },
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
