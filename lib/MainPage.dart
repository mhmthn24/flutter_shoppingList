import 'package:flutter/material.dart';
import 'package:flutter_shopping/Urun.dart';
import 'package:fluttertoast/fluttertoast.dart';

class Mainpage extends StatefulWidget {
  @override
  State<Mainpage> createState() => _MainpageState();
}

class _MainpageState extends State<Mainpage> {
  /*
    Ana Listeleme Ekranı
   */
  List<Urun> urunListesi = [
    Urun(urun_id: 1, urun_adi: "Elma", urun_birim: "Kilogram", urun_adet: 5),
    Urun(urun_id: 2, urun_adi: "Armut", urun_birim: "Paket", urun_adet: 1),
    Urun(urun_id: 3, urun_adi: "Domates", urun_birim: "Kilogram", urun_adet: 2),
    Urun(urun_id: 4, urun_adi: "Muz", urun_birim: "Adet", urun_adet: 3),
  ];

  List<String> birimListesi = ["Kilogram", "Adet", "Paket", "Litre"];
  String birim = "Kilogram";

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Stack(
          children: [
            Opacity(
              opacity: 0.3,
              child: Container(
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage("assets/images/alisveris.webp"),
                    fit: BoxFit.cover
                  )
                ),
              ),
            ),
            Column(
              children: [
                Container(
                  padding: EdgeInsets.all(8),
                  margin: EdgeInsets.all(8),
                  child: Column(
                    children: [
                      ElevatedButton(
                        onPressed: (){
                          setState(() {
                            urunEkleDialog(context);
                          });
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.orange,
                          foregroundColor: Colors.black
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Yeni Ürün Ekle",
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold
                              ),
                            ),
                            Icon(
                              Icons.add,
                              color: Colors.black,
                              size: 32,
                            )
                          ],
                        ),
                      ),
                      ElevatedButton(
                        onPressed: (){
                          Fluttertoast.showToast(
                            msg: "Listeyi temizlemek için uzun basınız",
                            toastLength: Toast.LENGTH_SHORT,
                            gravity: ToastGravity.BOTTOM,
                            backgroundColor: Color(0xFF002767),
                            textColor: Colors.white
                          );
                        },
                        onLongPress: (){
                          setState(() {
                            urunListesi.clear();
                          });
                        },
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.orange,
                            foregroundColor: Colors.black
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Listeyi Temizle",
                              style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold
                              ),
                            ),
                            Icon(
                              Icons.clear_all,
                              color: Colors.black,
                              size: 32,
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),

                Expanded(
                  child: ListView.builder(
                    itemCount: urunListesi.length,
                    itemBuilder: urunListeleme,
                  ),
                )
              ],
            )
          ],
        ),
      )
    );
  }

  Widget urunListeleme(
      BuildContext context,
      int index,
  ){
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.max,
      children: [
        GestureDetector(
          onTap: (){
            setState(() {
              urunEkleDialog(
                  context,
                  guncellenecekUrun: urunListesi[index],
                  index: index
              );
            });
          },
          child: Container(
            padding: EdgeInsets.all(8),
            margin: EdgeInsets.all(8),
            decoration: BoxDecoration(
                border: Border.all(color: Color(0xFF002767), width: 8),
                borderRadius: BorderRadius.circular(30)
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              mainAxisSize: MainAxisSize.max,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      urunListesi[index].urun_adi,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 24,
                        decoration: urunListesi[index].urun_alindi
                            ? TextDecoration.lineThrough
                            : TextDecoration.none,
                        color: urunListesi[index].urun_alindi
                          ? Colors.grey
                          : Colors.black
                      ),
                    ),
                    Text(
                      "${urunListesi[index].urun_adet.toString()} "
                          "${urunListesi[index].urun_birim}",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                        decoration: urunListesi[index].urun_alindi
                          ? TextDecoration.lineThrough
                          : TextDecoration.none,
                        color: urunListesi[index].urun_alindi
                          ? Colors.grey
                          : Colors.black
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    GestureDetector(
                      onTap: (){
                        setState(() {
                          urunListesi[index].urun_alindi = !urunListesi[index].urun_alindi;
                        });
                      },
                      child: Icon(
                        urunListesi[index].urun_alindi ? Icons.undo : Icons.add,
                        size: 50,
                      ),
                    ),
                    SizedBox(width: 8,),
                    GestureDetector(
                      onTap: (){
                        Fluttertoast.showToast(
                          msg: "Silmek için uzun basınız",
                          toastLength: Toast.LENGTH_SHORT,
                          gravity: ToastGravity.BOTTOM,
                          backgroundColor: Color(0xFF002767),
                          textColor: Colors.white
                        );
                      },
                      onLongPress: (){
                        setState(() {
                          urunListesi.remove(urunListesi[index]);
                        });
                      },
                      child: Icon(
                        Icons.delete,
                        size: 50,
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        )
      ],
    );
  }

  Future<void> urunEkleDialog(
    BuildContext context,
    {Urun? guncellenecekUrun, int? index}
  ) async {

    /*
      Ürün Ekle/Güncelle Dialog Penceresini açar
     */

    TextEditingController _controllerUrunAdi = TextEditingController();
    int adetSayaci = 1;
    String yerelBirim = birim;

    if(guncellenecekUrun != null){
      _controllerUrunAdi.text = guncellenecekUrun.urun_adi;
      adetSayaci = guncellenecekUrun.urun_adet;
      yerelBirim = guncellenecekUrun.urun_birim;
    }

    return showDialog(
      context: context,
      builder: (BuildContext context){
        return StatefulBuilder(
          builder:(BuildContext context, _setState){
            return Dialog(
              backgroundColor: Color(0xFFADD8E6),
              child: Container(
                padding: EdgeInsets.all(8),
                margin: EdgeInsets.all(8),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  spacing: 8,
                  children: [
                    Text(
                      guncellenecekUrun != null ? "Ürün Güncelleme" : "Ürün Ekleme",
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold
                      ),
                    ),
                    TextField(
                      controller: _controllerUrunAdi,
                      decoration: InputDecoration(
                        labelText: "Ürün Adı"
                      ),
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        IconButton(
                          onPressed: (){
                            _setState(() {
                              if(adetSayaci > 1){
                                adetSayaci--;
                              }
                            });
                          },
                          icon: Icon(
                            Icons.remove,
                            size: 40,
                          ),
                        ),
                        Text(
                          adetSayaci.toString(),
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold
                          ),
                        ),
                        IconButton(
                          onPressed: (){
                            _setState(() {
                              adetSayaci++;
                            });
                          },
                          icon: Icon(
                            Icons.add,
                            size: 40,
                          ),
                        )
                      ],
                    ),
                    DropdownButton<String>(
                      value: yerelBirim,
                      items: birimListesi.map((String? yeniBirim){
                        return DropdownMenuItem<String>(
                          value: yeniBirim,
                          child: Text(
                            yeniBirim!,
                            style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold
                            ),),
                        );
                      }).toList(),
                      onChanged: (String? yeniBirim){
                        _setState(() {
                          yerelBirim = yeniBirim!;
                        });
                      },
                    ),
                    Row(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Expanded(
                          flex: 1,
                          child: ElevatedButton(
                            onPressed: (){
                              Navigator.of(context).pop();
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.orange,
                              foregroundColor: Colors.black
                            ),
                            child: Text(
                              "Vazgeç",
                              style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold
                              ),),
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: ElevatedButton(
                            onPressed: (){
                              setState(() {
                                Navigator.of(context).pop();

                                if(guncellenecekUrun != null){
                                  urunListesi[index!] = Urun(
                                    urun_id: guncellenecekUrun.urun_id,
                                    urun_adi: _controllerUrunAdi.text,
                                    urun_birim: yerelBirim,
                                    urun_adet: adetSayaci
                                  );
                                }else{
                                  Urun yeniUrun = Urun(
                                    urun_id: urunListesi.length + 1,
                                    urun_adi: _controllerUrunAdi.text,
                                    urun_birim: yerelBirim,
                                    urun_adet: adetSayaci
                                  );

                                  urunListesi.add(yeniUrun);
                                }

                              });
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Color(0xFF002767),
                              foregroundColor: Colors.white
                            ),
                            child: Text(
                              guncellenecekUrun != null ? "Güncelle" : "Ekle",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold
                              ),
                            ),
                          ),
                        )
                      ],
                    )
                  ],
                ),
              ),
            );
          }
        );
      },
    );
  }
}
