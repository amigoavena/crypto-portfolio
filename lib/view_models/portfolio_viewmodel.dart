import 'package:flutter/foundation.dart';

import 'package:portfolio_litium/app/locator.dart';
import 'package:portfolio_litium/datamodel/coin_price.dart';
import 'package:portfolio_litium/datamodel/portfolio_coin.dart';
import 'package:portfolio_litium/services/price/portfolio_service.dart';

class PortfolioViewModel extends ChangeNotifier {
  final PortfolioService _portfolioService = locator<PortfolioService>();

  List<PortfolioCoin> _coins = [];
  double _totalSum = 0;

  double get totalSum => _totalSum;
  double _totalInvestment = 0;
  double _overalGains = 0;
  double _totalDelta = 0;

  double get totalDelta => _totalDelta;
  bool _isBusy = false;

  void loadData() async {
    _coins = await _portfolioService.getPortfolio();
    notifyListeners();
  }

  List<PortfolioCoin> get coins {
    return _coins;
  }

  bool get isBusy {
    return _isBusy;
  }

  void calculateGains() async {
    List<CoinPrice> prices = await _portfolioService.getCoinPrices();
    int loops = 0;
    _totalSum = 0;
    _totalInvestment = 0;
    _overalGains = 0;

    for (var element in _coins ) {
      for(var price in prices ){
        if(price.symbol == '${element.coinAbr}USDT'){
          loops= loops + 1;
          element.currentPrice = price.price;
          element.totalValue = price.price*element.coinAmount;
          element.gainsPercentage = (1 - (element.initialPrice/price.price))*100;
          _totalSum = _totalSum + element.totalValue;
          _totalInvestment = _totalInvestment + element.initialCost;
          break;
        }
      }
    }
    _overalGains = (1 - (_totalInvestment/_totalSum))*100;
    _totalDelta = _totalSum - _totalInvestment;
  }

  void setBusy(bool busy) async {
    _isBusy = busy;
  }

  void deleteCoin(PortfolioCoin coin) async {
    _portfolioService.deletePortfolio(coin);
  }

  double get totalInvestment => _totalInvestment;

  double get overalGains => _overalGains;
}