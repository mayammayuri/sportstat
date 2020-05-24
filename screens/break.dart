import 'dart:math';

import 'package:flutter/material.dart';
import 'package:harsh/screens/bat_ball.dart';
import 'package:provider/provider.dart';
import '../providers/contents.dart';
import '../providers/inn2.dart';
import '../providers/inn1.dart';
import 'innings1.dart';

class Break extends StatefulWidget {
  static const routeName = '/break';
  @override
  _BreakState createState() => _BreakState();
}

class _BreakState extends State<Break> {
  @override
  Widget build(BuildContext context) {
    Provider.of<Inn2>(context).target = Provider.of<Inn1>(context).runs + 1;
    Provider.of<Inn2>(context).ball_left =
        (Provider.of<Content>(context).overs) * 6;
    var indexStrike;
        return Scaffold(
          appBar: AppBar(
            title: Text('Time for a Break!'),
          ),
          body: Column(
            children: <Widget>[
              SizedBox(
                width: 10,
              ),
           Row(
               mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Container(
                        //height: MediaQuery.of(context).size.height * 0.4,
                        width: MediaQuery.of(context).size.width * 0.5,
                        padding: EdgeInsets.all(5),
                        decoration: BoxDecoration(
                            color: Colors.yellow[600],
                            border: Border.all(width: 0.3)),
                        child: Text(
                           '*   (Runrate)',
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
                         Provider.of<Inn1>(context).runrate.toString(),
                          style: TextStyle(
                              fontFamily: 'NimbusRomNo9L',
                              fontSize: 17,
                              fontWeight: FontWeight.w600),
                          textAlign: TextAlign.center,
                        )),
                  ],
           
          ),
          Row(
               mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Container(
                        //height: MediaQuery.of(context).size.height * 0.4,
                        width: MediaQuery.of(context).size.width * 0.5,
                        padding: EdgeInsets.all(5),
                        decoration: BoxDecoration(
                            color: Colors.yellow[600],
                            border: Border.all(width: 0.3)),
                        child: Text(
                            '*   (Best Batsmen made runs )',
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
                                max(Provider.of<Inn1>(context).bat[Provider.of<Inn1>(context).index_nonstrike].runs,Provider.of<Inn1>(context).bat[Provider.of<Inn1>(context).index_strike].runs).toString(),
                      style: TextStyle(
                          fontFamily: 'NimbusRomNo9L',
                          fontSize: 17,
                          fontWeight: FontWeight.w600),
                      textAlign: TextAlign.center,
                    )),
              ],
       
      ),
          Row(
               mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Container(
                        //height: MediaQuery.of(context).size.height * 0.4,
                        width: MediaQuery.of(context).size.width * 0.5,
                        padding: EdgeInsets.all(5),
                        decoration: BoxDecoration(
                            color: Colors.yellow[600],
                            border: Border.all(width: 0.3)),
                        child: Text(
                            '*   (Best Batsmen )',
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
                      Provider.of<Inn1>(context).bat[Provider.of<Inn1>(context).index_nonstrike].name.toString(),
                      style: TextStyle(
                          fontFamily: 'NimbusRomNo9L',
                          fontSize: 17,
                          fontWeight: FontWeight.w600),
                      textAlign: TextAlign.center,
                    )),
              ],
       
      ),
      Row(
               mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Container(
                        //height: MediaQuery.of(context).size.height * 0.4,
                        width: MediaQuery.of(context).size.width * 0.5,
                        padding: EdgeInsets.all(5),
                        decoration: BoxDecoration(
                            color: Colors.yellow[600],
                            border: Border.all(width: 0.3)),
                        child: Text(
                            '*   (Wickets taken )',
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
                      Provider.of<Inn1>(context).bowl[Provider.of<Inn1>(context).index_bowler].wickets.toString(),
                      style: TextStyle(
                          fontFamily: 'NimbusRomNo9L',
                          fontSize: 17,
                          fontWeight: FontWeight.w600),
                      textAlign: TextAlign.center,
                    )),
              ],
       
      ),
      Row(
               mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Container(
                        //height: MediaQuery.of(context).size.height * 0.4,
                        width: MediaQuery.of(context).size.width * 0.5,
                        padding: EdgeInsets.all(5),
                        decoration: BoxDecoration(
                            color: Colors.yellow[600],
                            border: Border.all(width: 0.3)),
                        child: Text(
                            '*   (Bowler )',
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
                      Provider.of<Inn1>(context).bowl[Provider.of<Inn1>(context).index_bowler].name.toString(),
                      style: TextStyle(
                          fontFamily: 'NimbusRomNo9L',
                          fontSize: 17,
                          fontWeight: FontWeight.w600),
                      textAlign: TextAlign.center,
                    )),
              ],
       
      ),
      Row(
               mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Container(
                        //height: MediaQuery.of(context).size.height * 0.4,
                        width: MediaQuery.of(context).size.width * 0.5,
                        padding: EdgeInsets.all(5),
                        decoration: BoxDecoration(
                            color: Colors.yellow[600],
                            border: Border.all(width: 0.3)),
                        child: Text(
                            '*   (Balls thrown )',
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
                      Provider.of<Inn1>(context).bowl[Provider.of<Inn1>(context).index_bowler].balls_thrown.toString(),
                      style: TextStyle(
                          fontFamily: 'NimbusRomNo9L',
                          fontSize: 17,
                          fontWeight: FontWeight.w600),
                      textAlign: TextAlign.center,
                    )),
              ],
       
      ),
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Container(
                        //height: MediaQuery.of(context).size.height * 0.4,
                        width: MediaQuery.of(context).size.width * 1.0,
                        padding: EdgeInsets.all(50),
                        decoration: BoxDecoration(
                            color: Colors.yellow[600],
                            border: Border.all(width: 0.3)),
                        child: Text(
                            '*   (Team 2 Target = )'+Provider.of<Inn2>(context).target.toString(),
                      style: TextStyle(
                          fontFamily: 'NimbusRomNo9L',
                          fontSize: 10,
                          fontWeight: FontWeight.w600),
                      textAlign: TextAlign.center,
                    )
                    ),
               
                
              ],
       
      ),
      ],),
              bottomNavigationBar: RaisedButton(
               child: Text('Start Innings2'),
               onPressed: () {
                    Provider.of<Content>(context).start = false;
                    print(Provider.of<Inn2>(context).bowling_team);
                     Provider.of<Content>(context).avatars = [];
                    Navigator.of(context).pushReplacementNamed(BatBall.routeName);
                                                                  },
                                                                ),
                                                              );
                                                            }
                                                          }
                            
                

                            
                            