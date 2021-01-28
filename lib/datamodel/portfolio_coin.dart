class PortfolioCoin {
  final double initialPrice;
  final double initialCost;
  final double coinAmount;
  final String coinAbr;
  double gainsPercentage;
  double currentPrice;
  double totalValue;

  PortfolioCoin({this.initialPrice, this.initialCost, this.coinAmount, this.coinAbr});

  static final columns = ["coinAbr", "initialPrice", "initialCost", "coinAmount"];

  factory PortfolioCoin.fromJson(Map<String, dynamic> json) {
    return PortfolioCoin(
        initialPrice: json['initialPrice'],
        initialCost: json['initialCost'],
        coinAmount: json['coinAmount'],
        coinAbr: json['coinAbr']
    );
  }

  factory PortfolioCoin.fromMap(Map<String, dynamic> data) {
    return PortfolioCoin(
        initialPrice: data['initialPrice'],
        initialCost: data['initialCost'],
        coinAmount: data['coinAmount'],
        coinAbr: data['coinAbr']
    );
  }

  Map<String, dynamic> toMap() => {
    'initialPrice': initialPrice,
    'initialCost': initialCost,
    'coinAmount': coinAmount,
    'coinAbr': coinAbr
  };

  Map toJson() => {
    'initialPrice': initialPrice,
    'initialCost': initialCost,
    'coinAmount': coinAmount,
    'coinAbr': coinAbr
  };
}