import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:muro_dentcloud/src/controllers/apointment_ctrl.dart';
import 'package:muro_dentcloud/src/models/current_user_model.dart';
import 'package:muro_dentcloud/src/models/event_model.dart';
import 'package:muro_dentcloud/src/models/services_model.dart';
import 'package:muro_dentcloud/src/pages/agenda/view_eventDoctor.dart';
import 'package:muro_dentcloud/src/pages/agenda/view_eventUser.dart';
import 'package:muro_dentcloud/src/providers/event_provider.dart';
import 'package:muro_dentcloud/src/providers/services_provider.dart';
import 'package:provider/provider.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:table_calendar/table_calendar.dart';
import 'dart:async';

class AgendaUserWithProvider extends StatefulWidget {
  final CurrentUsuario currentuser;
  const AgendaUserWithProvider({Key key, this.currentuser}) : super(key: key);
  @override
  _AgendaUserWithProviderState createState() => _AgendaUserWithProviderState();
}

class _AgendaUserWithProviderState extends State<AgendaUserWithProvider> {
  CalendarController _controller;
  Map<DateTime, List<dynamic>> _events;
  ServicioProvider servicioProvider;
  List<dynamic> _selectedEvents;
  List<EventosModeloUsuario> eventosModel2;
  List<EventosModeloUsuario> eventosModeUsuario;
  EventosUsuario eventosProvider;
  int countSelectedDay, countList;
  Map dropDownItemsMap;
  DateTime selectedDay;
  List<DropdownMenuItem> listServicio = List<DropdownMenuItem>();
  Servicios _selectedItem;
  final date = DateFormat("yyyy-MM-dd");
  final time = DateFormat("HH:mm");
  DateTime fecha, dia;
  TimeOfDay hora;
  String servicio;
  final formkey = new GlobalKey<FormState>();

  TextEditingController controladorFecha = TextEditingController();
  TextEditingController controladorHora = TextEditingController();

  @override
  void initState() {
    super.initState();
    _events = {};
    _selectedEvents = [];
    _controller = CalendarController();
    countSelectedDay = 0;
    selectedDay = DateTime.now();
    eventosModel2 = [];
    countList = 0;
  }
  
  static DateTime combine(DateTime date, TimeOfDay time) => DateTime(
      date.year, date.month, date.day, time?.hour ?? 0, time?.minute ?? 0);

  Map<DateTime, List<dynamic>> _eventsGetPrueba(List<EventosModeloUsuario> events) {
    Map<DateTime, List<dynamic>> data = {};
    events.forEach((event) {
      DateTime date = DateTime(event.fecha.year, event.fecha.month,
          event.fecha.day);
      if(data.containsKey(date)){
        data[date].add(event);
      } else{
        if (data[date] == null) data[date] = [];
        data[date].add(event);
      }
    });
    return data;
  }

