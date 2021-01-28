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

import 'package:flutter/material.dart';
//import 'package:moolax/business_logic/view_models/choose_favorites_viewmodel.dart';
import 'package:portfolio_litium/app/locator.dart';
import 'package:portfolio_litium/datamodel/portfolio_coin.dart';
import 'package:portfolio_litium/view_models/add_coin_viewmodel.dart';
import 'package:portfolio_litium/view_models/portfolio_viewmodel.dart';
import 'package:provider/provider.dart';

class AddCoinScreen extends StatefulWidget {
  @override
  _AddCoinScreenState createState() =>
      _AddCoinScreenState();
}

class _AddCoinScreenState extends State<AddCoinScreen> {

  final _formKey = GlobalKey<FormState>();
  AddCoinViewModel model = locator<AddCoinViewModel>();
  PortfolioViewModel modelPortfolio = locator<PortfolioViewModel>();

  final symbolField = TextEditingController();
  final initialPrice = TextEditingController();
  final initialCost = TextEditingController();
  final coinAmount = TextEditingController();

  @override
  void initState() {
    //model.loadData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Coin'),
      ),
      body: buildListView(model),
    );
  }

  Widget buildListView(AddCoinViewModel viewModel) {
    return ChangeNotifierProvider<AddCoinViewModel>(
      create: (context) => AddCoinViewModel(),
      child: Consumer<AddCoinViewModel>(
        builder: (context, model, child) => Padding(
          padding: const EdgeInsets.only(left: 50, right: 50, bottom: 10),
          child: Form(
            key: _formKey,
            child: Container(
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 16),
                      child: TextFormField(
                          controller: symbolField,
                          decoration: const InputDecoration(
                            hintText: 'Enter your crypto Symbol eg. BTC',
                          ),
                          validator: (value) {
                            if (value.isEmpty) {
                              return 'Please enter a Symbol text';
                            }
                            return null;
                          },
                        )
                      ),
                    Padding(
                      padding: const EdgeInsets.only(top: 16),
                      child: TextFormField(
                        controller: initialPrice,
                        decoration: const InputDecoration(
                          hintText: 'Enter initial Price',
                        ),
                        keyboardType: TextInputType.number,
                        validator: (value ) {
                          if (value.isEmpty) {
                            return 'Please enter initial USD Cost per units';
                          }
                          return null;
                        },
                      )
                    ),
                    Padding(
                        padding: const EdgeInsets.only(top: 16),
                        child: TextFormField(
                          controller: initialCost,
                          decoration: const InputDecoration(
                            hintText: 'Enter initial order cost (USD)',
                          ),
                          keyboardType: TextInputType.number,
                          validator: (value ) {
                            if (value.isEmpty) {
                              return 'Please enter total cost order in USD';
                            }
                            return null;
                          },
                        )
                    ),
                    Padding(
                        padding: const EdgeInsets.only(top: 16),
                        child: TextFormField(
                          controller: coinAmount,
                          decoration: const InputDecoration(
                            hintText: 'Enter total coin amount ',
                          ),
                          keyboardType: TextInputType.number,
                          validator: (value ) {
                            if (value.isEmpty) {
                              return 'Please enter total coin amount (sellable)';
                            }
                            return null;
                          },
                        )
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 16),
                      child: ElevatedButton(
                        onPressed: () {
                          // Validate will return true if the form is valid, or false if
                          // the form is invalid.
                          if (_formKey.currentState.validate()) {
                            PortfolioCoin coin = new PortfolioCoin.fromParams(double.parse(initialPrice.text),double.parse(initialCost.text),double.parse(coinAmount.text),symbolField.text);
                            model.addCoin(coin);
                            modelPortfolio.loadData();
                            Navigator.pop(context);
                          }
                        },
                        child: Text('Add'),
                      ),
                    ),
                  ],
                )
            ),
          )
        )
      ),
    );
  }
}
