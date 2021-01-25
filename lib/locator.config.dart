// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';
import 'package:portfolio_litium/price_service.dart';
import 'coin_viewmodel.dart';

import 'api.dart';

/// adds generated dependencies
/// to the provided [GetIt] instance

GetIt $initGetIt(
    GetIt get, {
      String environment,
      EnvironmentFilter environmentFilter,
    }) {
  final gh = GetItHelper(get, environment, environmentFilter);
  gh.lazySingleton<Api>(() => Api());
  gh.lazySingleton<PriceService>(() => PriceService());
  gh.singleton<CoinPriceViewModel>(CoinPriceViewModel());
  return get;
}
