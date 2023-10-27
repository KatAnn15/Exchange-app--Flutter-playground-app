import 'package:flutter/material.dart';
import 'package:namer_app/content/rates_list/exchange_data.dart';

class RateItem extends StatelessWidget {
  final RatesItem itemData;
  const RateItem({super.key, required this.itemData});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      child: Padding(
        padding: EdgeInsets.fromLTRB(15, 10, 10, 10),
        child: Column(
          children: [
            Text(itemData.currency),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                BankRateWidget(purchaseRate: itemData.purchaseRateNB, saleRate: itemData.saleRateNB),
                if (itemData.purchaseRate != null && itemData.saleRate != null) 
                  Stack(
                    clipBehavior: Clip.none,
                    children: [
                    BankRateWidget(purchaseRate: itemData.purchaseRate!, saleRate: itemData.saleRate!),
                      Positioned(
                        top: -15,
                        right: -10,
                        child: RateLabel()
                      ),
                    ]
                  )
                ],),
          ],
        )
      ),
    );
  }
}

class BankRateWidget extends StatelessWidget {
  final double saleRate;
  final double purchaseRate;

  const BankRateWidget({
    super.key,
    required this.purchaseRate, 
    required this.saleRate,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints(minWidth: 170, minHeight: 60),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(10.0)),
        color: Theme.of(context).scaffoldBackgroundColor,
        boxShadow: [BoxShadow(
          color: Theme.of(context).hintColor, 
          offset: Offset(0,1), 
          blurRadius: 2.0, 
          spreadRadius: 0.0, 
          blurStyle: BlurStyle.outer
        )]
      ),
      padding: const EdgeInsets.all(10),
      child: 
        Positioned(child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text('Buy for: ${purchaseRate.toString()}'),
            Text('Sell for: ${saleRate.toString()}'),
          ],))
    );
  }
}

class RateLabel extends StatelessWidget {
  const RateLabel({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Positioned(
      right: -10.0,
      top: -20.0,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(5)),
          color: Theme.of(context).badgeTheme.backgroundColor,
        ),
        padding: EdgeInsets.fromLTRB(10,2,5,2),
        child: Text('Privat rate')
      )
    );
  }
}

