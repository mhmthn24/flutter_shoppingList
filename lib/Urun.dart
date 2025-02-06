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

}