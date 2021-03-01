import 'package:flutter/material.dart';
import 'package:muro_dentcloud/src/models/pdf_apointments_model.dart';
import 'package:muro_dentcloud/src/pages/agenda/pdf_cita.dart';
import 'package:muro_dentcloud/src/providers/pdf_provider.dart';
import 'package:muro_dentcloud/src/resource/preferencias_usuario.dart';
import 'package:provider/provider.dart';

class Repositorio extends StatefulWidget {
  final String idCita;

  const Repositorio({Key key, this.idCita}) : super(key: key);

  @override
  _RepositorioState createState() => _RepositorioState();
}

int count = 2;

class _RepositorioState extends State<Repositorio> {
  Map dropDownItemsMap;
  List<DropdownMenuItem> listServicio = List<DropdownMenuItem>();
  PDFProviderPatients pdfProvider;
  PDFModelApointment prueba;
  List<Widget> pdfWidget = [];

  Map<String, List<PDFModelApointment>> _eventsGetPDF(
      List<PDFModelApointment> events) {
    Map<String, List<PDFModelApointment>> data = {};
    events.forEach((event) {
      String date = event.nombrePaciente;
      if (data.containsKey(date)) {
        data[date].add(event);
      } else {
        if (data[date] == null) data[date] = [];
        data[date].add(event);
      }
    });
    return data;
  }

  @override
  Widget build(BuildContext context) {
    final prefs = new PreferenciasUsuario();
    pdfProvider = Provider.of<PDFProviderPatients>(context);
    pdfProvider.listarRecetasPacientes(prefs.currentCorreo);
    if(pdfProvider.pdf.isNotEmpty){
      setState(() {
        funcionPrueba(context);
      });
    }
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
      ),
      body: funcionPrueba(context),
    );
  }

  String fecha(DateTime fecha){
    return fecha.year.toString()+'/'+fecha.month.toString()+'/'+fecha.day.toString();
  }

  funcionPrueba(BuildContext prueba) {
    return Selector<PDFProviderPatients, List<PDFModelApointment>>(
        selector: (context, model) => model.pdf,
        builder: (context, value, child) {
          pdfWidget.clear();
          this._eventsGetPDF(value).forEach((key, valor) {
            pdfWidget.add(Container(
                decoration:
                    BoxDecoration(borderRadius: BorderRadius.circular(20)),
                child: Card(
                  child: ExpansionTile(
                    title: Text(key),
                    children: [
                      for (var item in valor)
                        ListTile(
                          leading: Container(
                            height: 30,
                            width: 30,
                            child: Image.asset('assets/pdf.png'),
                          ),
                          title: Text(fecha(item.fechaCarga)),
                          subtitle: Text(item.url),
                          onTap: (){
                            Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    PDFCitas(url: item.url,)));
                            
                          },
                        )
                    ],
                  ),
                )));
          });
          return ListView(
            children: pdfWidget,
          );
        });
  }
}
