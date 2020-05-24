import 'package:flutter/material.dart';
import 'package:harsh/screens/innings1.dart';
import '../providers/contents.dart';
import '../providers/inn2.dart';
import '../providers/inn1.dart';
import 'package:provider/provider.dart';
import 'break.dart';
import 'innings2.dart';

class ChangeBowler extends StatelessWidget {
  static const routeName = '/change_bowl';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Over complete!'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: ListView.builder(
            itemCount: Provider.of<Content>(context).no_of_players,
            itemBuilder: (context, i) => Column(
                  children: <Widget>[
                    Card(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15)),
                      child: ListTile(
                        title: Provider.of<Content>(context).start
                            ? Text(Provider.of<Inn1>(context).bowl[i].name)
                            : Text(Provider.of<Inn2>(context).bowl[i].name),
                        onTap: () {
                          if (Provider.of<Content>(context).start) {
                            if (i == Provider.of<Inn1>(context).index_bowler) {
                              showAlertDialog(context);
                            } else {
                              Provider.of<Inn1>(context)
                                  .bowl[Provider.of<Inn1>(context).index_bowler]
                                  .overs++;
                              Provider.of<Inn1>(context).index_bowler = i;
                              Provider.of<Content>(context).avatars = [];
                              Provider.of<Inn1>(context).change_strike();
                              Navigator.of(context)
                                  .pushReplacementNamed(Innings1.routeName);
                            }
                          } else {
                            if (i == Provider.of<Inn2>(context).index_bowler) {
                              showAlertDialog(context);
                            } else {
                              Provider.of<Inn2>(context)
                                  .bowl[Provider.of<Inn2>(context).index_bowler]
                                  .overs++;

                              Provider.of<Inn2>(context).index_bowler = i;
                              Provider.of<Content>(context).avatars = [];
                              Provider.of<Inn2>(context).change_strike();
                              Navigator.of(context)
                                  .pushReplacementNamed(Innings2.routeName);
                            }
                          }
                        },
                      ),
                    ),
                  ],
                )),
      ),
    );
  }

  showAlertDialog(context) {
    Widget continueButton = FlatButton(
      color: Colors.blue,
      child: Text("OK"),
      onPressed: () {
        Navigator.of(context).pop();
      },
    );
    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      content: Text(
        'Previous bowler can\'t bowl',
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
}
