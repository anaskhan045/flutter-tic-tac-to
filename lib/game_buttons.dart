import 'package:flutter/material.dart';

class GameButton {
  final id;
  String text;
  bool enabled;
  Color bc;
  GameButton({this.id,this.text="",this.enabled=true,this.bc=Colors.grey});
}