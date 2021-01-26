import 'package:portfolio_litium/datamodel/portfolio_coin.dart';

abstract class StorageService {

  Future<List<PortfolioCoin>> getPortfolioData();

  Future savePortFolio(List<PortfolioCoin> data);

  Future<bool> isExpiredCache();
}