import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:muro_dentcloud/src/models/current_user_model.dart';
import 'package:muro_dentcloud/src/models/event_model.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class FancyFab extends StatefulWidget {
  final Function() onPressed;
  final String path;
  final CurrentUsuario currentUsuario;
  final EventosModelo eventosModeloGlobal;

  FancyFab({this.onPressed, this.path, this.currentUsuario, this.eventosModeloGlobal, });

  @override
  _FancyFabState createState() => _FancyFabState();
}

class _FancyFabState extends State<FancyFab>
    with SingleTickerProviderStateMixin {
  bool isOpened = false;
  AnimationController _animationController;
  Animation<Color> _buttonColor;
  Animation<double> _animateIcon;
  Animation<double> _translateButton;
  Curve _curve = Curves.easeOut;
  double _fabHeight = 56.0;

  //Dialog
  Future<void> cupertinoDialog(BuildContext context, CurrentUsuario currentUsuario, EventosModelo eventosModeloGlobal) async {
      switch (await showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text('Subir Receta'),
            content: Text('¿Desea subir la receta?, una vez subida no podrá modificarse'),
            actions: <Widget>[
              DialogButton(
                child: const Text('Aceptar', style: TextStyle(color: Colors.lightBlue),), 
                onPressed: (){
                  Navigator.pop(context, 'Aceptar');
                },
                color: Colors.white
              ),
              DialogButton(
                child: const Text('Cancelar', style: TextStyle(color: Colors.lightBlue),), 
                onPressed: (){
                  Navigator.pop(context, 'Cancelar');
                },
                color: Colors.white
              ),
            ],
          );
        },
      )) {
        case 'Aceptar':
          print('Aceptar');
          uploadFile(currentUsuario, eventosModeloGlobal);  
          break;
        case 'Cancelar':
          print('Cancelar');
          break;
      }
    }

  Future uploadFile(CurrentUsuario currentUsuario, EventosModelo eventosModeloGlobal) async {
      String idcita = eventosModeloGlobal.idcita;
      String descripcion = "Documento";
      String tipo = "pdf";
      DateTime fecha = DateTime.now();
      String correo = currentUsuario.correo;

      final uri =
          Uri.parse("http://54.197.83.249/PHP_REST_API/api/post/post_documents.php?appointment_id=$idcita&document_description=$descripcion&document_type=$tipo&document_date=$fecha&user_email_doctor=$correo");
      var request = http.MultipartRequest('POST', uri);
      request.fields['usuario'] = currentUsuario.correo;
      var pic = await http.MultipartFile.fromPath("archivo", widget.path);
      request.files.add(pic);
      var response = await request.send();
      print("");

      if (response.statusCode == 200) {
        print('ARCHIVO SUBIDA');
        showDialog(
            context: context,
            barrierDismissible: false,
            builder: (BuildContext context) {
              return Dialog(
                child: new Container(
                  height: 100,
                  child: Center(
                    child: new Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        new SizedBox(width: 20,),
                        Center(child: new CircularProgressIndicator()),
                        new SizedBox(width: 10,),
                        new Text(" Subiendo Documento"),
                      ],
                    ),
                  ),
                ),
              );
            },
          );
        new Future.delayed(new Duration(milliseconds: 1500), () {
            Navigator.of(context).pop();
            Navigator.of(context).pop();
            Navigator.of(context).pop();
          });
      } else {
        print('ARCHIVO NO SUBIDA');
      }
  }

  @override
  initState() {
    _animationController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 500))
          ..addListener(() {
            setState(() {});
          });
    _animateIcon =
        Tween<double>(begin: 0.0, end: 1.0).animate(_animationController);
    _buttonColor = ColorTween(
      begin: Colors.blue,
      end: Colors.red,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Interval(
        0.00,
        1.00,
        curve: Curves.linear,
      ),
    ));
    _translateButton = Tween<double>(
      begin: _fabHeight,
      end: -14.0,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Interval(
        0.0,
        0.75,
        curve: _curve,
      ),
    ));
    super.initState();
  }

  @override
  dispose() {
    _animationController.dispose();
    super.dispose();
  }

  animate() {
    if (!isOpened) {
      _animationController.forward();
    } else {
      _animationController.reverse();
    }
    isOpened = !isOpened;
  }

  Widget add() {
    return Container(
      child: FloatingActionButton(
        heroTag: null,
        onPressed: (){
          Navigator.of(context).pop();
        },
        tooltip: 'Seguir Editando',
        child: Icon(Icons.edit),
      ),
    );
  }

  Widget image(CurrentUsuario currentUsuario, EventosModelo eventosModeloGlobal, BuildContext context) {
    return Container(
      child: FloatingActionButton(
        heroTag: null,
        onPressed: (){
          cupertinoDialog(context, currentUsuario, eventosModeloGlobal);
        },
        tooltip: 'Subir Archivo',
        child: Icon(Icons.upload_file),
      ),
    );
  }

  Widget inbox(Function() subir) {
    return Container(
      child: FloatingActionButton(
        heroTag: null,
        onPressed: subir,
        tooltip: 'Previsualizar Archivo',
        child: Icon(Icons.search),
      ),
    );
  }

  Widget toggle() {
    return Container(
      child: FloatingActionButton(
        backgroundColor: _buttonColor.value,
        onPressed: animate,
        tooltip: 'Toggle',
        child: AnimatedIcon(
          icon: AnimatedIcons.menu_close,
          progress: _animateIcon,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: <Widget>[
        Transform(
          transform: Matrix4.translationValues(
            0.0,
            _translateButton.value * 3.0,
            0.0,
          ),
          child: add(),
        ),
        Transform(
          transform: Matrix4.translationValues(
            0.0,
            _translateButton.value * 2.0,
            0.0,
          ),
          child: image(widget.currentUsuario, widget.eventosModeloGlobal, context),
        ),
        Transform(
          transform: Matrix4.translationValues(
            0.0,
            _translateButton.value,
            0.0,
          ),
          child: inbox(widget.onPressed),
        ),
        toggle(),
      ],
    );
  }
}