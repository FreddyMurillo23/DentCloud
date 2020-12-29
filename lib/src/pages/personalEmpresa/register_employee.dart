import 'dart:io';

import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:muro_dentcloud/src/models/business_model.dart';
import 'package:muro_dentcloud/src/models/search_model/user_data_doctor.dart';
import 'package:muro_dentcloud/src/providers/data_provide1.dart';
import 'package:muro_dentcloud/src/search/search_data_doctor.dart';


class RegisterEmployee extends StatefulWidget {
  RegisterEmployee({Key key}) : super(key: key);


  @override
  _RegisterEmployeeState createState() => _RegisterEmployeeState();
}

class _RegisterEmployeeState extends State<RegisterEmployee> {
   final formkey = new GlobalKey<FormState>();
   DataProvider1 doctorProvider= new DataProvider1();
   TextEditingController texto=TextEditingController();
   TextEditingController textoNombre=TextEditingController();
   TextEditingController textoCelular=TextEditingController();
    TextEditingController textoProfesion=TextEditingController();
   DoctorDato doctor = new DoctorDato();
   File foto;
   String rolDoctor;
   NegocioData business= new NegocioData();
    bool validate(String value) {
    return true;
  }
  @override
  Widget build(BuildContext context) {
     final screenSize = MediaQuery.of(context).size;
     NegocioData businessinfo = ModalRoute.of(context).settings.arguments;
     business=businessinfo;
    return Scaffold(
       appBar: appMenu(screenSize),
       body: fomText(),
    );
  }

void ingresarEmpleado()
{
  final form=formkey.currentState;
  if(form.validate())
  {
    form.save();
   if(doctor!=null)
   {
     doctorProvider.ingresarempleado(doctor, business.ruc, rolDoctor).then((value) {
       if(value)
       {
         showDialogExito();
       }
       else
       {
        showDialogNopermito();
       }
     });
     
   }
   else
   {

   }

  }
  
}

void showDialogNopermito() {
    // flutter defined function
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          title: new Text("Ingresar Datos"),
          content: new Text("Doctor ya existente en este consultario ingresar otro"),
          actions: <Widget>[
            // usually buttons at the bottom of the dialog
            new FlatButton(
              child: new Text("Cerrar"),
              onPressed: () {
                Navigator.of(context).pop();
                //Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
}

void showDialogExito() {
    // flutter defined function
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          title: new Text("Ingresar Datos"),
          content: new Text("Ingresado con exito el Doctor al establecimiento ${business.negocio}"),
          actions: <Widget>[
            // usually buttons at the bottom of the dialog
            new FlatButton(
              child: new Text("Cerrar"),
              onPressed: () {
                Navigator.of(context).pushNamedAndRemoveUntil(
                    '/', (Route<dynamic> route) => false);
                //Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
}


Widget fomText(){
  final screenSize = MediaQuery.of(context).size;
   return Container(
          padding: EdgeInsets.all(20),
         child: SingleChildScrollView(
           scrollDirection: Axis.vertical,
           child: Form(
             key: formkey,
             child: Column(
               children: [
                _mostrarImagen(screenSize),
                SizedBox(
                height: screenSize.height * 0.015,
                ),
                buscarempleado(),
                 SizedBox(
                height: screenSize.height * 0.03,
                ),
                textFieldCedula(screenSize),
                 SizedBox(
                height: screenSize.height * 0.03,
                ),
                textFieldNombre(screenSize),
                 SizedBox(
                height: screenSize.height * 0.03,
                ),
                textFieldtelefono(screenSize),
                SizedBox(
                height: screenSize.height * 0.03,
                ),
                textFieldProfesion(screenSize),
                SizedBox(
                height: screenSize.height * 0.03,
                ),
                selectbox(),
                SizedBox(
                height: screenSize.height * 0.025,
                ),
                buttonRegistrar(screenSize),
               ],
             ),
           ),
         ),
       );

}


Widget selectbox(){
  return Container(
    child: DropdownButtonFormField(
       style: new TextStyle(
                color: Colors.black,
                //fontSize: 18.0,
             ),
      isExpanded: true,
       items: <String>['Owner','Secretary', 'Doctor']
                  .map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  child: Text(value),
                  value: value,
                );
              }).toList(),
      validator: (value) =>
                  value == null ? 'Este campo no puede estar vacío' : null,
              onChanged: (value) {
                this.rolDoctor = value;
                setState(() {
                  this.rolDoctor = value;
                });
              },
      decoration: InputDecoration(
                labelText: "Roles Doctor",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(20)),
                  borderSide: BorderSide(color: Colors.black),
                ),
                focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                    borderSide: BorderSide(color: Colors.black)),
                prefixIcon: Icon(MdiIcons.doctor),
                filled: true,
                fillColor: Colors.white,
              )
    ),
  );

}

Widget textFieldProfesion(Size sizescreen) {
    return Container(
      child: new TextFormField(
        controller: textoProfesion,
        //initialValue: hearData,
         readOnly: true,
        autofocus: false,
        keyboardType: TextInputType.text,
        textCapitalization: TextCapitalization.words,
        decoration: InputDecoration(
          labelText: "Profesion",
          border: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(20)),
            borderSide: BorderSide(color: Colors.black),
          ),
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(20)),
              borderSide: BorderSide(color: Colors.black)),
          prefixIcon: Icon(MdiIcons.professionalHexagon),
          filled: true,
          fillColor: Colors.white,
        ),
        //maxLines: 2,
        validator: (value) => value.isEmpty
            ? 'Este campo no puede estar vacío'
            : !validate(value)
                ? 'Ingrese un profesion válido'
                : null,
        onSaved: (value) => this.doctor.profesion = value,
      ),
    );
}


 Widget textFieldCedula(Size sizescreen) {
    return Container(
      child: new TextFormField(
        controller: texto,
        //initialValue: hearData,
         readOnly: true,
        autofocus: false,
        keyboardType: TextInputType.text,
        textCapitalization: TextCapitalization.words,
        decoration: InputDecoration(
          labelText: "Cedula",
          border: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(20)),
            borderSide: BorderSide(color: Colors.black),
          ),
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(20)),
              borderSide: BorderSide(color: Colors.black)),
          prefixIcon: Icon(MdiIcons.alphaCBoxOutline),
          filled: true,
          fillColor: Colors.white,
        ),
        //maxLines: 2,
        validator: (value) => value.isEmpty
            ? 'Este campo no puede estar vacío'
            : !validate(value)
                ? 'Ingrese una cedula válido'
                : null,
        onSaved: (value) => this.doctor.cedula = value,
      ),
    );
}

