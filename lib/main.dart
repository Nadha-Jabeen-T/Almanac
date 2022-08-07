import 'package:flutter/material.dart';

import 'models/transaction.dart';
import 'widgets/transaction_list.dart';
import 'widgets/new_transactions.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Almanac',
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final List<Transaction> _userTransactions = [
    Transaction(
      id: 't1',
      title: 'Gold Jimki',
      amount: 125,
      date: DateTime.now(),
    ),
    Transaction(
      id: 't2',
      title: 'Metal bangles',
      amount: 80,
      date: DateTime.now(),
    ),
    Transaction(
      id: 't3',
      title: 'Bait-AL-Mandi Alfaham',
      amount: 369.99,
      date: DateTime.now(),
    )
  ];
  void _addNewTransaction(String txTitle, double txAmount) {
    final newTx = Transaction(
      id: DateTime.now().toString(),
      title: txTitle,
      amount: txAmount,
      date: DateTime.now(),
    );

    setState(() {
      _userTransactions.add(newTx);
    });
  }

  /*Shows a sheet, when the floating action button is pressed */
  void _startAddNewTransaction(BuildContext ctx) {
    /*startAddNewTransaction takes the context of the "Transaction sheet" => give it to showModalBottomSheet, which accepts that context -> and give it to builder*/
    showModalBottomSheet(
        context: ctx,
        builder: (bCtx) {
          return GestureDetector(
            onTap: (() {}),
            child: NewTransaction(_addNewTransaction),
            behavior: HitTestBehavior.opaque,
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Almanac'),
        backgroundColor: Colors.purple,
        actions: [
          IconButton(
            onPressed: () => _startAddNewTransaction(context),
            icon: Icon(Icons.add),
          )
        ],
      ),
      body: SingleChildScrollView(
        /*SingleChildScrollView - Only works at the Whole body level */
        child: Center(
          //THE STATISTICS CHART
          child: Column(
            //mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Card(
                color: Colors.amber,
                child: Container(
                  width: double.infinity,
                  child: Text('CHART!'),
                ),
                elevation: 5,
              ), //
              //THE INPUT 'ADD-TRANSACTION' AREA
              //THE TRANSACTIONS
              TransactionList(_userTransactions),
            ],
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
        onPressed: () => _startAddNewTransaction(context),
        child: Icon(Icons.add),
        backgroundColor: Colors.purple,
      ),
    );
  }
}
