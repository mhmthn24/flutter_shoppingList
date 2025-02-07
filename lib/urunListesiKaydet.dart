import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'Urun.dart';

Future<void> urunListesiKaydet(List<Urun> urunListesi) async {
  final prefs = await SharedPreferences.getInstance();

  // Listemizi JSON formatina cevirelim
  List<String> jsonList = urunListesi.map(
          (item) => (jsonEncode(item.toJson()))
  ).toList();

  // Cevirdigimiz formati kaydedelim
  await prefs.setStringList("urunListesi", jsonList);
}