Widget textFieldNombre(Size sizescreen) {
    return Container(
      child: new TextFormField(
       controller: textoNombre,
         readOnly: true,
        autofocus: false,
        keyboardType: TextInputType.text,
        textCapitalization: TextCapitalization.words,
        decoration: InputDecoration(
          labelText: "Nombre",  
          border: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(20)),
            borderSide: BorderSide(color: Colors.black),
          ),
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(20)),
              borderSide: BorderSide(color: Colors.black)),
          prefixIcon: Icon(Icons.text_fields),
          filled: true,
          fillColor: Colors.white,
        ),
        //maxLines: 2,
        validator: (value) => value.isEmpty
            ? 'Este campo no puede estar vacío'
            : !validate(value)
                ? 'Ingrese un Nombre válido'
                : null,
        onSaved: (value) => this.doctor.doctor = value,
      ),
    );
}

Widget textFieldtelefono(Size sizescreen) {
    return Container(
      child: new TextFormField(
        controller: textoCelular,
         readOnly: true,
        autofocus: false,
        keyboardType: TextInputType.text,
        textCapitalization: TextCapitalization.words,
        decoration: InputDecoration(
          labelText: "Celular",
          border: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(20)),
            borderSide: BorderSide(color: Colors.black),
          ),
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(20)),
              borderSide: BorderSide(color: Colors.black)),
          prefixIcon: Icon(MdiIcons.deskphone),
          filled: true,
          fillColor: Colors.white,
        ),
        //maxLines: 2,
        validator: (value) => value.isEmpty
            ? 'Este campo no puede estar vacío'
            : !validate(value)
                ? 'Ingrese un telefono válido'
                : null,
        onSaved: (value) => this.doctor.doctor = value,
      ),
    );
}


 Widget _mostrarImagen(Size screenSize) {
    if (doctor.fotoPerfil!= null) {
      return Stack(
        alignment: Alignment(0.95, 0.99),
        children: <Widget>[
          Card(
            margin: new EdgeInsets.only(
                left: 5.0, right: 5.0, top: 8.0, bottom: 25.0),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0)),
            elevation: 30.0,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10.0),
              child: FadeInImage(
               image: NetworkImage(doctor.fotoPerfil),
               placeholder: AssetImage('assets/placeholder.png'),
              )
                // height: 300.0,
              ),
            ),
          
          
        ],
      );
    }
    return Stack(
      alignment: Alignment(0.95, 0.99),
      children: <Widget>[
        Card(
            margin: new EdgeInsets.only(
                left: 5.0, right: 5.0, top: 8.0, bottom: 25.0),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0)),
            elevation: 30.0,
            child: ClipRRect(
                borderRadius: BorderRadius.circular(10.0),
                child: Image.asset('assets/upload.png'))),
        
        // IconButton(
        //     icon: Icon(Icons.add_a_photo),
        //     onPressed: () {
        //       _ingresarImagen();
        //     })
      ],
    );
    // return Container();
}

