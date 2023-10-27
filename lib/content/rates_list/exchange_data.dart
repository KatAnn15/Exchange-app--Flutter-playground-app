class ExchangeData {
  final String baseCurrencyLit;
  final List<RatesItem> items;
  final String date;
  
  const ExchangeData({required this.baseCurrencyLit, required this.items, required this.date});

  static const prioritiesList = ['USD', 'EUR', 'GBP'];

  factory ExchangeData.fromJson(Map<String, dynamic> json) {
    var items = json['exchangeRate'];
    items.sort((prev, next){
      var prevPos = prioritiesList.indexOf(prev['currency']);
      var nextPos = prioritiesList.indexOf(next['currency']);

      if (prevPos >= 0 && nextPos >= 0) {
        return prevPos - nextPos;
      }

      if (prevPos >= 0) {
        return -1;
      }

      if (nextPos >= 0) {
        return 1;
      }

      return prev['saleRate'] != null && prev['purchaseRate'] != null ? -1 : 1;
    });

    return ExchangeData(
      baseCurrencyLit: json['baseCurrencyLit'],
      items: items.map<RatesItem>((item) {
        return RatesItem(
          baseCurrency: item['baseCurrency'],
          currency: item['currency'],
          saleRateNB: item['saleRateNB'],
          purchaseRateNB: item['purchaseRateNB'],
          saleRate: item['saleRate'],
          purchaseRate: item['purchaseRate']
        );
      }).toList(),
      date: json['date'],
    );
  }
}

class RatesItem {
  final String baseCurrency;
  final String currency;
  final double saleRateNB;
  final double purchaseRateNB;
  final double? saleRate;
  final double? purchaseRate;

  const RatesItem({
    required this.baseCurrency, 
    required this.currency, 
    required this.purchaseRateNB, 
    required this.saleRateNB,
    this.purchaseRate, 
    this.saleRate
  });

  factory RatesItem.fromJson(Map<String, dynamic> json) {
    return RatesItem(
      baseCurrency: json['baseCurrency'], 
      currency: json['currency'], 
      purchaseRateNB: json['purchaseRateNB'], 
      saleRateNB: json['saleRateNB'],
      purchaseRate: json['purchaseRate'], 
      saleRate: json['saleRate']
    );
  }
}