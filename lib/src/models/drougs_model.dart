import 'package:muro_dentcloud/src/models/publications_model.dart';

class Drougs {
  List<Medicamento> items = new List();
  Drougs.fromJsonList(List<dynamic> jsonList) {
    if (jsonList == null) return;
    for (var item in jsonList) {
      final droug = new Medicamento.fromJsonMap(item);
      items.add(droug);
    }
  }
}

class Medicamento {
  String drugId;
  String drugHealthRegister;
  String drugInstitution;
  String drugProductHolder;
  String drugManufacturingLaboratory;
  String drugName;
  String drugBrand;
  String drugPharmaceuticalForm;
  String drugKindOfProduct;
  String drugAdministration;
  String drugCum;
  String drugConcentration;
  String drugCnmb;
  String drugIndications;
  String drugContraindications;

  Medicamento({
    this.drugId = ' ',
    this.drugHealthRegister = ' ',
    this.drugInstitution = ' ',
    this.drugProductHolder = ' ',
    this.drugManufacturingLaboratory = ' ',
    this.drugName = ' ',
    this.drugBrand = ' ',
    this.drugPharmaceuticalForm = ' ',
    this.drugKindOfProduct = ' ',
    this.drugAdministration = ' ',
    this.drugCum = ' ',
    this.drugConcentration = ' ',
    this.drugCnmb = ' ',
    this.drugIndications = ' ',
    this.drugContraindications = ' ',
  });

  Medicamento.fromJsonMap(Map<String, dynamic> json) {
    drugId = json["drug_id"];
    drugHealthRegister = json["drug_health_register"];
    drugInstitution = json["drug_institution"];
    drugProductHolder = json["drug_product_holder"];
    drugManufacturingLaboratory = json["drug_manufacturing_laboratory"];
    drugName = json["drug_name"];
    drugBrand = json["drug_brand"];
    drugPharmaceuticalForm = json["drug_pharmaceutical_form"];
    drugKindOfProduct = json["drug_kind_of_product"];
    drugAdministration = json["drug_administration"];
    drugCum = json["drug_cum"];
    drugConcentration = json["drug_concentration"];
    drugCnmb = json["drug_cnmb"];
    if (json['drug_indications'] == null) {
      drugIndications = 'Agregue indicaciones';
    } else {
      drugIndications = json["drug_indications"];
    }
    if (json["drug_contraindications"] == null) {
      drugContraindications = 'Agregue contraindicaciones';
    } else {
      drugContraindications = json["drug_contraindications"];
    }
  }
}
