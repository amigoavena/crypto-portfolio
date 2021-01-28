import 'package:flutter/foundation.dart';

import 'package:portfolio_litium/app/locator.dart';
import 'package:portfolio_litium/datamodel/coin_price.dart';
import 'package:portfolio_litium/datamodel/portfolio_coin.dart';
import 'package:portfolio_litium/services/price/portfolio_service.dart';

class PortfolioViewModel extends ChangeNotifier {
  final PortfolioService _portfolioService = locator<PortfolioService>();

  List<PortfolioCoin> _coins = [];

  void loadData() async {
    _coins = await _portfolioService.getPortfolio();
    notifyListeners();
  }

  List<PortfolioCoin> get coins {
    return _coins;
  }

  void calculateGains() async {
    List<PortfolioCoin> withGains = [];
    //await Future.forEach(_coins, (<Portelement) async {
      for (var element in _coins ) {
      CoinPrice price = await _portfolioService.getCoinPrice("${element.coinAbr}USDT");
      element.currentPrice = price.price;
      element.totalValue = price.price*element.coinAmount;
      element.gainsPercentage = (1 - (element.initialPrice/price.price))*100;
      withGains.add(element);
    }//);
  }

}

// A model class specifically for displaying data in a view. Everything is a
// preformatted string.
class CoinPresentation {
  final String coinAbrv;
  final String alphabeticCode;
  final String longName;
  String amount;

  CoinPresentation({
    this.coinAbrv,
    this.alphabeticCode,
    this.longName,
    this.amount,
  });
}