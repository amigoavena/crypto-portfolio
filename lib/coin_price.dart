class CoinPrice {
  final int min;
  final double price;

  CoinPrice({this.min, this.price});

  factory CoinPrice.fromJson(Map<String, dynamic> json) {
    return CoinPrice(
        min: json['min'],
        price: json['price']
    );
  }
}