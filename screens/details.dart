import 'package:flutter/material.dart';
import 'package:harsh/screens/innings1.dart';
import 'package:provider/provider.dart';
import '../providers/contents.dart';
import '../providers/inn1.dart';
import '../providers/inn2.dart';
import 'dart:convert';
import 'innings2.dart';

class Details extends StatefulWidget {
  static const routeName = '/details';
  @override
  _DetailsState createState() => _DetailsState();
  var teamlistA;
  var teamlistB;

}

class _DetailsState extends State<Details> {


  @override
  Widget build(BuildContext context) {
    Provider.of<Inn2>(context).target = Provider.of<Inn1>(context).runs + 1;
    Provider.of<Inn2>(context).ball_left =
        (Provider.of<Content>(context).overs) * 6;
                return Scaffold(
                  appBar: AppBar(
                    title: Text('<<<Details>>>'),
                  ),
                  body: Column(
                    children: <Widget>[
                      SizedBox(
                        width: 10,
                      ),
                  Column(
               mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Container(
                        //height: MediaQuery.of(context).size.height * 0.4,
                        width: MediaQuery.of(context).size.width * 2.0,
                        padding: EdgeInsets.all(5),
                        decoration: BoxDecoration(
                            color: Colors.black12,
                            border: Border.all(width: 0.3)),
                        child: Text(
                            '*   (Team A )',
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
                    width: MediaQuery.of(context).size.width * 2.0,
                    padding: EdgeInsets.all(5),
                    child: Text(
                            Provider.of<Inn2>(context).batting_team.toString()+" hhhhhh ",
                    
                      style: TextStyle(
                          fontFamily: 'NimbusRomNo9L',
                          fontSize: 17,
                          fontWeight: FontWeight.w600),
                      textAlign: TextAlign.center,
                    ),
                      ),
                                 
            ],),
            

                    ],),);
  }
}