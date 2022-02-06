
import 'package:flutter/material.dart';

abstract class ViewPageInterface 
{
    String get title;
    BottomNavigationBarItem get button;
    List<Widget> get actions;
}