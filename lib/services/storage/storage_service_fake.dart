/*
 * Copyright (c) 2020 Razeware LLC
 *
 * Permission is hereby granted, free of charge, to any person obtaining a copy
 * of this software and associated documentation files (the "Software"), to deal
 * in the Software without restriction, including without limitation the rights
 * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 * copies of the Software, and to permit persons to whom the Software is
 * furnished to do so, subject to the following conditions:
 *
 * The above copyright notice and this permission notice shall be included in
 * all copies or substantial portions of the Software.
 *
 * Notwithstanding the foregoing, you may not use, copy, modify, merge, publish,
 * distribute, sublicense, create a derivative work, and/or sell copies of the
 * Software in any work that is designed, intended, or marketed for pedagogical or
 * instructional purposes related to programming, coding, application development,
 * or information technology.  Permission for such use, copying, modification,
 * merger, publication, distribution, sublicensing, creation of derivative works,
 * or sale is expressly withheld.
 *
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 * AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
 * THE SOFTWARE.
 */

import 'dart:convert';
import 'package:portfolio_litium/datamodel/portfolio_coin.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'storage_service.dart';

// This class is the concrete implementation of [StorageService]. Internally
// it uses shared preferences to save and retrieve data, but that is an
// implementation detail that no other class in the app knows about. Swapping
// out shared preferences with a SQL database would be as simple as creating
// a new [StorageService] implementation.
class StorageServiceFake implements StorageService {

  static const sharedPrefExchangeRateKey1 = 'exchange_rate_key';
  static const sharedPrefPortfolioKey = 'currency_key';
  static const sharedPrefLastCacheTimeKey = 'cache_time_key';

  @override
  Future<List<PortfolioCoin>> getPortfolioData() async {
    List<PortfolioCoin> list = [];
    list.add(PortfolioCoin(
      coinAbr: 'SC',
      initialCost: 1071.57,
      initialPrice:  0.0048,
      coinAmount:  223020.506250,
    ));
    list.add(PortfolioCoin(
      coinAbr: 'RSR',
      initialCost: 989.46,
      initialPrice:  0.0383,
      coinAmount:  25855,
    ));
    return list;
  }

  @override
  Future<void> savePortFolio(List<PortfolioCoin> data) {
    return null;
  }

  @override
  Future<bool> isExpiredCache() async {
    return false;
  }

}
