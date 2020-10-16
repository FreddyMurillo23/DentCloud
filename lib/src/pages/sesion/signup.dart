import 'package:flutter/material.dart';
import 'package:muro_dentcloud/src/controllers/users_ctrl.dart';
import 'package:muro_dentcloud/src/widgets/date_time.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:intl/intl.dart';
import 'package:flutter_switch/flutter_switch.dart';

class Signup extends StatefulWidget {
  @override
  _SignupState createState() => _SignupState();
  
}

class _SignupState extends State<Signup> {
  final format = DateFormat("yyyy-MM-dd");
  final formkey = new GlobalKey<FormState>();
  String _nombres, _apellidos, _email, _dni, _contrasenia, _celular, _sexo, _provinciaResidencia, _ciudadResidencia, _codigo, _usertype,
  _profesion;
  DateTime _fecha;
  String _sexoEnum;
  bool estado, _obscureText = true;
  int codigo;
  
  void validaterField() {
    final form = formkey.currentState;

    if (form.validate()) {
      form.save();
      print('Form is valid');

      if(estado == true) {
        this._usertype = 'D';
      } else {
        this._usertype = 'P';
      }

      if(this._sexo == 'Masculino') {
        this._sexoEnum = 'M';
      } else {
        this._sexoEnum = 'F';
      }

      UserCtrl.registrarUsuarios(_email, _contrasenia, _dni, _nombres, _apellidos, _fecha, _celular, _sexo, _usertype, _profesion, _provinciaResidencia, _ciudadResidencia).then((value){
        if(value){
          print("De ley chamo");
          Navigator.pop(context);
        } else{
          print("No se pudo burro");
      }
      });

      print(this._nombres);
      print(this._apellidos);
      print(this._email);
      print(this._celular);
      print(this._dni);
      print(this._profesion);
      print(this._usertype);
      print(this._contrasenia);
      print(this._sexoEnum);
    }  else {
      print('Form is invalid');
    }   
  }

