import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:muro_dentcloud/src/controllers/apointment_ctrl.dart';
import 'package:muro_dentcloud/src/models/business_Services_models.dart';
import 'package:muro_dentcloud/src/models/current_user_model.dart';
import 'package:muro_dentcloud/src/models/doctors_model.dart';
import 'package:muro_dentcloud/src/models/services_model.dart';
import 'package:muro_dentcloud/src/providers/services_provider.dart';
import 'package:muro_dentcloud/src/widgets/search_bar.dart';
import 'package:provider/provider.dart';

class AddEvent extends StatefulWidget {

  // final EventosModelo eventosModeloGlobal;
  // final bool identificador;

  @override
  _AddEventState createState() => _AddEventState();
  
}

class _AddEventState extends State<AddEvent> {
  final formkey = new GlobalKey<FormState>();
  String doctor, email, descripcion, servicio, user;
  DateTime fecha;
  ServicioProvider servicioProvider;
  Servicios _selectedItem;
  TextEditingController controlador = TextEditingController();
  TextEditingController controladorCorreoUser = TextEditingController();
  TextEditingController controladorNombreUser = TextEditingController();
  TextEditingController controladorApellidoUser = TextEditingController();
  Map dropDownItemsMap;
  List<DropdownMenuItem> listServicio = List<DropdownMenuItem>();
  bool document = true;
  final format = DateFormat("yyyy-MM-dd HH:mm");

  Doctores doctorSeleccionado;
  List<Doctores> historial = [];

  void validateFields(){
    final form = formkey.currentState;
    print(fecha);
    print(servicio);

  if(form.validate()){
    form.save();
    print("Form is valid");
    EventosCtrl.registrarEventos(doctorSeleccionado.cedula+'001', doctorSeleccionado.correo, user, servicio, descripcion, fecha).then((value){
      if(value){
        servicioProvider.disposeServicios();
        Navigator.pop(context);
      } else{
        print("No se pudo burro");
      }
    });
  } else{
    _showDialog();
    print('Form is invalid');
  }
  }

  static DateTime combine(DateTime date, TimeOfDay time) => DateTime(
      date.year, date.month, date.day, time?.hour ?? 0, time?.minute ?? 0);

