import 'dart:convert';
import 'package:injectable/injectable.dart';
import 'package:http/http.dart' as http;
import '../../datamodel/coin_price.dart';

/// The service responsible for networking requests
@lazySingleton
class Api {
  static const endpoint = 'https://api.binance.com11/api/v3/avgPrice';

  var client = new http.Client();

  Future<CoinPrice> getCoinPrice(String coinPair) async {
    var response = await client.get('$endpoint?symbol=$coinPair');
    return CoinPrice.fromJson(json.decode(response.body));
  }

}