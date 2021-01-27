import 'dart:io';

import 'package:portfolio_litium/datamodel/portfolio_coin.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

import 'storage_service.dart';

class StorageServiceDB implements StorageService {

  StorageServiceDB._();
  static final StorageServiceDB db = StorageServiceDB._();
  static Database _database;

  Future<Database> get database async {
    if (_database != null)
      return _database;
    _database = await initDB();
    return _database;
  }

  initDB() async {
    Directory documentsDirectory = await
    getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, "Coins.db");
    return await openDatabase(
        path, version: 1,
        onOpen: (db) {},
        onCreate: (Database db, int version) async {
          await db.execute(
              "CREATE TABLE PortfolioCoins ("
                  "coinAbr TEXT,"
                  "initialCost REAL,"
                  "initialPrice REAL,"
                  "coinAmount REAL"")"
          );
          await db.execute(
              "INSERT INTO PortfolioCoins ('coinAbr', 'initialCost', 'initialPrice', 'coinAmount') values (?, ?, ?, ?)",
              ['SC', 1071.57, 0.0048, 223020.506250 ]
          );
        }
    );
  }

  @override
  Future<List<PortfolioCoin>> getPortfolioData() async {
    final db = await database;
    List<Map>
    results = await db.query("PortfolioCoins", columns: PortfolioCoin.columns, orderBy: "coinAbr ASC");

    List<PortfolioCoin> products = new List();
    results.forEach((result) {
      PortfolioCoin product = PortfolioCoin.fromMap(result);
      products.add(product);
    });
    return products;
  }

  @override
  Future<bool> isExpiredCache() async{
    return false;
  }

  @override
  Future savePortFolio(List<PortfolioCoin> data) async {

    /*
    PortfolioCoin item;

    final db = await database;

    var result = await db.rawInsert(
        "INSERT INTO PortfolioCoins ('coinAbr', 'initialCost', 'initialPrice', 'coinAmount') values (?, ?, ?, ?)",
        [item.coinAbr, item.initialCost, item.initialPrice, item.coinAmount]
    );
    */
    return null;
    throw UnimplementedError();
  }

}