  bool validateEmail(String value) {
    Pattern pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regex = new RegExp(pattern);
    return (!regex.hasMatch(value)) ? false : true;
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    this.estado = false;
  }

  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      body: new Container(

        decoration: BoxDecoration(
          image: DecorationImage(image: AssetImage("assets/fondo.jpg"),
          fit: BoxFit.cover
          ),       
        ),


          child: new Center(
          child: new Container(
            height: 750,
            width: 380,
            padding: EdgeInsets.symmetric(horizontal: 24),
            decoration: BoxDecoration(
              color: Colors.white30,
              borderRadius: BorderRadius.circular(20)
            ),
            child: ListView(
                    children: [
                new Form(
                  key: formkey,
                  child: new Column( 
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      SizedBox(height: 15,),

                    //TextField Nombres
                    new TextFormField(
                        autofocus: false,
                        keyboardType: TextInputType.text,
                        textCapitalization: TextCapitalization.words,
                        decoration: InputDecoration(        
                          labelText: "Nombres",
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(20)),
                            borderSide: BorderSide(color: Colors.black),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(20)),
                            borderSide: BorderSide(color: Colors.black)
                          ), 
                          prefixIcon: Icon(Icons.text_fields),
                          filled: true,
                          fillColor: Colors.white,
                        ),
                        validator: (value) => value.isEmpty
                            ? 'Este campo no puede estar vacío'
                            : null,
                        onSaved: (value) => this._nombres = value,
                      ),
  
                    SizedBox(height: 10,),
  
                    //TextField Apellidos 
                    new TextFormField(
                        autofocus: false, 
                        keyboardType: TextInputType.text,
                        textCapitalization: TextCapitalization.words,
                        decoration: InputDecoration(        
                          labelText: "Apellidos",
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(20)),
                            borderSide: BorderSide(color: Colors.black),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(20)),
                            borderSide: BorderSide(color: Colors.black)
                          ), 
                          prefixIcon: Icon(Icons.text_fields),
                          filled: true,
                          fillColor: Colors.white, 
                        ),
                        validator: (value) => value.isEmpty
                            ? 'Este campo no puede estar vacío'
                            : null,
                        onSaved: (value) => this._apellidos = value,
                      ),
  
                    SizedBox(height: 10,),

                    //TextField Fecha de Nacimiento
                    DateTimeField(
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
                      onShowPicker: (context, currentValue) {
                        return showDatePicker(
                            context: context,
                            firstDate: DateTime(1900),
                            initialDate: currentValue ?? DateTime.now(),
                            lastDate: DateTime.now());
                      },
                      validator: (DateTime dateTime){
                        if(dateTime == null) {
                          return "Este campo no puede estar vacio";
                        } if((DateTime.now().year - dateTime.year) < 15) {
                          return "Eres menor chamo";
                        }
                        return null;
                      },
                      onSaved: (DateTime dateTime) => this._fecha = dateTime,   
                    ),
    
                    SizedBox(height: 10,),

                    //TextField DNI
                    new TextFormField(
                      maxLength: 13,
                        autofocus: false,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(        
                          counterText: "",
                          labelText: "DNI",
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(20)),
                            borderSide: BorderSide(color: Colors.black),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(20)),
                            borderSide: BorderSide(color: Colors.black)
                          ),
                          prefixIcon: Icon(Icons.camera_front),
                          filled: true,
                          fillColor: Colors.white,
                        ),
                        validator: (value) => value.isEmpty
                            ? 'Este campo no puede estar vacío'
                            : null,
                        onSaved: (value) => this._dni = value,
                      ),

                    SizedBox(height: 10,),

                    //TextField Celular
                    new TextFormField(
                      maxLength: 10,
                        autofocus: false,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(    
                          counterText: "",    
                          labelText: "Celular",
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(20)),
                            borderSide: BorderSide(color: Colors.black),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(20)),
                            borderSide: BorderSide(color: Colors.black)
                          ), 
                          prefixIcon: Icon(Icons.phone),
                          filled: true,
                          fillColor: Colors.white,
                        ),
                        validator: (value) => value.isEmpty
                            ? 'Este campo no puede estar vacío'
                            : null,
                        onSaved: (value) => this._celular = value,
                      ),  

                    SizedBox(height: 10,),

                    //TextField Correo 
                    new TextFormField(
                        autofocus: false,
                        keyboardType: TextInputType.emailAddress,
                        decoration: InputDecoration(        
                          labelText: "Correo Electrónico",
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(20)),
                            borderSide: BorderSide(color: Colors.black),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(20)),
                            borderSide: BorderSide(color: Colors.black)
                          ), 
                          prefixIcon: Icon(Icons.mail),
                          filled: true,
                          fillColor: Colors.white,
                        ),
                        validator: (value) => value.isEmpty
                            ? 'Este campo no puede estar vacío'
                            : !validateEmail(value)
                            ? 'Ingrese un correo valido'
                            : null,
                        onSaved: (value) => this._email = value,
                      ),

                    SizedBox(height: 10,),

                    //Textfield contraseña  
                    new TextFormField(
                        autofocus: false,
                        obscureText: true,
                        keyboardType: TextInputType.visiblePassword,
                        decoration: InputDecoration(        
                          labelText: "Contraseña",
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(20)),
                            borderSide: BorderSide(color: Colors.black),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(20)),
                            borderSide: BorderSide(color: Colors.black)
                          ), 
                          prefixIcon: Icon(Icons.lock),
                          filled: true,
                          fillColor: Colors.white,
                        ),
                        validator: (value) => value.isEmpty
                            ? 'Este campo no puede estar vacío'
                            : null,
                        onSaved: (value) => this._contrasenia = value,
                      ),

                    SizedBox(height: 10,),

                    //Textfield confirmar contraseña  
                    new TextFormField(
                        autofocus: false,
                        obscureText: true,
                        keyboardType: TextInputType.visiblePassword,
                        decoration: InputDecoration(        
                          labelText: "Confirmar Contraseña",
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(20)),
                            borderSide: BorderSide(color: Colors.black),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(20)),
                            borderSide: BorderSide(color: Colors.black)
                          ), 
                          prefixIcon: Icon(Icons.lock),
                          filled: true,
                          fillColor: Colors.white,
                        ),
                        validator: (value) => value.isEmpty
                            ? 'Este campo no puede estar vacío'
                            : null,
                      ),

                      SizedBox(height: 10,),

                    //Sexo
                    new DropdownButtonFormField(
                      isExpanded: true,
                      items: <String>['Masculino', 'Femenino']
                      .map<DropdownMenuItem<String>>((String value){
                        return DropdownMenuItem<String>(
                          child: Text(value),
                          value: value,
                        );
                      }).toList(),
                      validator: (value) => value == null
                            ? 'Este campo no puede estar vacío'
                            : null,
                      onChanged: (value){
                        this._sexo = value;
                        setState(() {
                          this._sexo = value;
                        });
                      },
                      
                      decoration: InputDecoration(        
                        labelText: "Sexo",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(20)),
                          borderSide: BorderSide(color: Colors.black),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(20)),
                          borderSide: BorderSide(color: Colors.black)
                        ), 
                        prefixIcon: Icon(Icons.accessibility),
                        filled: true,
                        fillColor: Colors.white,
                      ),
                    ),

                      SizedBox(height: 10,),

                    //Textfield Provincia de Residencia
                    new TextFormField(
                        autofocus: false,
                        keyboardType: TextInputType.emailAddress,
                        textCapitalization: TextCapitalization.words,
                        decoration: InputDecoration(        
                          labelText: "Provincia de Residencia",
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(20)),
                            borderSide: BorderSide(color: Colors.black),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(20)),
                            borderSide: BorderSide(color: Colors.black)
                          ), 
                          prefixIcon: Icon(Icons.location_city),
                          filled: true,
                          fillColor: Colors.white,
                        ),
                        validator: (value) => value.isEmpty
                            ? 'Este campo no puede estar vacío'
                            : null,
                        onSaved: (value) => this._provinciaResidencia = value,
                      ),

                      SizedBox(height: 10,),

                    //Textfield Ciudad de Residencia
                    new TextFormField(
                        autofocus: false,
                        keyboardType: TextInputType.emailAddress,
                        textCapitalization: TextCapitalization.words,
                        decoration: InputDecoration(        
                          labelText: "Ciudad de Residencia",
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(20)),
                            borderSide: BorderSide(color: Colors.black),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(20)),
                            borderSide: BorderSide(color: Colors.black)
                          ), 
                          prefixIcon: Icon(Icons.location_city),
                          filled: true,
                          fillColor: Colors.white,
                        ),
                        validator: (value) => value.isEmpty
                            ? 'Este campo no puede estar vacío'
                            : null,
                        onSaved: (value) => this._ciudadResidencia = value,
                      ),

                      SizedBox(height: 10,),

                    //TextField Profesion
                    new TextFormField(
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
                            borderSide: BorderSide(color: Colors.black)
                          ), 
                          prefixIcon: Icon(Icons.work),
                          filled: true,
                          fillColor: Colors.white,
                        ),
                        validator: (value) => value.isEmpty
                            ? 'Este campo no puede estar vacío'
                            : null,
                        onSaved: (value) => this._profesion = value,
                      ),

                      SizedBox(height: 10,),

                    //Switch Tipo de Usuario
                    new Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Text("Perfil Administrativo: "),
                        Expanded(
                          child: FlutterSwitch(

                            showOnOff: true,
                            activeText: 'Medico',
                            inactiveText: 'Paciente',
                            inactiveColor: Colors.red,
                            activeColor: Colors.green,
                            activeTextColor: Colors.black,
                            inactiveTextColor: Colors.black,
                            value: estado,
                            onToggle: (val) {
                              print(val);
                              setState(() {
                                estado = val;
                              });
                            },
                          ),
                        ),
                      ],
                    ),

                      SizedBox(height: 10,),

                    //Codigo Doctor
                    if(estado == true) ...{
                      Center(
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Expanded(
                              child: TextFormField(
                                keyboardType: TextInputType.number,
                                textAlign: TextAlign.center,
                                decoration: InputDecoration(        
                                hintText: 'Codigo = 1234',  
                                  border: OutlineInputBorder(
                                    borderSide: BorderSide(color: Colors.black),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(color: Colors.black)
                                  ), 
                                  
                                  filled: true,
                                  fillColor: Colors.white,
                                ),
                                validator: (value) => value.isEmpty
                                    ? 'Este campo no puede estar vacío'
                                    : value != "1234"
                                    ? 'Código Incorrecto'
                                    : null,
                                onSaved: (value) => this._codigo = value,
                              ),
                            ),
                          ],
                        ),
                      )
                    },

                      SizedBox(height: 10,),

                    new RaisedButton(
                        child: Text("Registrar"),
                        onPressed: validaterField,
                        color: Colors.lightBlue,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(18),
                        ),
                        ),

                      SizedBox(height: 5,),

                    new RaisedButton(
                        child: Text("Cancelar"),
                        onPressed: () => {Navigator.of(context).pushNamedAndRemoveUntil('/', (Route<dynamic> route) => false)},
                        color: Colors.lightBlue,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(18),
                        ),         
                        )
                    ],

                  )
                ),
          ],
            ),
          ),
        ),
      ),
    );
  }
}