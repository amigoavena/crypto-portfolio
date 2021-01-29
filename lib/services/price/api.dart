import 'dart:convert';
import 'package:injectable/injectable.dart';
import 'package:http/http.dart' as http;
import '../../datamodel/coin_price.dart';

/// The service responsible for networking requests
@lazySingleton
class Api {
  static const endpoint = 'https://api.binance.com/api/v3/ticker/price';

  var client = new http.Client();

  Future<List<CoinPrice>> getCoinPrices() async {
    var response = await client.get('$endpoint');
    return parsePosts(response.body);
  }

  List<CoinPrice> parsePosts(String responseBody) {
    final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();
    return parsed.map<CoinPrice>((json) => CoinPrice.fromJson(json)).toList();
  }

}