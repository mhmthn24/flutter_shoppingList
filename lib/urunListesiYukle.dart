import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import 'Urun.dart';

Future<List<Urun>> urunListesiYukle() async {
  final prefs = await SharedPreferences.getInstance();

  List<String>? jsonList = prefs.getStringList("urunListesi");

  if(jsonList == null){
    return [];
  }

  return jsonList.map((item) => Urun.fromJSON(jsonDecode(item))).toList();
}