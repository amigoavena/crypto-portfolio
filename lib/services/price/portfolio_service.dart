import 'package:portfolio_litium/datamodel/coin_price.dart';
import 'package:portfolio_litium/datamodel/portfolio_coin.dart';

abstract class PortfolioService {

  Future<List<PortfolioCoin>> getPortfolio();

  Future<void> savePortfolio(List<PortfolioCoin> data);

  Future<CoinPrice> getCoinPrice(String coinPair);

}