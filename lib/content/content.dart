import 'package:flutter/cupertino.dart';

import './rates_list/rates_list.dart';
import '../utils/theme.consts.dart';

class Content extends StatelessWidget {
  const Content({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              constraints: BoxConstraints(minHeight: MediaQuery.of(context).size.height - headerHeight - footerHeight),
              padding: EdgeInsets.all(15),
              child: RatesList(),
            ),
          ],
        ),
      )
    );
  }
}