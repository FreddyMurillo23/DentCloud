import 'dart:async'; 
import 'dart:convert'; 
import 'package:http/http.dart' as http;
import 'package:muro_dentcloud/src/models/pdf_apointments_model.dart';

class PDFCitaCtrl{
  static Future<List<PDFModelApointment>> listarPDF(String id) async {
    final response = await http.get("http://54.197.83.249/PHP_REST_API/api/get/get_documents_by_appointment.php?appointment_id=$id");
    if (response.statusCode == 200) {
      final parsed = json.decode(response.body).cast<String, dynamic>();
      return parsed['documento_cita'].map<PDFModelApointment>((json) => PDFModelApointment.fromJson(json)).toList();
    }
    return null;
  }

  static Future<List<PDFModelApointment>> listarPDFPatients(String email) async {
    final response = await http.get("http://54.197.83.249/PHP_REST_API/api/get/get_documents_by_doctors.php?user_email_doctor=$email");
    if (response.statusCode == 200) {
      final parsed = json.decode(response.body).cast<String, dynamic>();
      return parsed['documentos_paciente'].map<PDFModelApointment>((json) => PDFModelApointment.fromJson(json)).toList();
    }
    return null;
  }

  static Future<List<PDFModelApointment>> listarPDFPatientsCita(String id) async {
    final response = await http.get("http://54.197.83.249/PHP_REST_API/api/get/get_documents_by_appointment_patient.php?appointment_id=i$id");
    if (response.statusCode == 200) {
      final parsed = json.decode(response.body).cast<String, dynamic>();
      return parsed['documentos_cita'].map<PDFModelApointment>((json) => PDFModelApointment.fromJson(json)).toList();
    }
    return null;
  }
}