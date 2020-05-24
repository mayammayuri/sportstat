import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import '../providers/contents.dart';
import 'score_track.dart';
import 'innings2.dart';
import 'break.dart';
import '../providers/inn1.dart';

class Innings1 extends StatefulWidget {
  static const routeName = '/i1';
  @override
  _Innings1State createState() => _Innings1State();
}

class _Innings1State extends State<Innings1> {
  @override
  Widget build(BuildContext context) {
    final prov = Provider.of<Content>(context);
    final prov2 = Provider.of<Inn1>(context);
    final int innings = 1;
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.grey[900],
          title: Text('First Innings'),
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            GestureDetector(
              onTap: () => prov2.change_strike(),
              child: Container(
                height: MediaQuery.of(context).size.height * 0.04,
                width: double.infinity,
                color: Colors.orange,
                child: Center(
                  child: Text(
                    'Change Strike',
                    style: TextStyle(fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Container(
                    width: MediaQuery.of(context).size.width * 0.5,
                    padding: EdgeInsets.all(5),
                    decoration: BoxDecoration(
                        color: Colors.yellow[600],
                        border: Border.all(width: 0.3)),
                    child: Text(
                      prov2.runrate.toString() + '*   (Runrate)',
                      style: TextStyle(
                          fontFamily: 'NimbusRomNo9L',
                          fontSize: 10,
                          fontWeight: FontWeight.w600),
                      textAlign: TextAlign.center,
                    )
                    ),
                Container(
                    decoration: BoxDecoration(
                        color: Colors.red[600],
                        border: Border.all(width: 0.3)),
                    width: MediaQuery.of(context).size.width * 0.3,
                    padding: EdgeInsets.all(5),
                    child: Text(
                      prov2.bat[prov2.index_nonstrike].name,
                      style: TextStyle(
                          fontFamily: 'NimbusRomNo9L',
                          fontSize: 17,
                          fontWeight: FontWeight.w600),
                      textAlign: TextAlign.center,
                    )),
              ]),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Container(
                    width: MediaQuery.of(context).size.width * 0.5,
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                        color: Colors.yellow[600],
                        border: Border.all(width: 0.5)),
                    child: Text(
                      prov2.bat[prov2.index_strike].name + '*   (Strike)',
                      style: TextStyle(
                          fontFamily: 'NimbusRomNo9L',
                          fontSize: 17,
                          fontWeight: FontWeight.w600),
                      textAlign: TextAlign.center,
                    )
                    ),
                Container(
                    decoration: BoxDecoration(
                        color: Colors.yellow[600],
                        border: Border.all(width: 0.5)),
                    width: MediaQuery.of(context).size.width * 0.5,
                    padding: EdgeInsets.all(10),
                    child: Text(
                      prov2.bat[prov2.index_nonstrike].name,
                      style: TextStyle(
                          fontFamily: 'NimbusRomNo9L',
                          fontSize: 17,
                          fontWeight: FontWeight.w600),
                      textAlign: TextAlign.center,
                    )),
              ],
            ),
           
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                Container(
                    width: MediaQuery.of(context).size.width * 0.5,
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                        color: Colors.yellow[200],
                        border: Border.all(width: 0.5)),
                    child: Text(
                      prov2.bat[prov2.index_strike].runs.toString() +
                          '(' +
                          prov2.bat[prov2.index_strike].balls_played
                              .toString() +
                          ')',
                      style: TextStyle(
                          fontFamily: 'NimbusRomNo9L',
                          fontSize: 17,
                          fontWeight: FontWeight.w600),
                      textAlign: TextAlign.center,
                    )),
                Divider(
                  thickness: 1,
                  color: Colors.black,
                ),
                Container(
                    decoration: BoxDecoration(
                        color: Colors.yellow[200],
                        border: Border.all(width: 0.5)),
                    width: MediaQuery.of(context).size.width * 0.5,
                    padding: EdgeInsets.all(10),
                    child: Text(
                      prov2.bat[prov2.index_nonstrike].runs.toString() +
                          '(' +
                          prov2.bat[prov2.index_nonstrike].balls_played
                              .toString() +
                          ')',
                      style: TextStyle(
                          fontFamily: 'NimbusRomNo9L',
                          fontSize: 17,
                          fontWeight: FontWeight.w600),
                      textAlign: TextAlign.center,
                    )),
              ],
            ),
            Container(
//              color: Colors.black87,
              height: MediaQuery.of(context).size.height * 0.25,
              width: double.infinity,
              child: Center(
                child: Row(
                  textBaseline: TextBaseline.alphabetic,
                  crossAxisAlignment: CrossAxisAlignment.baseline,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      '${prov2.runs}',
                      style: TextStyle(
                        fontFamily: 'JerseyM54',
                        fontSize: 50,
                        fontWeight: FontWeight.w300,
                      ),
                    ),
                    Text(
                      '/',
                      style: TextStyle(
                          fontSize: 60,
                          fontWeight: FontWeight.w400,
                          textBaseline: TextBaseline.ideographic),
                    ),
                    Text(
                      '${prov2.wickets}',
                      style: TextStyle(
                        fontFamily: 'JerseyM54',
                        fontSize: 50,
                        fontWeight: FontWeight.w300,
                      ),
                    ),
                    Text(
                      ' (' + prov.curr_over + '/' + prov.overs.toString() + ')',
                      style: TextStyle(
                        fontSize: 18,
                      ),
                    ),
                    Text(prov.total.toString()),
                  ],
                ),
              ),
            ),
            Container(
                decoration: BoxDecoration(
                  color: Colors.black87,
                ),
                padding: EdgeInsets.all(10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Text(
                      prov2.bowl[prov2.index_bowler].name,
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          fontSize: 15),
                    ),
                    Text(
                      (prov2.bowl[prov2.index_bowler].overs)
                              .floor()
                              .toString() +
                          '.' +
                          ((prov2.bowl[prov2.index_bowler].balls_thrown) % 6)
                              .toString() +
                          '-' +
                          prov2.bowl[prov2.index_bowler].maiden.toString() +
                          '-' +
                          prov2.bowl[prov2.index_bowler].runs_given.toString() +
                          '-' +
                          prov2.bowl[prov2.index_bowler].wickets.toString(),
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          fontSize: 15),
                    ),
                  ],
                )),
            Container(
              height: 60,
              decoration: BoxDecoration(
                  border: Border.all(width: 0), color: Colors.black87),
              child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: Provider.of<Content>(context).avatars.length,
                  itemBuilder: (context, i) {
                    return Row(children: <Widget>[
                      Column(
                        children: <Widget>[
                          SizedBox(
                            width: 10,
                          ),
                        ],
                      ),
                      CircleAvatar(
                        backgroundColor:
                            Provider.of<Content>(context).avatars[i].col_ava,
                        child: Text(
                          Provider.of<Content>(context).avatars[i].con,
                          style: TextStyle(
                              fontFamily: 'JerseyM54', color: Colors.black),
                        ),
                      ),
                    ]);
                  }),
            ),
            Scoretrack(innings),
          ],
        ));
  }
}
