

import 'package:flutter/material.dart';


 defaultAppBar({
  required Function() onPress,
  required IconData icon,
   required Color iconColor,
   required Color appBarColor,
   required String title,
   required Color titleColor
}) => AppBar(
   elevation: 0.0,
  backgroundColor: appBarColor,
  leading: IconButton(
    onPressed: onPress,
    icon: Icon(
      icon,
      color: iconColor,
    ),
  ),
   title: Text(
     title,
     style: TextStyle(
       color: titleColor,
       fontSize: 24.0,
       fontWeight: FontWeight.bold,
     ),
   ),
   centerTitle: true,
);