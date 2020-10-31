class MedicinasModelo{
  String drugname;
  int drugid;
  String drugconcentracion;
  String drugkind; 

  MedicinasModelo({this.drugconcentracion,this.drugid,this.drugkind,this.drugname});

  factory MedicinasModelo.fromJson(Map<String, dynamic> json) {
    return MedicinasModelo(
      drugname: json['drug_name'],
      drugid: int.parse(json['drug_id'].toString()),
      drugconcentracion: json['drug_concentration'],
      drugkind: json['drug_kind_of_product'],
    );
  }
}