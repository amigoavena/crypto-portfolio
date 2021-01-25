import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'locator.dart';
import 'coin_viewmodel.dart';

class CoinView extends StatelessWidget {
  const CoinView({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //return ViewModelBuilder<CoinPriceViewModel>.reactive();
    return ViewModelBuilder<CoinPriceViewModel>.reactive(
      builder: (context, model, child) => Scaffold(
        body: Center(
          child: Text('Start up view'),
        ),
      ),
      viewModelBuilder: () => CoinPriceViewModel(),
    );
  }
}

String roundForLabel(double val){
  return val.toString();
}