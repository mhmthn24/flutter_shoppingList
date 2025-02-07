class Urun{
  int urun_id;
  String urun_adi;
  int urun_adet;
  String urun_birim;
  bool urun_alindi;

  Urun({
    required this.urun_id,
    required this.urun_adi,
    this.urun_adet = 1,
    required this.urun_birim,
    this.urun_alindi = false,
  });

  Map<String, dynamic> toJson(){
    return {
      "urun_id": urun_id,
      "urun_adi": urun_adi,
      "urun_adet": urun_adet,
      "urun_birim": urun_birim,
      "urun_alindi": urun_alindi
    };
  }

  factory Urun.fromJSON(Map<String, dynamic> json){
    return Urun(
      urun_id: json["urun_id"],
      urun_adi: json["urun_adi"],
      urun_adet: json["urun_adet"],
      urun_birim: json["urun_birim"],
      urun_alindi: json["urun_alindi"],
    );
  }

}