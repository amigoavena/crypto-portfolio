import 'package:portfolio_litium/datamodel/coin_price.dart';
import 'package:portfolio_litium/datamodel/portfolio_coin.dart';

abstract class PortfolioService {

  Future<List<PortfolioCoin>> getPortfolio();

  Future<void> savePortfolio(PortfolioCoin data);

  Future<List<CoinPrice>> getCoinPrices();

  Future<void> deletePortfolio(PortfolioCoin coin);

}