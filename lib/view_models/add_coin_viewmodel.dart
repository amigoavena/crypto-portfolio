import 'package:flutter/foundation.dart';

import 'package:portfolio_litium/app/locator.dart';
import 'package:portfolio_litium/datamodel/coin_price.dart';
import 'package:portfolio_litium/datamodel/portfolio_coin.dart';
import 'package:portfolio_litium/services/price/portfolio_service.dart';

class AddCoinViewModel extends ChangeNotifier {

  final PortfolioService _portfolioService = locator<PortfolioService>();

  void loadData() async {
    //_coins = await _portfolioService.getPortfolio();
    notifyListeners();
  }

  void addCoin(PortfolioCoin coin) async {
    _portfolioService.savePortfolio(coin);
  }

}