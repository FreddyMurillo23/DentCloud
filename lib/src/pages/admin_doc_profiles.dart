import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:muro_dentcloud/src/models/admin_doc_profiles.dart';
import 'package:muro_dentcloud/src/models/search_model/user_data_doctor.dart';
import 'package:muro_dentcloud/src/providers/data_provider.dart';
import 'package:muro_dentcloud/src/resource/preferencias_usuario.dart';

class AdminDocProfiles extends StatefulWidget {
  AdminDocProfiles({Key key}) : super(key: key);

  @override
  _AdminDocProfilesState createState() => _AdminDocProfilesState();
}

class _AdminDocProfilesState extends State<AdminDocProfiles> {
  final DataProvider dataProvider = new DataProvider();
  @override
  Widget build(BuildContext context) {
    final _screenSize = MediaQuery.of(context).size;

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          _appBarTitle(_screenSize),
          _sliverBody(_screenSize),
        ],
      ),
    );
  }

  Widget _appBarTitle(Size _screenSize) {
    return SliverAppBar(
      pinned: true,
      automaticallyImplyLeading: false,
      centerTitle: true,
      leading: InkWell(
        child: Icon(Icons.arrow_back_ios_rounded),
        onTap: () {
          Navigator.pop(context);
        },
      ),
      title: Image(
        image: AssetImage('assets/title.png'),
        height: _screenSize.height * 0.1,
        fit: BoxFit.fill,
      ),
      backgroundColor: Colors.white,
    );
  }

  Widget _sliverBody(Size _screenSize) {
    final prefs = new PreferenciasUsuario();

    return SliverToBoxAdapter(
        child: FutureBuilder(
            future: dataProvider.getDoctorsStatusList(prefs.currentCorreo),
            builder: (context, AsyncSnapshot<List<DoctoresDato>> list) {
              if (list.hasData) {
                print(list.data.length);
                return Column(
                  children: List.generate(list.data.length, (index) {
                    return Column(
                      children: [
                        Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: _screenSize.width * 2.5 / 100),
                          child: Card(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Padding(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: _screenSize.width * 2.5 / 100,
                                      vertical: _screenSize.width * 2.5 / 100),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(100),
                                    child: Container(
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(100)),
                                      child: FadeInImage(
                                        image: NetworkImage(
                                          '${list.data[index].fotoPerfil}',
                                        ),
                                        fit: BoxFit.cover,
                                        placeholder: AssetImage(
                                            'assets/jar-loading.gif'),
                                      ),
                                      height: _screenSize.height * 8 / 100,
                                      width: _screenSize.height * 8 / 100,
                                      // width: 20,
                                    ),
                                  ),
                                ),
                                Expanded(
                                    child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      '${list.data[index].doctor}',
                                      style: TextStyle(color: Colors.blue),
                                    ),
                                    SizedBox(
                                      height: _screenSize.height * 1 / 100,
                                    ),
                                    Text(
                                      '${list.data[index].correo}',
                                      style: TextStyle(color: Colors.black),
                                    ),
                                    Text(
                                      '${list.data[index].profesion}',
                                      style: TextStyle(color: Colors.black),
                                    ),
                                  ],
                                )),
                                Padding(
                                  padding: EdgeInsets.symmetric(
                                      horizontal:
                                          _screenSize.width * 2.5 / 100),
                                  child: InkWell(
                                    onTap: () async {
                                      await dataProvider.changeDoctorStatus(
                                        list.data[index].correo,
                                        list.data[index].status?'D':'A'
                                      );
                                      setState(() {
                                        
                                      });
                                    },
                                    child: Container(
                                      decoration: BoxDecoration(
                                          color: list.data[index].status
                                              ? Colors.blue
                                              : Colors.red,
                                          borderRadius:
                                              BorderRadius.circular(30)),
                                      padding: EdgeInsets.symmetric(
                                          horizontal:
                                              _screenSize.width * 2.5 / 100),
                                      height: _screenSize.height * 3 / 100,
                                      // width: _screenSize.width*5/100,
                                      child: Center(
                                          child: Text(
                                        list.data[index].status
                                            ? 'Activado'
                                            : 'Desactivado',
                                        style: TextStyle(color: Colors.white),
                                      )),
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                        SizedBox(
                          height: _screenSize.height * 2.5 / 100,
                        )
                      ],
                    );
                  }),
                );
              } else {
                return CircularProgressIndicator();
              }
            }));
  }
}
