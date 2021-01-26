class PortfolioCoin {
  final double initialPrice;
  final double initialCost;
  final double coinAmount;
  final String coinAbr;

  PortfolioCoin({this.initialPrice, this.initialCost, this.coinAmount, this.coinAbr});

  factory PortfolioCoin.fromJson(Map<String, dynamic> json) {
    return PortfolioCoin(
        initialPrice: json['initialPrice'],
        initialCost: json['initialCost'],
        coinAmount: json['coinAmount'],
        coinAbr: json['coinAbr']
    );
  }
}