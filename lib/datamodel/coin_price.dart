class CoinPrice {
  final String symbol;
  final double price;

  CoinPrice({this.symbol, this.price});

  factory CoinPrice.fromJson(Map<String, dynamic> json) {
    return CoinPrice(
        symbol: json['symbol'],
        price: double.parse(json['price'])
    );
  }
}