  bool validateDoctor(Doctores doctores) {
    if (doctores != null) {
      return true;
    } else {
      return false;
    }
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

  //Alerta
  void _showDialog() {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: new Text("Faltan Datos"),
            actions: <Widget>[
              new FlatButton(
                  onPressed: () => {
                    Navigator.of(context).pop()
                  },
                  child: new Text("Aceptar"))
            ],
          );
        });
  }
  
  @override
  void initState() {
    super.initState();
    listServicio.clear();
    _selectedItem = null;
    controladorCorreoUser.text = "userinfo.correo";
    controladorNombreUser.text = "userinfo.nombres";
    controladorApellidoUser.text = "userinfo.apellidos";
  }

  @override
  Widget build(BuildContext context) {
    CurrentUsuario userinfo = ModalRoute.of(context).settings.arguments;
    servicioProvider = Provider.of<ServicioProvider>(context);
    controladorCorreoUser.text = userinfo.correo;
    controladorNombreUser.text = userinfo.nombres;
    controladorApellidoUser.text = userinfo.apellidos;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        child: Column(   
          
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.max,       
          children: [

            Text("Solicitud de Cita", style: TextStyle(color: Colors.black, fontSize: 35),),

            Padding(
              padding: EdgeInsets.fromLTRB(20, 20, 20, 10),
              child: Form(
                key: formkey,
                child: Column(
                  children: [

                    //Container Usuario
                    Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Expanded(
                          child: Container(
                            height: 250,
                            decoration: BoxDecoration(
                              color: Colors.blueGrey[900],
                              borderRadius: BorderRadius.all(Radius.circular(20)),            
                            ),
                            padding: EdgeInsets.fromLTRB(20, 20, 20, 10),
                            child: Column(                 
                              children: [
                                //Correo Usuario
                                Row(
                                  mainAxisSize: MainAxisSize.max,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Flexible(
                                      child: TextField(
                                        controller: controladorCorreoUser,
                                        decoration: InputDecoration(
                                          filled: true,
                                          fillColor: Colors.blueGrey[600],
                                          labelText: "Correo Electrónico",
                                          labelStyle: TextStyle(
                                            color: Colors.white,
                                          ),
                                          enabled: false,
                                          border: OutlineInputBorder(
                                            borderRadius: BorderRadius.all(Radius.circular(10)),
                                          )
                                        ),
                                      ),
                                    ),
                                    SizedBox(width: 10,),
                                    Container(                                    
                                      height: 60,
                                      width: 60,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.all(Radius.circular(10)),
                                        image: DecorationImage(
                                          image: NetworkImage(userinfo.fotoPerfil),
                                          fit: BoxFit.fill
                                        ),
                                        color: Colors.amber
                                      ),
                                    )
                                  ],
                                ),
                                SizedBox(height: 15,),
                                //Nombres Usuario
                                TextField(
                                  controller: controladorNombreUser,
                                  decoration: InputDecoration(
                                    filled: true,
                                    fillColor: Colors.blueGrey[600],
                                    labelText: "Nombres",
                                    labelStyle: TextStyle(
                                      color: Colors.white,
                                    ),
                                    enabled: false,
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.all(Radius.circular(10)),
                                    )
                                  ),
                                ),
                                SizedBox(height: 15,),
                                //Apellidos Usuario
                                TextField(
                                  controller: controladorApellidoUser,
                                  decoration: InputDecoration(
                                    filled: true,
                                    fillColor: Colors.blueGrey[600],
                                    labelText: "Apellidos",
                                    labelStyle: TextStyle(
                                      color: Colors.white,
                                    ),
                                    enabled: false,
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.all(Radius.circular(10)),
                                    )
                                  ),
                                ),
                              ],
                            ),
                          )
                        ),
                      ],
                    ),
                    SizedBox(height: 15,),
                    //!Doctor
                    Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        

                        //Con datos encontrados
                        if(doctorSeleccionado != null)
                        Expanded(
                          child: new TextFormField(
                            controller: controlador,
                            focusNode: FocusNode(),
                            readOnly: true,
                            enableInteractiveSelection: false,
                            decoration: InputDecoration(
                              labelText: "Doctor",
                              filled: true,
                              fillColor: Colors.white,
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.all(Radius.circular(20)),
                              ),
                              suffixIcon: GestureDetector(
                                onTap: ()async{
                                _selectedItem = null;
                                historial = [];
                                final seleccionDoctor = await showSearch(context: context, delegate: EventSearchDelegate('Buscar Doctores', historial));
                                servicioProvider.listarServicios(seleccionDoctor.cedula+"001");
                                setState(() {
                                  doctorSeleccionado = seleccionDoctor;
                                  controlador.text = doctorSeleccionado.doctor;
                                  servicioProvider.listarServicios(doctorSeleccionado.cedula+"001");
                                  //if(seleccionDoctor !=null) {this.historial.insert(0, seleccionDoctor);}                        
                                });
                              },
                                child: Icon(Icons.search),
                              )
                            ),
                            onTap: () {
                              print(doctorSeleccionado.cedula);
                            },
                            validator: (value) => value.isEmpty ? 'Este campo no puede estar vacio' : null,
                            onSaved: (value) => doctor = value+"001",
                          ),
                        ),
                        
                        //No trae datos de la busqueda o recien inicia la interfaz
                        if(doctorSeleccionado == null)
                        Expanded(
                          child: new TextFormField(
                            focusNode: FocusNode(),
                            readOnly: true,
                            enableInteractiveSelection: false,
                            initialValue: null,
                            decoration: InputDecoration(
                              labelText: "Doctor",
                              filled: true,
                              fillColor: Colors.white,
                              hintText: null,
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.all(Radius.circular(20)),
                              ),
                              suffixIcon: GestureDetector(
                                onTap: ()async{
                                final seleccionDoctor = await showSearch(context: context, delegate: EventSearchDelegate('Buscar Doctores', historial));
                                setState(() {
                                  doctorSeleccionado = seleccionDoctor;
                                  controlador.text = doctorSeleccionado.doctor;
                                  if(seleccionDoctor !=null) {this.historial.insert(0, seleccionDoctor);}                           
                                });
                              },
                                child: Icon(Icons.search),
                              )
                            ),
                            validator: (value) => value.isEmpty ? 'Este campo no puede estar vacio' : null,
                            onSaved: (value) => doctor = value,
                          ),
                        ),
                        
                      ],
                    ),
                    SizedBox(height: 15,),
                    //Servicio
                    Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Expanded(
                          child: Selector<ServicioProvider, List<Servicios>>(
                            selector: (context, model) => model.servicios,
                            builder: (context, servicios, child) => Column(
                              children: <Widget>[
                                Container(
                                  padding: EdgeInsets.fromLTRB(15, 0, 10, 0),
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.all(Radius.circular(20))
                                  ),
                                  child: DropdownButtonHideUnderline(
                                    child: DropdownButton(
                                      isExpanded: true,
                                      items: getSelectOptions(servicios), 
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
                                )
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 15,),
                    //Descripcion
                    Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Expanded(
                          child: new TextFormField(
                            maxLines: 3,
                            decoration: InputDecoration(   
                              labelText: "Descripción",                         
                              filled: true,
                              fillColor: Colors.white,
                              enabled: true,
                              hintText: null,
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.all(Radius.circular(20)),
                              ),
                            ),
                            validator: (value) => value.isEmpty ? 'Este campo no puede estar vacio' : null,
                            onSaved: (value) => descripcion = value,
                            onTap: () {
                            },
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 15,),                
                    //Fecha
                    Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Expanded(
                          child: DateTimeField(
                            decoration: InputDecoration(
                              labelText: "Fecha",
                              filled: true,
                              enabled: true,
                              fillColor: Colors.white,
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.all(Radius.circular(20)),
                              ),
                              prefixIcon: Icon(Icons.date_range)
                            ),
                            format: format,
                            onShowPicker: (context, currentValue) async{
                              final date = await showDatePicker(
                                  context: context,
                                  firstDate: DateTime.now(),
                                  initialDate: currentValue ?? DateTime.now(),
                                  lastDate: DateTime(2100)
                              );
                              if(date != null) {
                                final time = await showTimePicker(
                                context: context,
                                initialTime:
                                    TimeOfDay.fromDateTime(currentValue ?? DateTime.now()),
                                );
                                print(combine(date, time));
                                return combine(date, time);
                              } else {
                                return currentValue;
                              }    
                            },
                            validator: (DateTime dateTime){
                              if(dateTime == null) {
                                return "Este campo no puede estar vacio";
                              }
                              return null;
                            },
                            onChanged: (value) {
                              print(value);
                            },
                            onSaved: (DateTime dateTime) => fecha = dateTime,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 15,),        
                    //Botones
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
                                servicioProvider.disposeServicios();
                                Navigator.pop(context);
                              },
                              child: Text("Cancelar"),
                            ),
                          ),
                          SizedBox(width: 10,),
                          Expanded(
                            child: RaisedButton(
                              child: Text("Enviar Solicitud"),
                              onPressed: (){
                                user = userinfo.correo;
                                dropDownItemsMap.clear();
                                listServicio.clear();
                                _selectedItem = null;
                                validateFields();
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
          ],
        ),
      ),
    );
  }
  
}