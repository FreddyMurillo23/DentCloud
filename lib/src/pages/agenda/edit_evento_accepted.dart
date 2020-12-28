import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:muro_dentcloud/src/controllers/apointment_ctrl.dart';
import 'package:muro_dentcloud/src/models/current_user_model.dart';
import 'package:muro_dentcloud/src/models/event_model.dart';
import 'package:muro_dentcloud/src/models/services_model.dart';
import 'package:muro_dentcloud/src/providers/services_provider.dart';
import 'package:muro_dentcloud/src/widgets/CachedImagenWidget.dart';
import 'package:provider/provider.dart';

class EditEventAccepted extends StatefulWidget {
  final EventosModelo eventosModeloGlobal;
  final CurrentUsuario currentuser;
  final Servicios nuevo;
  
  EditEventAccepted({Key key, this.eventosModeloGlobal, this.currentuser, this.nuevo}) : super(key: key);

  @override
  _EditEventAcceptedState createState() => _EditEventAcceptedState();
}

class _EditEventAcceptedState extends State<EditEventAccepted> {
  List<DropdownMenuItem> listServicio = List<DropdownMenuItem>();
  Map dropDownItemsMap;
  final formkey = new GlobalKey<FormState>();
  Servicios _selectedItem;
  String servicio;
  final date = DateFormat("yyyy-MM-dd");
  final time = DateFormat("HH:mm");
  DateTime fecha, dia;
  TextEditingController controladoFecha = TextEditingController();
  TextEditingController controladorHora = TextEditingController();
  TextEditingController controladoNombre = TextEditingController();
  TimeOfDay hora;

  @override
  void initState() { 
    super.initState();
    this._selectedItem = widget.nuevo;
    controladoNombre.text = widget.eventosModeloGlobal.paciente;
    dia = widget.eventosModeloGlobal.fecha;
    hora = TimeOfDay(hour: widget.eventosModeloGlobal.fecha.hour, minute: widget.eventosModeloGlobal.fecha.minute);
    servicio = widget.nuevo.servicioid.toString();
  }

  List<DropdownMenuItem> getSelectOptions(List<Servicios> servicios){
    dropDownItemsMap = new Map();
    listServicio.clear();
    servicios.forEach((servicios) { 
      int index = servicios.servicioid;
      dropDownItemsMap[index] = servicios;
      listServicio.add(new DropdownMenuItem(
        child: Text(servicios.descripcion),
        value: servicios.servicioid,
      ));
    });
    return listServicio;
  }

  static DateTime combine(DateTime date, TimeOfDay time) => DateTime(
      date.year, date.month, date.day, time?.hour ?? 0, time?.minute ?? 0);

