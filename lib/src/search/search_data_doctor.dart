import 'package:flutter/material.dart';
import 'package:muro_dentcloud/src/models/search_model/user_data_doctor.dart';
import 'package:muro_dentcloud/src/providers/data_provide1.dart';
class DoctorDataSearch extends SearchDelegate<DoctorDato>{
  final DoctorDato doctor;
  @override
  DataProvider1 doctorProvider = new DataProvider1();
    String seleccion="Cargando Datos ";

  DoctorDataSearch(this.doctor);
  List<Widget> buildActions(BuildContext context) {
       return [
        IconButton(icon: Icon(Icons.clear), 
        onPressed: (){
         query='';

        }),
      ];
    }
   
    @override
    Widget buildLeading(BuildContext context) {
      return IconButton(icon: AnimatedIcon(icon: AnimatedIcons.menu_arrow,
      progress: transitionAnimation,
      ), 
      onPressed: (){
         close(context,null);
      });
    }
  
    @override
    Widget buildResults(BuildContext context) {
     return Center(
        child: Container(
          height: 100,
          width: 100,
          color: Colors.blueAccent,
          child: Text(seleccion),

        ),
      );
    }
  
    @override
    Widget buildSuggestions(BuildContext context) {
    return FutureBuilder(
      future: doctorProvider.doctorSearch(query),
      builder: (BuildContext context, AsyncSnapshot<List<DoctorDato>> snapshot) {
        if(snapshot.hasData)
        {
          if(snapshot.data.length!=0)
        {
           return ListView.builder(
          itemCount: snapshot.data.length,
          itemBuilder: (BuildContext context, int index)
          {
            if(index==null)
            { 
              return Container();

            }else
            {
               return  Column(
                children: [
                  ListTile(
                    leading:FadeInImage(
                  image: NetworkImage(snapshot.data[index].fotoPerfil),
                  placeholder: AssetImage('assets/jar-loading.gif'),
                  width: 50,
                  fit: BoxFit.contain,
                ), 
                    title: Text(snapshot.data[index].doctor),
                    onTap: (){
                       doctor.correo=snapshot.data[index].correo;
                       doctor.doctor=snapshot.data[index].doctor;
                       doctor.celular=snapshot.data[index].celular;
                       doctor.fotoPerfil=snapshot.data[index].fotoPerfil;
                       doctor.profesion=snapshot.data[index].profesion;
                       doctor.cedula=snapshot.data[index].cedula;
                       this.close(context, doctor);
                    },

                  ),
                  Divider(),
                ],
              );
            }  
          },
          );
        }
        else
        {
          return Container();
        }
          
        }
        

          return Center(
              child: SizedBox(
                height: 30,
                width: 30,
                child: CircularProgressIndicator(),
              ),
          );
        
      },
    );
  }

}