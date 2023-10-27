import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../utils/theme.consts.dart';
import '../main.dart';

class Header extends StatefulWidget {
  const Header({
    super.key,
    required this.gradient,
  });

  final LinearGradient gradient;

  @override
   State<StatefulWidget> createState() => HeaderState();
}

class HeaderState extends State<Header> {
  bool isDark = false;

  void switchTheme(bool isChecked) {
    ExchangeApp.of(context)?.setTheme(isChecked);
    setState(() => isDark = isChecked);
  }
  
  @override
  Widget build(BuildContext context) {
    return Container(
      height: headerHeight,
      padding: EdgeInsets.fromLTRB(15, 0, 20, 0),
      alignment: Alignment.center,
      decoration: BoxDecoration(gradient: widget.gradient),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Text('Dark mode'),
              Transform.scale(
                scale: 0.8,
                child:  CupertinoSwitch(
                  value: isDark, 
                  onChanged: (isChecked) => switchTheme(isChecked),
                  activeColor: Color.fromARGB(120, 61, 0, 48),
                )
              ),
            ],
          ),
          Container(
            padding: EdgeInsets.fromLTRB(10,5,10,5),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
              gradient: LinearGradient(colors: [Color.fromARGB(255, 10, 207, 115), Color.fromARGB(255, 12, 122, 27)]),
            ),
            child: Text('Currency Exchange', 
              style: TextStyle(
                color: Colors.white
                ),
              )
          )
        ]
      ),
    );
  }
}