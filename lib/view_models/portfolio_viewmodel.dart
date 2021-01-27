import 'package:flutter/foundation.dart';

import 'package:portfolio_litium/app/locator.dart';
import 'package:portfolio_litium/datamodel/coin_price.dart';
import 'package:portfolio_litium/datamodel/portfolio_coin.dart';
import 'package:portfolio_litium/services/price/portfolio_service.dart';

class PortfolioViewModel extends ChangeNotifier {
  final PortfolioService _portfolioService = locator<PortfolioService>();

  PortfolioCoin _baseCoin = defaultBaseCoin;
  List<PortfolioCoin> _coins = [];

  static final PortfolioCoin defaultBaseCoin = PortfolioCoin(
      coinAbr: '',
      initialPrice: 0,
      coinAmount: 0,
      initialCost: 0
  );

  void loadData() async {
    _coins = await _portfolioService.getPortfolio();
    notifyListeners();
  }

  List<PortfolioCoin> get coins {
    return _coins;
  }

  PortfolioCoin get baseCoin {
    return _baseCoin;
  }

  void calculateGains() async {
    List<PortfolioCoin> withGains = [];
    await Future.forEach(_coins, (element) async {
      CoinPrice price = await _portfolioService.getCoinPrice("${element.coinAbr}USDT");
      element.gainsPercentage = price.price;
      withGains.add(element);
    });
  }

  void calculateExchange(String baseAmount) async {
    double amount;
    try {
      amount = double.parse(baseAmount);
    } catch (e) {
      _updateCurrenciesFor(0);
      notifyListeners();
      return null;
    }

    _updateCurrenciesFor(amount);

    notifyListeners();
  }

  void _updateCurrenciesFor(double baseAmount) {

  }

  Future setNewBaseCurrency(int quoteCurrencyIndex) async {
    _coins.add(_baseCoin);
    _baseCoin = _coins[quoteCurrencyIndex];
    _coins.removeAt(quoteCurrencyIndex);
    await _portfolioService.savePortfolio(_coins);
    loadData();
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