import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:muro_dentcloud/src/pages/chat/lista_chat.dart';
import 'package:muro_dentcloud/src/pages/chat/lista_chat1.dart';
import 'package:muro_dentcloud/src/providers/data_provide1.dart';
import 'package:path_provider/path_provider.dart';
// import 'package:file_picker/file_picker.dart';

import 'colors/colors.dart';
class ChatPage extends StatefulWidget {
  final nombre;
  final correotro;
  final loguiado;
  final foto;
  final sala;
  ChatPage({Key key, this.nombre, this.foto, this.sala, this.loguiado, this.correotro}) : super(key: key);

  @override
  _ChatPageState createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  final _formKey = GlobalKey<FormState>();
  DataProvider1 datos= new DataProvider1();
  TextEditingController _envioMensajeController = TextEditingController();
   var imageFile;
   String fotopath;
  String mensaje;
  var verificar=0;

  void registrardatos(){
     final form = _formKey.currentState;
    if (form.validate()) {
      form.save();
    }   
    if(mensaje=="")
    {
      if(fotopath!=null)
      {
        
        if(datos.ingresarMensajes(widget.loguiado,widget.correotro,mensaje, fotopath) != true)
        {

           print('Guardar datos ');
           _envioMensajeController.clear();
           fotopath=null;
           verificar=0;
        }
      }
    }
    else
    {
         
         if(datos.ingresarMensajes(widget.loguiado,widget.correotro, mensaje, fotopath) != true)
        {
             print('Guardar datos ');
           _envioMensajeController.clear();
           verificar=0;
        }
     
    }
  }
  bool validarMensaje(String valor)
  {
    if(valor=="")
    {
      return false;
    }
    else
    {
      return true;
    }

  }
  @override
  Widget build(BuildContext context) {
     
      return Scaffold(
      appBar: getAppBar(context),
      body: GetBodyChat1(
          email: widget.loguiado,
          sala: widget.sala,
          verificacion: verificar,
         ),
      bottomSheet: getBottomSheet(context),
    );
   
  }
   Widget getAppBar(BuildContext context) {
    
    return AppBar(
      backgroundColor: grey.withOpacity(0.4),
      elevation: 0.0,
      leading: InkWell(
          onTap: () {
            Navigator.pop(context);
          },
          child: Icon(
            Icons.arrow_back_ios,
            color: primary,
          )),
      title: Row(
        children: <Widget>[
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
                shape: BoxShape.circle,
                image: DecorationImage(
                    image: NetworkImage(widget.foto), fit: BoxFit.cover)),
          ),
          SizedBox(width: 20),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                widget.nombre,
                style: TextStyle(
                    fontSize: 18, fontWeight: FontWeight.bold, color: black),
              )
            ],
          )
        ],
      ),
    );
  }


   Widget getBottomSheet(BuildContext context) {
    return SingleChildScrollView(
          child: Container(
            
        padding: EdgeInsets.symmetric(horizontal: 8),
        height: 70,
        color: Colors.white,
        child: Row(
          children: <Widget>[
            IconButton(
              icon: Icon(Icons.photo),
              iconSize: 25,
              color: primary,
              onPressed: () {
               _openGallery();
              },
            
            ),
            // IconButton(
            //   icon: Icon(Icons.note_add_rounded),
            //   iconSize: 25,
            //   color: primary,
            //   onPressed: () {
            //     localPath();
            //   },
            // ),
            Expanded(
              child: Form(
                key: _formKey,
                child: Center(
                  child: TextFormField(
                    validator: (value)=> value.isEmpty?
                    null : !validarMensaje(value)
                      ? null
                      : null,
                    onSaved: (value) => this.mensaje = value,
                    controller: _envioMensajeController,
                    decoration:
                        InputDecoration.collapsed(hintText: 'Enviar mensaje..'),
                    textCapitalization: TextCapitalization.sentences,
                  ),
                ),
              ),
            ),
            IconButton(
              icon: Icon(Icons.camera_alt),
              iconSize: 25,
              color: primary,
              onPressed: (){
                _openCamera();


            }),
            IconButton(
              icon: Icon(Icons.send),
              iconSize: 25,
              color: primary,
              onPressed: () {
                 registrardatos();
              },
            ),
          ],
        ),
      ),
    );
  }

  Future _openGallery() async {
    var picture = await ImagePicker.pickImage(source: ImageSource.gallery);
    
    this.setState(() {
      imageFile = picture;
      if(imageFile!=null)
      {
       fotopath=picture.path;
      }
      
     
    });
    if(fotopath!=null)
    {
       return _mostrarFoto();
    }
    
  }
   Future _openCamera() async {
    var picture = await ImagePicker.pickImage(source: ImageSource.camera);
    this.setState(() {
      imageFile = picture;
      if(imageFile!=null){
       fotopath=picture.path;
      }
      

    });
    if(fotopath!=null)
    {
       return _mostrarFoto();
    }
    
  }

 Future _mostrarFoto() {
      if( imageFile != null )
     {
        return showDialog(
               context: context,
               builder: (_)=>
                  AlertDialog(
                  content: Builder(
                    builder: (context){
                      var height = MediaQuery.of(context).size.height;
                      var width = MediaQuery.of(context).size.width;
                      return Container(
                            height: height*0.4,
                            width: width*0.7,
                            child: Image(image:FileImage(imageFile)),
                            //color: Colors.green,
                      );
                    },
                  ),
                  title: Text("Imagen seleccionada"),
                  actions: [
                    TextButton(
                      child: Text('Cancelar'),
                      onPressed: ()  {
                        Navigator.of(context).pop();
                      },
                    ),
                    TextButton(
                       child: Text('Enviar'),
                      onPressed: (){
                        registrardatos();
                        Navigator.of(context).pop();
                      },
                    ),
                  ],
                ),
        );
    }
    
}


  Future<String>  localPath() async {

//   FilePickerResult result = await FilePicker.platform.pickFiles(allowMultiple: true);

// if(result != null) {
//    List<File> files = result.paths.map((path) => File(path)).toList();
//    print(files);
// } else {
//    // User canceled the picker
// }
 }
}