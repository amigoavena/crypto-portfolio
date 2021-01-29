import 'package:portfolio_litium/app/locator.dart';
import 'package:portfolio_litium/datamodel/coin_price.dart';
import 'package:portfolio_litium/datamodel/portfolio_coin.dart';
import 'package:portfolio_litium/services/price/api.dart';
import 'package:portfolio_litium/services/storage/storage_service_db.dart';
import 'portfolio_service.dart';

class PortfolioServiceImpl implements PortfolioService {

  static final defaultFavorites = [];

  Api _api = locator<Api>();

  @override
  Future<List<PortfolioCoin>> getPortfolio() async {
    final favorites = await StorageServiceDB.db.getPortfolioData();
    return favorites;
  }

  @override
  Future<void> savePortfolio(PortfolioCoin data) async {
    if (data == null)
      return;
    await StorageServiceDB.db.savePortfolio(data);
  }

  @override
  Future<List<CoinPrice>> getCoinPrices() async {
    List<CoinPrice> prices = await _api.getCoinPrices();
    return prices;
  }

  @override
  Future<void> deletePortfolio(PortfolioCoin coin) async {
    if (coin == null)
      return;
    await StorageServiceDB.db.deletePortfolio(coin);
  }
  
}