  @override
  Widget build(BuildContext context) {
    ServicioProviderNuevo servicioProviderNuevo = Provider.of<ServicioProviderNuevo>(context);
    

    return Scaffold(
       appBar: AppBar(
         backgroundColor: Colors.white,
       ),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: EdgeInsets.fromLTRB(20, 20, 20, 1),
                child: Container(
                  height: 200,
                  decoration: BoxDecoration(
                    color: Colors.green,
                    borderRadius: BorderRadius.circular(20)
                  ),
                  child: Padding(
                    padding: EdgeInsets.fromLTRB(20, 20, 20, 10),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Center(
                          child: Container(
                            height: 90,
                            width: 80,
                            decoration: BoxDecoration(
                              color: Colors.red,
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: CachedImageWidget(
                              icon: Icon(Icons.error),
                              image: widget.eventosModeloGlobal.foto,
                            ),
                          ),
                        ),
                        SizedBox(height: 10,),
                        TextField(
                          controller: controladoNombre,
                          maxLines: 2,
                          minLines: 1,
                          decoration: InputDecoration(
                          labelText: "Nombre del Paciente",
                          filled: true,
                          enabled: false,
                          fillColor: Colors.white,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(20)),
                          ),
                        ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Center(
                child: SingleChildScrollView(
                    child: Padding(
                    padding: EdgeInsets.fromLTRB(20, 20, 20, 10),
                    child: Center(
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.amber,
                          borderRadius: BorderRadius.circular(20)
                        ),
                        height: 300,
                        child: Padding(
                          key: formkey,
                          padding: EdgeInsets.fromLTRB(20, 20, 20, 10),
                          child: Form(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Selector<ServicioProviderNuevo, List<Servicios>>(
                                  selector: (context, model) => model.servicios,
                                  builder: (context, value, child) => Column(
                                    children: [
                                      Container(
                                        padding: EdgeInsets.fromLTRB(15, 0, 10, 0),
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius: BorderRadius.all(Radius.circular(20))
                                        ),
                                        child: DropdownButtonHideUnderline(
                                          child: DropdownButton(
                                            isExpanded: true,
                                            items: getSelectOptions(value), 
                                            onChanged: (selected) {
                                              this._selectedItem = dropDownItemsMap[selected];
                                              servicio = _selectedItem.servicioid.toString();
                                              setState(() {
                                                this._selectedItem = dropDownItemsMap[selected];
                                                servicio = _selectedItem.servicioid.toString();
                                              });
                                            },
                                            hint: new Text(
                                              _selectedItem != null ? _selectedItem.descripcion: "Servicios",
                                            ),
                                          ),                                
                                        ), 
                                      ),
                                      SizedBox(height: 10,),
                                      //Fecha Edicion
                                      DateTimeField(
                                        initialValue: widget.eventosModeloGlobal.fecha,
                                        decoration: InputDecoration(
                                          suffixIcon: IconButton(icon: Icon(Icons.cancel, color: Colors.transparent,),onPressed: null,),
                                          labelText: "Fecha",
                                          filled: true,
                                          enabled: true,
                                          fillColor: Colors.white,
                                          border: OutlineInputBorder(
                                            borderRadius: BorderRadius.all(Radius.circular(20)),
                                          ),
                                          prefixIcon: Icon(Icons.date_range),
                                        ),
                                        format: date,
                                        onShowPicker: (context, currentValue) async {
                                          return showDatePicker(
                                              context: context,
                                              firstDate: DateTime(1900),
                                              initialDate: currentValue ?? DateTime.now(),
                                              lastDate: DateTime(2100));
                                        },
                                        onChanged: (value) => dia = value,
                                      ),
                                      SizedBox(height: 5,),
                                      //Hora Edicion
                                      DateTimeField(
                                        initialValue: widget.eventosModeloGlobal.fecha,
                                        decoration: InputDecoration(
                                          suffixIcon: IconButton(icon: Icon(Icons.cancel, color: Colors.transparent,),onPressed: null,),
                                          labelText: "Hora",
                                          filled: true,
                                          enabled: true,
                                          fillColor: Colors.white,
                                          border: OutlineInputBorder(
                                            borderRadius: BorderRadius.all(Radius.circular(20)),
                                          ),
                                          prefixIcon: Icon(Icons.date_range)
                                        ),
                                        format: time,
                                        onShowPicker: (context, currentValue) async {
                                          final time = await showTimePicker(
                                            context: context,
                                            initialTime: TimeOfDay.fromDateTime(currentValue ?? DateTime.now()),
                                          );
                                          hora = time;
                                          return DateTimeField.convert(time);
                                        },
                                        validator: (DateTime dateTime){
                                          if(dateTime == null) {
                                            return "Este campo no puede estar vacio";
                                          }
                                          return null;
                                        },
                                      ),
                                    ],
                                  ),
                                  
                                ),
                                SizedBox(height: 10,),
                                //!Botones
                                Center(
                                child: Row(
                                  mainAxisSize: MainAxisSize.max,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Expanded(
                                      child: RaisedButton(
                                        onPressed: (){
                                          dropDownItemsMap.clear();
                                          listServicio.clear();
                                          _selectedItem = null;
                                          Navigator.pop(context);
                                        },
                                        child: Text("Cancelar"),
                                      ),
                                    ),
                                    SizedBox(width: 10,),
                                    Expanded(
                                      child: RaisedButton(
                                        child: Text("Actualizar Cita"),
                                        onPressed: (){
                                          if(servicio == null || dia == null || hora == null) {
                                          } else{ 
                                            fecha = combine(dia, hora);
                                            print(servicio);
                                            print(widget.eventosModeloGlobal.fecha);
                                            print(hora.toString());
                                            EventosCtrl.actualizarEventosDatos(widget.eventosModeloGlobal.idcita, servicio, fecha).then((value) {
                                              if(value) {
                                                Scaffold.of(context).showSnackBar(SnackBar(
                                                  content: Text("Cita Actualizada con Éxito"),
                                                  duration: Duration(seconds: 1),
                                                  backgroundColor: Colors.green,
                                                ));
                                              } else {
                                                Scaffold.of(context).showSnackBar(SnackBar(
                                                  content: Text("Error al Actualizar la Cita"),
                                                  duration: Duration(seconds: 1),
                                                  backgroundColor: Colors.green,
                                                ));
                                              }
                                            });
                                            Navigator.pop(context);
                                          }
                                        }
                                      ),
                                    )      
                                  ],
                                ),
                              ),
                              ],  
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}