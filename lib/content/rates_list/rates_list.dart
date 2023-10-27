import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:loading_animation_widget/loading_animation_widget.dart';

import './rates_item.dart';
import './exchange_data.dart';
import '../../utils/theme.consts.dart';

String privatBaseUrl = 'https://api.privatbank.ua/p24api/exchange_rates?json&date=';


class RatesList extends StatefulWidget {
  const RatesList({super.key});

  @override
  State<StatefulWidget> createState() => RatesListState();
}

class RatesListState extends State<RatesList> {

  late Future<ExchangeData> ratesInfo;

  Future<ExchangeData> getRatesInfo() async {
    DateTime now = DateTime.now();
    final response = await http.get(Uri.parse('$privatBaseUrl${now.day}.${now.month}.${now.year}'));
    if (response.statusCode == 200) {
      var body = jsonDecode(response.body);
      return ExchangeData.fromJson(body);
    } else {
      throw Exception('Failed to load rates');
    }

  }

  @override
  void initState() {
    ratesInfo = getRatesInfo();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var maxHeight = MediaQuery.of(context).size.height - footerHeight - 15;
    return  Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Container(
          constraints: BoxConstraints(minHeight: 300, maxHeight: maxHeight),
          child: Padding(
            padding: const EdgeInsets.all(15),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                FutureBuilder<ExchangeData>(
                  future: ratesInfo,
                  builder: (BuildContext context, AsyncSnapshot<ExchangeData> snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return 
                        LoadingAnimationWidget.staggeredDotsWave(color: const Color.fromARGB(164, 96, 125, 139), size: 50);
                    }
                    if (snapshot.hasData) {
                      return ExchangeContent(items: snapshot.data!.items, baseCurrency: snapshot.data!.baseCurrencyLit, maxHeight: maxHeight);
                    } else {     
                      return 
                        SizedBox(
                          width: 150,
                          height: 50,
                          child: ElevatedButton.icon(
                              icon: Icon(Icons.heart_broken), 
                              label: Text('Try again'), 
                              onPressed: () async {
                                var nonFutureData = await getRatesInfo();
                                setState(() {
                                  ratesInfo = Future.value(nonFutureData);
                                });
                              },
                            ),
                        );
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class ExchangeContent extends StatelessWidget {
  final List<RatesItem> items;
  final String? baseCurrency; 
  final double? maxHeight;

  const ExchangeContent({
    super.key,
    required this.items,
    required this.baseCurrency,
    required this.maxHeight
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Flexible(child: Text('Base currency: $baseCurrency', style: TextStyle(fontSize: 18),)),
        Padding(padding: EdgeInsets.all(15)),
        SizedBox(
          height: (maxHeight ?? 150) - 150,
          child: ListView.builder(
            scrollDirection: Axis.vertical,
            shrinkWrap: true,
            itemCount: items.length, 
            itemBuilder: (context, index) => RateItem(itemData: items[index])
          ),
        )
      ],
    );
  }
}

