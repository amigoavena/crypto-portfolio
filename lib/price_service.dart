import 'package:injectable/injectable.dart';
import 'locator.dart';
import 'coin_price.dart';

import 'api.dart';

@lazySingleton
  class PriceService {
  final _api = locator<Api>();

  CoinPrice _posts;
  CoinPrice get posts => _posts;

  bool get hasPosts => _posts != null;

  Future<CoinPrice> getCoinPrice(String coinPair) async {
    print('sums: $coinPair');
    _posts = await _api.getCoinPrice(coinPair);
    return _posts;
  }
}