  List<EventosModeloUsuario> transormar(List<dynamic> dinamico) {
    var temporal2 = List<EventosModeloUsuario>.from(dinamico);
    return temporal2;
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

  String fechaString(DateTime selectDay){
    String fecha = DateFormat('EEEE, d MMMM, yyyy', 'es').format(selectedDay).toString();
    String cambio;

    cambio=fecha[0].toUpperCase() + fecha.substring(1);

    return cambio;
  }


  @override
  Widget build(BuildContext context) {

    CurrentUsuario userinfo = ModalRoute.of(context).settings.arguments;
    final _screenSize = MediaQuery.of(context).size;
    eventosProvider = Provider.of<EventosUsuario>(context);
    eventosProvider.listarEventosUser(userinfo.correo);
    servicioProvider = Provider.of<ServicioProvider>(context);
    servicioProvider.listarServicios(userinfo.cedula+'001');    

    void valideField(EventosModelo eventos){
    final form = formkey.currentState;

    if (form.validate()) {
      form.save();
      if(servicio == null || dia == null || hora == null) {
        print('Algo nulo chamo');
        } else{ 
          fecha = combine(dia, hora);
          EventosCtrl.actualizarEventosDatos(eventos.idcita, servicio, fecha).then((value) {
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
          setState(() {
            _selectedItem = null;
            countList = 0;
          });
          
          Navigator.pop(context);
        }   
      print("Form is valid");
    } else {
      print('Form is invalid');
    }
  }
    
    return Scaffold(
      backgroundColor: Colors.white,
      body: Selector<EventosUsuario, List<EventosModeloUsuario>>(
        selector: (context, model) => model.eventosUsuario,
        builder: (context, value, child) =>
          SingleChildScrollView(
            child: Column(children: <Widget>[
              Card(
                child: TableCalendar(
                  initialSelectedDay: null,
                  availableGestures: AvailableGestures.horizontalSwipe,
                  locale: 'es',
                  calendarController: _controller,
                  //!
                  events: _eventsGetPrueba(value),
                  initialCalendarFormat: CalendarFormat.month,
                  calendarStyle: CalendarStyle(
                      canEventMarkersOverflow: true,
                      todayColor: Colors.blueGrey[500],
                      selectedColor: Colors.red),
                  headerStyle: HeaderStyle(
                      formatButtonVisible: false,
                      centerHeaderTitle: true,
                      titleTextStyle: const TextStyle(
                        fontSize: 17,
                      )),
                  startingDayOfWeek: StartingDayOfWeek.monday,
                  onDaySelected: (day, events, holidays) {
                    setState(() {
                      if (events.isNotEmpty) {
                        _selectedEvents = events;
                        eventosModel2 = transormar(_selectedEvents);
                        selectedDay = day;
                        countList = eventosModel2.length;
                        print(countList.toString());
                        countSelectedDay = events.length;
                      } else {
                        eventosModel2 = [];
                        countList = eventosModel2.length;
                        print(countList);
                        selectedDay = day;
                        countSelectedDay = 0;
                        _selectedEvents.clear();
                      }
                    });
                  },
                  builders: CalendarBuilders(
                    selectedDayBuilder: (context, date, events) => Container(
                      margin: const EdgeInsets.all(4.0),
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                          color: Colors.blueGrey[500],
                          borderRadius: BorderRadius.circular(10)),
                      child: Text(
                        date.day.toString(),
                        style: TextStyle(color: Colors.black),
                      ),
                    ),
                    todayDayBuilder: (context, date, events) => Container(
                      margin: const EdgeInsets.all(4.0),
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                          color: Colors.red,
                          borderRadius: BorderRadius.circular(10)),
                      child: Text(
                        date.day.toString(),
                        style: TextStyle(color: Colors.black),
                      ),
                    ),
                    markersBuilder: (context, date, events, holidays) {
                      final children = <Widget>[];
                      if (events.isNotEmpty) {
                        children.add(
                          Positioned(
                            right: 1,
                            bottom: 1,
                            child: _buildEventsMarker(date, events),
                          ),
                        );
                      }
                      return children;
                    },
                  ),
                ),
                
                elevation: 10,
                margin: new EdgeInsets.only(
                    left: 10.0, right: 10.0, top: 8.0, bottom: 5.0),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.0)),
              ),

              //Eventos
              if (countList != 0)
              Card(
                child: ExpansionTile(
                  maintainState: false,
                  tilePadding:
                      EdgeInsets.fromLTRB(_screenSize.width * 0.060, 0, 12, 1),
                  leading: Icon(
                    MdiIcons.bookOpenPageVariant,
                    color: Colors.lightBlue,
                  ),
                  title: Text(
                    fechaString(selectedDay),
                    style: TextStyle(color: Colors.grey.shade600),
                  ),
                  subtitle: Text('Usted tiene $countSelectedDay citas agendadas'),
                  children: [
                    for(EventosModeloUsuario eventos in eventosModel2)
                    Dismissible(
                      key: ValueKey(eventos),
                      child: ListTile(
                        leading: Container(
                          width: 60,
                          height: 60,
                          child: FadeInImage.assetNetwork(placeholder: 'assets/loading.gif', image: eventos.foto, fit: BoxFit.fill,),
                        ),
                        title: Text(eventos.servicio),
                        subtitle: Text(eventos.fecha.year.toString()+"/"+eventos.fecha.month.toString()+"/"+eventos.fecha.day.toString()),
                        onTap: () {
                          //!
                          Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (_) => ViewEventUser(
                                  eventosModeloGlobal: eventos, currentuser: userinfo,)));
                        },
                      ),
                      direction: DismissDirection.startToEnd,
                      confirmDismiss: (direction) async{
                        return await showDialog(
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                              title: const Text('Cancelar Cita'),
                              content: const Text("¿Está seguro que desea cancelar esta cita?"),
                               actions: <Widget>[
                                  FlatButton(
                                    onPressed: () {
                                      setState(() {
                                      eventosModel2.remove(eventos);
                                      EventosCtrl.actualizarEventosDenied(eventos.idcita).then((value) {
                                        if (value) {
                                          setState(() {
                                            eventosModel2.remove(eventos);
                                            countSelectedDay--;
                                            countList = eventosModel2.length;
                                            
                                          });                             
                                        } else {
                                        }
                                      });
                                    });  
                                    showDialog(
                                      context: context,
                                      barrierDismissible: false,
                                      builder: (BuildContext context) {
                                        return Dialog(
                                          child: new Container(
                                            height: 100,
                                            child: new Row(
                                              mainAxisSize: MainAxisSize.min,
                                              children: [
                                                new CircularProgressIndicator(),
                                                new SizedBox(width: 10,),
                                                new Text(" Cargando"),
                                              ],
                                            ),
                                          ),
                                        );
                                      },
                                    );
                                    new Future.delayed(new Duration(seconds: 2), () {
                                      Navigator.of(context).pop(false);
                                      Navigator.of(context).pop(false); //pop dialog
                                    });                                
                                    },
                                    child: const Text("Aceptar")
                                  ),
                                  FlatButton(
                                    onPressed: () => Navigator.of(context).pop(false),
                                    child: const Text("Cancelar"),
                                    
                                  ),
                                ],
                            );
                          },
                        );
                      },
                      background: Container(
                        child: Icon(Icons.delete, color: Colors.red,),
                        alignment: Alignment.center,
                      ),
                      secondaryBackground: Container(
                        child: Icon(Icons.delete, color: Colors.red,),
                        alignment: Alignment.center,
                      ),
                    ),
                  ],
                  
                ),
                elevation: 10,
                margin: new EdgeInsets.only(
                    left: 10.0, right: 10.0, top: 8.0, bottom: 5.0),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.0)),
              ),

              Container(
                height: 100,
              ),
            ]),
          )
      ),
      floatingActionButton: floatingButon(userinfo),
    );
  }

  Widget floatingButon(CurrentUsuario userinfo) {
    return FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          print('object');
          Navigator.pushNamed(context, 'addagenda', arguments: userinfo);
        });
  }

  Widget _buildEventsMarker(DateTime date, List events) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: _controller.isSelected(date)
            ? Colors.brown[500]
            : _controller.isToday(date) ? Colors.brown[300] : Colors.blue[400],
      ),
      width: 16.0,
      height: 16.0,
      child: Center(
        child: Text(
          '${events.length}',
          style: TextStyle().copyWith(
            color: Colors.white,
            fontSize: 12.0,
          ),
        ),
      ),
    );
  }
  
}
