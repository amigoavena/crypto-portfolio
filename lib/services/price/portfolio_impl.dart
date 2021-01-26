import 'package:portfolio_litium/app/locator.dart';
import 'package:portfolio_litium/datamodel/coin_price.dart';
import 'package:portfolio_litium/datamodel/portfolio_coin.dart';
import 'package:portfolio_litium/services/price/api.dart';
import 'package:portfolio_litium/services/storage/storage_service.dart';
import 'portfolio_service.dart';

class PortfolioServiceImpl implements PortfolioService {

  static final defaultFavorites = [PortfolioCoin(
    coinAbr: 'SC',
    initialCost: 1071.57,
    initialPrice:  0.0048,
    coinAmount:  223020.506250,
  ),PortfolioCoin(
    coinAbr: 'RSR',
    initialCost: 989.46,
    initialPrice:  0.0383,
    coinAmount:  25855,
  )];

  Api _api = locator<Api>();
  StorageService _storageService = locator<StorageService>();

  @override
  Future<List<PortfolioCoin>> getPortfolio() async {
    final favorites = await _storageService.getPortfolioData();
    if (favorites == null || favorites.length <= 1) {
      return defaultFavorites;
    }
    return favorites;
  }

  @override
  Future<void> savePortfolio(List<PortfolioCoin> data) async {
    if (data == null || data.length == 0)
      return;
    await _storageService.savePortFolio(data);
  }

  @override
  Future<CoinPrice> getCoinPrice(String coinPair) async {
    CoinPrice price = await _api.getCoinPrice(coinPair);
    return price;
  }
  
}