import 'package:flutter/cupertino.dart';
import '../utils/theme.consts.dart';

class Footer extends StatelessWidget {
  const Footer({
    super.key,
    required this.gradient,
  });

  final LinearGradient gradient;

  @override
  Widget build(BuildContext context) {
    
    return Container(
      height: footerHeight,
      width: MediaQuery.of(context).size.width,
      padding: EdgeInsets.all(15),
      decoration: BoxDecoration(gradient: gradient),
      child: Text('By Kat'),
    );
  }
}