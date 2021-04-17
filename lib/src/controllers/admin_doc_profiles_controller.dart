import 'package:muro_dentcloud/src/models/admin_doc_profiles.dart';
import 'package:muro_dentcloud/src/providers/data_provider.dart';

class AdminDocProfilesController {
  List<DoctoresDato> items = new List<DoctoresDato>();
  DataProvider dataProvider = new DataProvider();
  AdminDocProfilesController() {
    _getListdoctors();
  }

  void _getListdoctors() async {

  }
}
