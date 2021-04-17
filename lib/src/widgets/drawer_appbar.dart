import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:muro_dentcloud/src/controllers/PDFcita_ctrl.dart';

import 'package:muro_dentcloud/src/models/current_user_model.dart';
import 'package:muro_dentcloud/src/providers/data_provider.dart';
import 'package:muro_dentcloud/src/providers/pdf_provider.dart';
// import 'package:muro_dentcloud/src/providers/doctores_provider.dart';
// import 'package:muro_dentcloud/src/providers/event_provider.dart';
import 'package:muro_dentcloud/src/resource/preferencias_usuario.dart';
import 'package:muro_dentcloud/src/search/search_and_show_drougs.dart';
import 'package:muro_dentcloud/src/widgets/card_expansion_list.dart';
import 'package:provider/provider.dart';
import 'package:scroll_to_index/scroll_to_index.dart';

// import 'package:provider/provider.dart';

class NavDrawer extends StatefulWidget {
  final CurrentUsuario currentuser;
  const NavDrawer({Key key, this.currentuser}) : super(key: key);
  @override
  _NavDrawerState createState() => _NavDrawerState();
}

class _NavDrawerState extends State<NavDrawer> {
  bool active = false;
  final prefs = new PreferenciasUsuario();
  AutoScrollController controller;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controller = AutoScrollController(
        viewportBoundaryGetter: () =>
            Rect.fromLTRB(0, 0, 0, MediaQuery.of(context).padding.bottom),
        axis: Axis.vertical);
  }

  @override
  Widget build(BuildContext context) {
    // DoctoresProvider docProv = Provider.of<DoctoresProvider>(context);
    // EventosProvider eventProv = Provider.of<EventosProvider>(context);
    // EventosHoldProvider eventHoldProv = Provider.of<EventosHoldProvider>(context);
    PDFProviderPatients pdfProvider = Provider.of<PDFProviderPatients>(context);
    PDFProviderByUser pdfProviderUser = Provider.of<PDFProviderByUser>(context);
    final currentUserData = new PreferenciasUsuario();
    // controller.scrollToIndex(index);
    return Drawer(
      child: CustomScrollView(
        controller: controller,
        shrinkWrap: true,
        slivers: [
          _draweHeader(),
          _divider(),
          _labelPerfiles(),
          _drugs(),
          _repository(pdfProvider, currentUserData, pdfProviderUser),
        ],
      ),
    );
  }

  Future _scrollToIndex(int index) async {
    print('SCROLLLL CTM@!!!');
    await controller.scrollToIndex(index,
        preferPosition: AutoScrollPosition.begin);
  }

  Widget listaPerfiles(CurrentUsuario userinfo) {
    return ListView.builder(
        shrinkWrap: true,
        itemCount: 1 + widget.currentuser.openUserTrabajos.length,
        itemBuilder: (context, int index) {
          // print('${widget.currentuser.openUserTrabajos}');
          final data = widget.currentuser.openUserTrabajos;
          if (widget.currentuser.openUserTrabajos.length == 0) {
            return Column(
              children: [
                ListTile(
                  title: Text(
                      '${widget.currentuser.nombres} ${widget.currentuser.apellidos}'),
                  subtitle: Text(
                      '${widget.currentuser.correo} \n${widget.currentuser.cedula}'),
                  trailing: Icon(Icons.business),
                  onTap: () {
                    prefs.currentProfile = true;
                    print(userinfo.correo);
                    prefs.profileID = userinfo.correo;
                    prefs.profileName =
                        '${userinfo.nombres} ${userinfo.apellidos}';
                    print('Tap in that sheet');
                  },
                ),
                Divider(
                  color: Colors.grey,
                )
              ],
            );
          } else if (index == 0) {
            return Column(
              children: [
                ListTile(
                  title: Text(
                      '${widget.currentuser.nombres} ${widget.currentuser.apellidos}'),
                  subtitle: Text(
                      '${widget.currentuser.correo} \n${widget.currentuser.cedula}'),
                  trailing: Icon(Icons.person),
                  onTap: () {
                    print(userinfo.correo);
                    prefs.currentProfile = true;
                    prefs.profileID = userinfo.correo;
                    prefs.profileName =
                        '${userinfo.nombres} ${userinfo.apellidos}';
                    Navigator.of(context).pushNamedAndRemoveUntil(
                        '/', (Route<dynamic> route) => false);
                    print('Im that bitch');
                  },
                ),
                Divider(
                  color: Colors.grey,
                )
              ],
            );
          } else {
            return Column(
              children: [
                ListTile(
                  title: Text(data[index - 1].nombreNegocio),
                  subtitle: Text(
                      '${data[index - 1].idNegocio} \n${data[index - 1].rolDoctor}'),
                  trailing: Icon(Icons.business),
                  onTap: () {
                    print('Last Hore');
                    prefs.currentProfile = false;
                    prefs.profileID = data[index - 1].idNegocio;
                    prefs.profileName = data[index - 1].nombreNegocio;
                    Navigator.of(context).pushNamedAndRemoveUntil(
                        '/', (Route<dynamic> route) => false);
                  },
                ),
                Divider(
                  color: Colors.grey,
                )
              ],
            );
          }
        });
  }

  Widget _draweHeader() {
    return SliverToBoxAdapter(
      child: DrawerHeader(
        child: Container(
            child: Image(
          image: AssetImage('assets/logo.png'),
        )),
        decoration: BoxDecoration(
          color: Colors.white,
        ),
      ),
    );
  }

  _divider() {
    return SliverToBoxAdapter(
      child: Divider(
        thickness: 1.2,
        indent: 5.5,
      ),
    );
  }

  _labelPerfiles() {
    return SliverToBoxAdapter(
      child: AutoScrollTag(
        index: 1,
        controller: controller,
        key: ValueKey(1),
        child: Container(
          child: Column(
            children: [
              Text(
                'Perfil Actual'.toUpperCase(),
                style: TextStyle(fontWeight: FontWeight.w500),
              ),
              GestureDetector(
                onTap: () => _scrollToIndex(1),
                child: new CardExpansionPanel(
                  // subtitle: '',
                  headerData:
                      '${prefs.profileName}\n${prefs.profileID}', //('${widget.currentuser.openUserTrabajos.length}00'),
                  icon: Icons.supervised_user_circle,
                  iconColor: Colors.blueGrey,
                  lista: listaPerfiles(
                    widget.currentuser,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _drugs() {
    return SliverToBoxAdapter(
      child: widget.currentuser.tipoUsuario == 'D'
          ? ListTile(
              leading: Icon(MdiIcons.pill),
              title: Text('Medicinas'),
              onTap: () => {
                showSearch(context: context, delegate: DrogSearch()),
                // Navigator.pushNamed(context,'medicinas')
              },
            )
          : Container(),
    );
  }

  _repository(PDFProviderPatients pdfProvider,
      PreferenciasUsuario currentUserData, PDFProviderByUser pdfUser) {
    DataProvider dataProvider = DataProvider();
    return SliverToBoxAdapter(
      child: Column(
        children: [
          widget.currentuser.tipoUsuario == 'D'
              ? ListTile(
                  leading: Icon(Icons.settings),
                  title: Text('Repositorio'),
                  onTap: () => {
                    pdfProvider.listarRecetasPacientes(prefs.currentCorreo),
                    PDFCitaCtrl.listarPDFPatients(prefs.currentCorreo),
                    Navigator.of(context).pushNamed('repositorio')
                  },
                )
              : ListTile(
                  leading: Icon(Icons.settings),
                  title: Text('Repositorio'),
                  onTap: () => {
                    pdfUser.listarRecetasPacientes(prefs.currentCorreo),
                    PDFCitaCtrl.listarPDFRepositoryPatients(
                        prefs.currentCorreo),
                    Navigator.of(context).pushNamed('repositorioUser')
                  },
                ),
          ListTile(
            leading: Icon(Icons.border_color),
            title: Text('Configuración del Perfil'),
            onTap: () => {
              // docProv.listarDoctores(),
              Navigator.pushNamed(context, 'settings',
                  arguments: prefs.profileID),
            },
          ),
          FutureBuilder(
              future: dataProvider.isSuperUser(prefs.currentCorreo),
              builder: (context, AsyncSnapshot<bool> snapshot) {
                if (snapshot.hasData) {
                  if (snapshot.data) {
                    return ListTile(
                      leading: Icon(Icons.admin_panel_settings_outlined),
                      title: Text('Administrar Perfiles Medicos'),
                      onTap: () {
                        // docProv.listarDoctores(),
                        Navigator.pushNamed(context, 'adminDocProfiles',
                            arguments: prefs.profileID);
                      },
                    );
                  } else {
                    return Container();
                  }
                } else {
                  return Container();
                }
              }),
          widget.currentuser.tipoUsuario == 'D'
              ? ListTile(
                  leading: Icon(Icons.list),
                  title: Text('Lista Pacientes'),
                  onTap: () => Navigator.pushNamed(context, 'patients'),
                )
              : Container(),
          ListTile(
            leading: Icon(Icons.exit_to_app),
            title: Text('Cerrar Sesión'),
            onTap: () {
              currentUserData.resetCurrentUserData().then((value) {
                CurrentUsuarios.clearItems();
                Navigator.of(context).pushNamedAndRemoveUntil(
                    '/', (Route<dynamic> route) => false);
              });
            },
          ),
        ],
      ),
    );
  }
}
