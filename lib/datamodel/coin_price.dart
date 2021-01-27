class CoinPrice {
  final String min;
  final double price;

  CoinPrice({this.min, this.price});

  factory CoinPrice.fromJson(Map<String, dynamic> json) {
    return CoinPrice(
        min: json['min'],
        price: double.parse(json['price'])
    );
  }
}