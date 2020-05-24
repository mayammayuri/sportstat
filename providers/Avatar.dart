import 'package:flutter/material.dart';

class Avatar with ChangeNotifier {
  final String con;
  final Color col_ava;
  Avatar({
    @required this.col_ava,
    @required this.con,
  });
}
