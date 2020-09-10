import 'package:flutter/material.dart';
import 'package:muro_dentcloud/src/widgets/date_time.dart';


class Signup extends StatefulWidget {
  @override
  _SignupState createState() => _SignupState();
  
}

class _SignupState extends State<Signup> {
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: new Container(

        decoration: BoxDecoration(
          image: DecorationImage(image: AssetImage("assets/images/fondo1.png"),
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
                  child: new Column( 
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      SizedBox(height: 15,),

                    //TextField Nombres
                    new TextFormField(
                        autofocus: false,
                        keyboardType: TextInputType.text,
                        decoration: InputDecoration(        
                          labelText: "Nombres",
                          focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.black) 
                          ), 
                          prefixIcon: Icon(Icons.text_fields),
                          filled: true,
                          fillColor: Colors.white,
                        ),
                      ),
  
                    SizedBox(height: 10,),
  
                    //TextField Apellidos 
                    new TextFormField(
                        autofocus: false, 
                        keyboardType: TextInputType.text,
                        decoration: InputDecoration(        
                          labelText: "Apellidos",
                          focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.black)
                          ), 
                          prefixIcon: Icon(Icons.text_fields),
                          filled: true,
                          fillColor: Colors.white, 
                        ),
                      ),
  
                    SizedBox(height: 10,),

                    //TextField Fecha de Nacimiento
  
                    BasicDateField(),
    
                    SizedBox(height: 10,),

                    //TextField DNI
                    new TextFormField(
                      maxLength: 13,
                        autofocus: false,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(        
                          counterText: "",
                          labelText: "DNI",
                          focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.black)
                          ), 
                          prefixIcon: Icon(Icons.camera_front),
                          filled: true,
                          fillColor: Colors.white,
                        ),
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
                          focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.black)
                          ), 
                          prefixIcon: Icon(Icons.phone),
                          filled: true,
                          fillColor: Colors.white,
                        ),
                      ),  

                    SizedBox(height: 10,),

                    //TextField Correo 
                    new TextFormField(
                        autofocus: false,
                        keyboardType: TextInputType.emailAddress,
                        decoration: InputDecoration(        
                          labelText: "Correo Electrónico",
                          focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.black)
                          ), 
                          prefixIcon: Icon(Icons.mail),
                          filled: true,
                          fillColor: Colors.white,
                        ),
                      ),

                    SizedBox(height: 10,),

                    //Textfield contraseña  
                    new TextFormField(
                        autofocus: false,
                        obscureText: true,
                        keyboardType: TextInputType.visiblePassword,
                        decoration: InputDecoration(        
                          labelText: "Contraseña",
                          focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.black)
                          ), 
                          prefixIcon: Icon(Icons.lock),
                          filled: true,
                          fillColor: Colors.white,
                        ),
                      ),

                    SizedBox(height: 10,),

                    //Textfield confirmar contraseña  
                    new TextFormField(
                        autofocus: false,
                        obscureText: true,
                        keyboardType: TextInputType.visiblePassword,
                        decoration: InputDecoration(        
                          labelText: "Confirmar Contraseña",
                          focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.black)
                          ), 
                          prefixIcon: Icon(Icons.lock),
                          filled: true,
                          fillColor: Colors.white,
                        ),
                      ),

                      SizedBox(height: 10,),

                    new RaisedButton(
                        child: Text("Registrar"),
                        onPressed: () => {Navigator.of(context).pushNamedAndRemoveUntil('/', (Route<dynamic> route) => false)}
                        ),

                      SizedBox(height: 5,),

                    new RaisedButton(
                        child: Text("Cancelar"),
                        onPressed: () => {Navigator.of(context).pushNamedAndRemoveUntil('/', (Route<dynamic> route) => false)}
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