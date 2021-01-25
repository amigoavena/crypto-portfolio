import 'api.dart';
import 'coin_price.dart';
import 'locator.dart';
import 'price_service.dart';
import 'package:stacked/stacked.dart';

class CoinPriceViewModel extends FutureViewModel<CoinPrice> {
  final _postsService = locator<PriceService>();

  @override
  Future<CoinPrice> futureToRun() {
    print('Fetch posts');
    return _postsService.getCoinPrice('XRPUSDT');
  }
}