import 'package:portfolio_litium/app/locator.dart';
import 'package:portfolio_litium/datamodel/portfolio_coin.dart';
import 'package:portfolio_litium/services/price/portfolio_service.dart';
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
  TextEditingController _controller;

  @override
  void initState() {
    model.loadData();
    _controller = TextEditingController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<PortfolioViewModel>(
      create: (context) => model,
      child: Consumer<PortfolioViewModel>(
        builder: (context, model, child) => Scaffold(
          appBar: AppBar(
            title: Text('Portfolio'),
            actions: <Widget>[
              IconButton(
                icon: Icon(Icons.favorite),
                onPressed: () async {},
              )
            ],
          ),
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              baseCurrencyTitle(model),
              baseCurrencyTextField(model),
              quoteCurrencyList(model),
            ],
          ),
        ),
      ),
    );
  }

  Padding baseCurrencyTitle(PortfolioViewModel model) {
    return Padding(
      padding: const EdgeInsets.only(
          left: 32, top: 32, right: 32, bottom: 5),
      child: Text(
        'Coin', // TODO align
        style: TextStyle(fontSize: 25, color: Colors.red),
      ),
    );
  }

  Padding baseCurrencyTextField(PortfolioViewModel model) {
    return Padding(
      padding: const EdgeInsets.only(left: 32, right: 32, bottom: 32),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.grey[200],
          borderRadius: BorderRadius.all(Radius.circular(10)),
        ),
        child: TextField(
          style: TextStyle(fontSize: 20),
          controller: _controller,
          decoration: InputDecoration(
            prefixIcon: Padding(
              padding: const EdgeInsets.only(left: 16.0, right: 10),
              child: SizedBox(
                width: 60,
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    '${model.baseCoin.coinAbr}',
                    style: TextStyle(fontSize: 30),
                  ),
                ),
              ),
            ),
            labelStyle: TextStyle(fontSize: 20),
            hintStyle: TextStyle(fontSize: 20),
            hintText: 'Amount to exchange',
            border: InputBorder.none,
            contentPadding: EdgeInsets.only(left: 30.0, top: 20, right: 20, bottom: 20),
          ),
          keyboardType: TextInputType.number,
          onChanged: (text) {
            model.calculateExchange(text);
          },
        ),
      ),
    );
  }

  Expanded quoteCurrencyList(PortfolioViewModel model) {
    return Expanded(
      child: ListView.builder(
        itemCount: model.coins.length,
        itemBuilder: (context, index) {
          return Card(
            child: ListTile(
              leading: SizedBox(
                width: 60,
                child: Text(
                  '${model.coins[index].coinAbr}',
                  style: TextStyle(fontSize: 30),
                ),
              ),
              title: Text('${model.coins[index].coinAmount}'),
              subtitle: Text('${model.coins[index].initialCost}'),
              onTap: () {
                model.setNewBaseCurrency(index);
                _controller.text = '${model.coins[index].coinAmount}';
                //_controller.clear();
              },
            ),
          );
        },
      ),
    );
  }
}