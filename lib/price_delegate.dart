import 'dart:convert';

import 'package:flutter/widgets.dart';
import 'package:http/http.dart';

const _API_KEY = 'NWYwOGE5ZTYxYmVlNGZhZDkzNGYzYTQ5NzI4MTQ0YTE';
const _HEADERS = {
  'x-ba-key': _API_KEY,
};

class PriceDelegate extends ChangeNotifier {
  final List<String> _cryptoList;
  Map<String, double> _cryptoValues = {};

  PriceDelegate(this._cryptoList);

  Future<double> _fetchCryptoDayAverages(String crypto, String currency) async {
    dynamic response = await get(
      'https://apiv2.bitcoinaverage.com/indices/global/ticker/$crypto$currency',
      headers: _HEADERS,
    );
    var data = json.decode(response.body);
    return data['averages']['day'];
  }

  Future<void> onCurrencySelected(String currency) async {
    _cryptoValues.clear();
    for (String crypto in _cryptoList) {
      _cryptoValues[crypto] = await _fetchCryptoDayAverages(crypto, currency);
    }
  }

  String getCurrencyAmountText(String crypto) {
    double amount = _cryptoValues[crypto];
    if (amount == null) {
      return '?';
    }
    return amount.toInt().toString();
  }
}
