import 'package:flutter/foundation.dart';

import 'package:portfolio_litium/app/locator.dart';
import 'package:portfolio_litium/datamodel/coin_price.dart';
import 'package:portfolio_litium/datamodel/portfolio_coin.dart';
import 'package:portfolio_litium/services/price/portfolio_service.dart';

class PortfolioViewModel extends ChangeNotifier {
  final PortfolioService _portfolioService = locator<PortfolioService>();

  List<PortfolioCoin> _coins = [];
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

    for (var element in _coins ) {
      for(var price in prices ){
        if(price.symbol == '${element.coinAbr}USDT'){
          loops= loops + 1;
          element.currentPrice = price.price;
          element.totalValue = price.price*element.coinAmount;
          element.gainsPercentage = (1 - (element.initialPrice/price.price))*100;
          break;
        }
      }
    }
  }

  void setBusy(bool busy) async {
    _isBusy = busy;
  }

  void deleteCoin(PortfolioCoin coin) async {
    _portfolioService.deletePortfolio(coin);
  }

}