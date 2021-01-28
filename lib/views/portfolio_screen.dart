import 'dart:async';

import 'package:portfolio_litium/app/locator.dart';
import 'package:portfolio_litium/view_models/portfolio_viewmodel.dart';
import 'package:flutter/material.dart';
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
    //const twentyMillis = const Duration(milliseconds:3000);
    //new Timer.periodic(twentyMillis, (Timer t) => setState((){
    //  print("hi!");
    //}));
  }

  Future<void> _getData() async {
    setState(() {
      model.calculateGains();
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
                onPressed: () async {},
              )
            ],
          ),
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              //baseCurrencyTitle(model),
              //baseCurrencyTextField(model), // TODO Align??
              quoteCurrencyList(model),
            ],
          ),
        ),
      ),
    );
  }

  Widget quoteCurrencyList(PortfolioViewModel model) {
    return  model.coins.length != 0 ?
    RefreshIndicator(
      child: ListView.builder(
        scrollDirection: Axis.vertical,
        shrinkWrap: true,
        itemCount: model.coins.length,
        itemBuilder: (context, index) {
          return Card(
            child: InkWell(
              onTap: (){
                print("tapped");
              },
              child: Padding(
                  padding: const EdgeInsets.only(left: 10, top: 6, right: 10, bottom: 10),
                  child: Column(
                      children: <Widget>[
                        Row(
                          children: [
                            SizedBox(
                              width: 40,
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
                                        }
                                    )
                                  ],
                                )
                            )
                          ],
                        ),
                        Row(
                          children: [
                            Spacer(),

                          ],
                        ),
                      ]
                  )
              )
            )
          );
        },
      ),
      onRefresh: _getData
    ): Center(child: CircularProgressIndicator());
  }
}