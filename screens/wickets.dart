import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:harsh/screens/innings1.dart';
import 'package:harsh/screens/wicket_details.dart';
import 'package:provider/provider.dart';
import '../providers/contents.dart';
import '../providers/inn1.dart';
import '../providers/inn2.dart';
import 'innings1.dart';
import 'innings2.dart';
import '../providers/Avatar.dart';

class Wickets extends StatefulWidget {
  static const routeName = '/wickets';

  @override
  _WicketsState createState() => _WicketsState();
}

String a = 'Fielder';

String b = 'Fielder';

class _WicketsState extends State<Wickets> {
  @override
  Widget build(BuildContext context) {
    final prov = Provider.of<Content>(context);
    final prov2 = Provider.of<Inn1>(context);
    final prov3 = Provider.of<Inn2>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('How out?'),
      ),
      body: Container(
        padding: EdgeInsets.all(20),
        child: GridView(
          children: <Widget>[
            GestureDetector(
              onTap: () {
                prov.add_balls(context);
                prov.avatars.add(Avatar(col_ava: Colors.red, con: 'W'));
                prov.start
                    ? prov2.out(
                        context, 1, prov2.index_strike, 0, 'legal', null, null)
                    : prov3.out(
                        context, 1, prov3.index_strike, 0, 'legal', null, null);
              },
              child: Card(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15)),
                child: GridTile(
                  child: Center(
                      child: Text(
                    'Bowled',
                    style: TextStyle(fontSize: 15),
                  )),
                ),
              ),
            ),
            GestureDetector(
              onTap: () {
                prov.add_balls(context);
                prov.avatars.add(Avatar(col_ava: Colors.red, con: 'W'));
                Navigator.of(context).pushReplacement(MaterialPageRoute(
                  builder: (context) {
                    return Wicketdetails(2);
                  },
                ));
              },
              child: Card(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15)),
                child: GridTile(
                  child: Center(
                      child: Text(
                    'Caught',
                    style: TextStyle(fontSize: 15),
                  )),
                ),
              ),
            ),
            GestureDetector(
              onTap: () {
                prov.avatars.add(Avatar(col_ava: Colors.red, con: 'W'));
                Navigator.of(context).pushReplacement(MaterialPageRoute(
                  builder: (context) {
                    return Wicketdetails(3);
                  },
                ));
              },
              child: Card(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15)),
                child: GridTile(
                  child: Center(
                      child: Text(
                    'Run-out',
                    style: TextStyle(fontSize: 15),
                  )),
                ),
              ),
            ),
            GestureDetector(
              onTap: () {
                prov.add_balls(context);
                prov.avatars.add(Avatar(col_ava: Colors.red, con: 'LBW'));
                prov.start
                    ? prov2.out(
                        context, 4, prov2.index_strike, 0, 'legal', null, null)
                    : prov3.out(
                        context, 4, prov3.index_strike, 0, 'legal', null, null);
              },
              child: Card(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15)),
                child: GridTile(
                  child: Center(
                      child: Text(
                    'LBW',
                    style: TextStyle(fontSize: 15),
                  )),
                ),
              ),
            ),
            GestureDetector(
              onTap: () {
                prov.avatars.add(Avatar(col_ava: Colors.red, con: 'W'));
                Navigator.of(context).pushReplacement(MaterialPageRoute(
                  builder: (context) {
                    return Wicketdetails(5);
                  },
                ));
              },
              child: Card(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15)),
                child: GridTile(
                  child: Center(
                      child: Text(
                    'Stumped',
                    style: TextStyle(fontSize: 15),
                  )),
                ),
              ),
            ),
            GestureDetector(
              onTap: () {
                prov.avatars.add(Avatar(col_ava: Colors.red, con: 'W'));
                Navigator.of(context).pushReplacement(MaterialPageRoute(
                  builder: (context) {
                    return Wicketdetails(6);
                  },
                ));

//                prov.start
//                    ? prov2.out(
//                        context, 6, prov2.index_strike, 0, 'legal', null, null)
//                    : prov3.out(
//                        context, 6, prov3.index_strike, 0, 'legal', null, null);
              },
              child: Card(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15)),
                child: GridTile(
                  child: Center(
                      child: Text(
                    'Hit-wicket',
                    style: TextStyle(fontSize: 15),
                  )),
                ),
              ),
            ),
            GestureDetector(
              onTap: () {
                prov.add_balls(context);
                prov.avatars.add(Avatar(col_ava: Colors.red, con: 'W'));
                prov.start
                    ? prov2.out(
                        context, 7, prov2.index_strike, 0, 'legal', null, null)
                    : prov3.out(
                        context, 7, prov3.index_strike, 0, 'legal', null, null);
              },
              child: Card(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15)),
                child: GridTile(
                  child: Center(
                      child: Text(
                    'Hitted twice',
                    style: TextStyle(fontSize: 15),
                  )),
                ),
              ),
            ),
            GestureDetector(
              onTap: () {
                prov.start
                    ? prov2.out(
                        context, 8, prov2.index_nonstrike, 0, null, null, null)
                    : prov3.out(
                        context, 8, prov3.index_nonstrike, 0, null, null, null);
              },
              child: Card(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15)),
                child: GridTile(
                  child: Center(
                      child: Text(
                    'Manakaded',
                    style: TextStyle(fontSize: 15),
                  )),
                ),
              ),
            ),
            GestureDetector(
              onTap: () {
                Navigator.of(context).pushReplacement(MaterialPageRoute(
                  builder: (context) {
                    return Wicketdetails(9);
                  },
                ));
              },
              child: Card(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15)),
                child: GridTile(
                  child: Center(
                      child: Text(
                    'Obst. field',
                    style: TextStyle(fontSize: 15),
                  )),
                ),
              ),
            ),
            GestureDetector(
              onTap: () {
                Navigator.of(context).pushReplacement(MaterialPageRoute(
                  builder: (context) {
                    return Wicketdetails(10);
                  },
                ));
              },
              child: Card(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15)),
                child: GridTile(
                  child: Center(
                      child: Text(
                    'Retired',
                    style: TextStyle(fontSize: 15),
                  )),
                ),
              ),
            ),
            GestureDetector(
              onTap: () {
                prov.avatars.add(Avatar(col_ava: Colors.red, con: 'T.O'));
                prov.start
                    ? prov2.out(
                        context, 11, prov2.index_strike, 0, null, null, null)
                    : prov3.out(
                        context, 11, prov3.index_strike, 0, null, null, null);
              },
              child: Card(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15)),
                child: GridTile(
                  child: Center(
                      child: Text(
                    'Timed-out',
                    style: TextStyle(fontSize: 15),
                  )),
                ),
              ),
            ),
          ],
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            childAspectRatio: 4 / 5,
            crossAxisSpacing: 10,
            mainAxisSpacing: 20,
          ),
        ),
      ),
    );
  }

//  showAlertDialog(BuildContext context, int type) {
//    final prov = Provider.of<Content>(context);
//    final prov2 = Provider.of<Inn1>(context);
//    final prov3 = Provider.of<Inn2>(context);
//    // set up the button
//    Widget okButton = FlatButton(
//      child: Text("OK"),
//      onPressed: () {
//        if (type == 2) {
//          if (prov.start) {
//            prov2.out(context, type, prov2.index_strike, 0, 'legal');
//          } else {
//            prov3.out(context, type, prov3.index_strike, 0, 'legal');
//          }
//        }
//        Provider.of<Content>(context).a = 'Fielder1';
//        Provider.of<Content>(context).b = 'Fielder2';
//      },
//    );
//
//    // set up the AlertDialog
//    AlertDialog alert = AlertDialog(
//      content: Wicketdetails(type),
//      actions: [
//        okButton,
//      ],
//    );
//
//    // show the dialog
//    showDialog(
//      context: context,
//      builder: (BuildContext context) {
//        return alert;
//      },
//    );
//  }
//}
//

}
