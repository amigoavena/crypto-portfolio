// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';
import 'package:portfolio_litium/services/price/portfolio_impl.dart';
import 'package:portfolio_litium/services/price/portfolio_service.dart';
import 'package:portfolio_litium/services/user_service.dart';
import 'package:portfolio_litium/view_models/add_coin_viewmodel.dart';
import 'package:portfolio_litium/view_models/portfolio_viewmodel.dart';

import '../services/price/api.dart';

/// adds generated dependencies
/// to the provided [GetIt] instance

GetIt $initGetIt(
    GetIt get, {
      String environment,
      EnvironmentFilter environmentFilter,
    }) {
  final gh = GetItHelper(get, environment, environmentFilter);
  gh.lazySingleton<Api>(() => Api());
  gh.lazySingleton<UserService>(() => UserService());
  //gh.singleton<StorageService>(() => StorageServiceDB);
  gh.lazySingleton<PortfolioService>(() => PortfolioServiceImpl());
  gh.singleton<PortfolioViewModel>(PortfolioViewModel());
  gh.singleton<AddCoinViewModel>(AddCoinViewModel());
  return get;
}
