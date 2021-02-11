import 'dart:async';

import 'package:portfolio_litium/app/locator.dart';
import 'package:portfolio_litium/datamodel/portfolio_coin.dart';
import 'package:portfolio_litium/view_models/portfolio_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:portfolio_litium/views/add_coin_screen.dart';
import 'package:provider/provider.dart';

class PortfolioScreen extends StatefulWidget {

  @override
  _PortfolioScreenScreenState createState() =>
      _PortfolioScreenScreenState();
}

class _PortfolioScreenScreenState extends State<PortfolioScreen> {

  PortfolioViewModel model = locator<PortfolioViewModel>();

  Timer timer;

  @override
  void initState() {
    model.loadData();
    super.initState();
  }

  Future<void> _getData() async {
    setState(() {
      if(!model.isBusy) {
        model.setBusy(true);
        model.calculateGains();
        model.setBusy(false);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<PortfolioViewModel>(
      create: (context) => model,
      child: Consumer<PortfolioViewModel>(
        builder: (context, model, child) => Scaffold(
          appBar: AppBar(
            title: Text('Portfolio Cryptos'),
            actions: <Widget>[
              IconButton(
                icon: Icon(Icons.add),
                onPressed: () async {
                  await Navigator.push( context,
                    MaterialPageRoute(builder: (context) => AddCoinScreen()),
                  );
                },
              )
            ],
          ),
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              model.isBusy?CircularProgressIndicator():SizedBox.shrink(),
              quoteCurrencyList(model),
            ],
          ),
        ),
      ),
    );
  }

  Widget quoteCurrencyList(PortfolioViewModel model) {
    return  model.coins.length != 0 ?
    Expanded(
      child: RefreshIndicator( // Scroll???
          child: ListView.builder(
            scrollDirection: Axis.vertical,
            shrinkWrap: false,
            physics: const AlwaysScrollableScrollPhysics(), // new
            itemCount: model.coins.length,
            itemBuilder: (context, index) {
              return Card(
                  child: InkWell(
                      onTap: (){
                        showAlertDialog(context,model.coins[index]);
                      },
                      child: Padding(
                          padding: const EdgeInsets.only(left: 7, top: 6, right: 10),
                          child: Column(
                              children: <Widget>[
                                Row(
                                  children: [
                                    SizedBox(
                                      width: 100,
                                      child: Text(
                                        '${model.coins[index].coinAbr}',
                                        style: TextStyle(fontSize: 30),
                                      ),
                                    ),
                                    Spacer(),
                                    Text( model.coins[index].gainsPercentage != null ? ' ${model.coins[index].gainsPercentage.toStringAsFixed(2)} % ': 'N/A',
                                        style: TextStyle(fontSize: 30, color: Colors.blueGrey , backgroundColor: model.coins[index].gainsPercentage != null && model.coins[index].gainsPercentage < 0 ? Colors.red : Colors.greenAccent)),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(top: 5),
                                      child: Align(
                                        alignment: Alignment.centerLeft,
                                        child: Column(
                                          children: [
                                            model.coins[index].currentPrice != null ? Text('=${model.coins[index].currentPrice}'): Text('N/A'),
                                            Text('=${model.coins[index].initialPrice}',style: TextStyle(color: Colors.deepOrangeAccent, ))
                                          ],
                                        ),
                                      ),
                                    ),
                                    Spacer(),
                                    Padding(
                                      padding: const EdgeInsets.only(left: 10, top: 5),
                                      child: Text('${model.coins[index].coinAmount.toStringAsFixed(3)}',
                                          style: TextStyle(
                                              color: Colors.deepPurpleAccent
                                          )
                                      ),
                                    ),
                                    Spacer(),
                                    Padding(
                                        padding: const EdgeInsets.only(left: 10, top: 5),
                                        child: Column(
                                          children: [
                                            model.coins[index].totalValue != null ? Text('\$${model.coins[index].totalValue.toStringAsFixed(3)}'): Text('N/A'),
                                            IconButton(
                                                icon: new Icon(Icons.delete),
                                                onPressed: (){
                                                  print("deleted!- ${index}");
                                                  model.deleteCoin(model.coins[index]);
                                                  model.loadData();
                                                }
                                            )
                                          ],
                                        )
                                    )
                                  ],
                                )
                              ]
                          )
                      )
                  )
              );
            },
          ),
          onRefresh: _getData
      )
    ): Center(
        child: Padding(
            padding: const EdgeInsets.only(top: 16),
            child: Text("Please add Coins",
              style: TextStyle(fontSize: 30)
            )
        )
    );
  }

  showAlertDialog(BuildContext context, PortfolioCoin coin) {
    // set up the button
    Widget okButton = FlatButton(
      child: Text("OK"),
      onPressed: () {
        Navigator.pop(context);
      },
    );
    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("Resumen:"),
      content: Container(
        height: 120.0,
        child:
          Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 7, top: 6, right: 10),
                child: Row(
                  children: [
                    Text('Current Gains (USD): '),
                    Spacer(),
                    coin.currentPrice != null ? calculateGains(coin): Text('N/A')
                  ],
                )
              ),
              Padding(
                  padding: const EdgeInsets.only(left: 7, top: 6, right: 10),
                  child: Row(
                    children: [
                      Text('5% Position: '),
                      Spacer(),
                      Text('${(coin.initialPrice*1.05).toStringAsFixed(4)}')
                    ],
                  )
              ),
              Padding(
                  padding: const EdgeInsets.only(left: 7, top: 6, right: 10),
                  child: Row(
                    children: [
                      Text('10% Position: '),
                      Spacer(),
                      Text('${(coin.initialPrice*1.10).toStringAsFixed(4)}')
                    ],
                  )
              ),
              Padding(
                  padding: const EdgeInsets.only(left: 7, top: 6, right: 10),
                  child: Row(
                    children: [
                      Text('15% Position: '),
                      Spacer(),
                      Text('${(coin.initialPrice*1.15).toStringAsFixed(4)}')
                    ],
                  )
              )
            ],
          ),
      ),
      actions: [
        okButton,
      ],
    );
    // show the dialog
      showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  calculateGains(PortfolioCoin coin){
    double gains = (coin.currentPrice * coin.coinAmount)-coin.initialCost;
    MaterialAccentColor color = Colors.redAccent;
    String symbol = '-';
    if (gains > 0) {
      color = Colors.greenAccent;
      symbol = '+';
    }
    return Text('${symbol} \$${gains.toStringAsFixed(2)}',style: TextStyle( color: Colors.blueGrey, backgroundColor: color));
  }
}