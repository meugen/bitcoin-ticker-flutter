import 'package:bitcoin_ticker/coin_data.dart';
import 'package:bitcoin_ticker/price_delegate.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PriceScreen extends StatefulWidget {
  @override
  _PriceScreenState createState() => _PriceScreenState();
}

class _PriceScreenState extends State<PriceScreen> {

  String _selectedCurrency = currenciesList.first;
  PriceDelegate _delegate = PriceDelegate(cryptoList);

  Future<void> _future;

  @override
  void initState() {
    super.initState();
    requestFeature();
  }

  void requestFeature() {
    _future = _delegate.onCurrencySelected(_selectedCurrency);
  }

  Widget _createCryptoCard(String name) {
    return Padding(
      padding: EdgeInsets.fromLTRB(18.0, 18.0, 18.0, 0),
      child: Card(
        color: Colors.lightBlueAccent,
        elevation: 5.0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 28.0),
          child: Text(
            '1 $name = ${_delegate.getCurrencyAmountText(name)} $_selectedCurrency',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 20.0,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _future,
      builder: (context, snapshot) {
        return Scaffold(
          appBar: AppBar(
            title: Text('🤑 Coin Ticker'),
          ),
          body: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: cryptoList.map((e) => _createCryptoCard(e)).toList()
              ),
              Container(
                height: 150.0,
                alignment: Alignment.center,
                padding: EdgeInsets.only(bottom: 30.0),
                color: Colors.lightBlue,
                child: CupertinoPicker(
                  backgroundColor: Colors.lightBlue,
                  itemExtent: 32.0,
                  onSelectedItemChanged: (selectedIndex) {
                    _selectedCurrency = currenciesList[selectedIndex];
                    setState(() {
                      requestFeature();
                    });
                  },
                  children: currenciesList
                      .map((e) => Text(
                    e,
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ))
                      .toList(),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