Widget buscarempleado(){
  String hearderData;

  if(doctor.correo==null)
  {
   hearderData="Seleccione un doctor";
  } 
  else
  {
    hearderData=doctor.correo;
  }
  return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.0),
          color: Colors.white,
          boxShadow: <BoxShadow>[
            BoxShadow(
                color: Colors.grey[500],
                blurRadius: 10.0,
                spreadRadius: 1.0,
                offset: Offset(2.0, 10.0))
          ]),
    child: Column(
      children: [
        Container(
              alignment: Alignment(-0.80, -0.1),
              child: Text(
                'Correo Doctor ',
                style: TextStyle(color: Colors.lightBlue),
              ),
            ),
        Card(
            margin:
                  new EdgeInsets.only(left: 10.0, right: 10.0, top: 8.0, bottom: 5.0),
              shape:
                  RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
              elevation: 4.0,
              child: ListTile(
                 leading: Icon(MdiIcons.bookSearchOutline),
                 title: Text(hearderData),
                 trailing: Icon(MdiIcons.play),
                 onTap: ()async{
                  final resultado= await showSearch(
                  context: context,
                  delegate: DoctorDataSearch(doctor));
                  setState(() {
                    if(resultado!=null)
                    {
                      doctor.fotoPerfil=resultado.fotoPerfil;
                      doctor.cedula=resultado.cedula;
                      doctor.correo=resultado.correo;
                      doctor.doctor=resultado.doctor;
                      doctor.celular=resultado.celular;
                      texto.text=doctor.cedula;
                      textoNombre.text=doctor.doctor;
                      textoCelular.text=doctor.celular;
                      textoProfesion.text=doctor.profesion;
                    }
                  });

                 },

              ),

        ),
      ],
    ),
  );
}

Widget buttonRegistrar(Size sizescreen){
  return Row(
    children: [
      SizedBox(
        width: sizescreen.width*0.045,
      ),
      ButtonTheme(
        minWidth: sizescreen.width * 0.35,
        //height: sizescreen.height*0.056,
        child: Center(
          child: RaisedButton(
            child: Text("Registrar"),
            onPressed: (){
             ingresarEmpleado();
            },
            color: Colors.lightBlue,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(18),
            ),
          ),
        ),
      ),
      SizedBox(
        width: sizescreen.width*0.1,
      ),
      ButtonTheme(
        minWidth: sizescreen.width * 0.36,
        //height: sizescreen.height*0.056,
        child: RaisedButton(
          child: Text("Cancelar"),
          onPressed: () => {
            Navigator.of(context).pop()
          },
          color: Colors.lightBlue,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(18),
          ),
        ),
      )
    ],
  );
}


Widget appMenu(Size _screenSize) {
    return AppBar(
      brightness: Brightness.light,
      backgroundColor: Colors.white,
      title: Image(
        image: AssetImage('assets/title.png'),
        height: _screenSize.height * 0.1,
        fit: BoxFit.fill,
      ),
      centerTitle: false,
      actions: <Widget>[
        /*CircleButton(
          icon: MdiIcons.forumOutline,
          iconsize: 30.0,
          onPressed: (){},
          // onPressed: () => Navigator.pushNamed(context, 'messenger', arguments: userinfo),
        )*/
      ],
    );
  }
}