// ip_address_provider.dart

import 'package:flutter/material.dart';

class IPAddressProvider extends ChangeNotifier {
  late String _ipAddress;

  String get ipAddress => _ipAddress;

  void setIPAddress(String ipAddress) {
    _ipAddress = ipAddress;
    notifyListeners();
  }
}