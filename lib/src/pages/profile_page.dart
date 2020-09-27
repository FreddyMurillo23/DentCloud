import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:muro_dentcloud/src/models/publications_model.dart';
import 'package:muro_dentcloud/src/widgets/cards_stories.dart';
import 'package:muro_dentcloud/src/widgets/circle_button.dart';
import 'package:muro_dentcloud/src/widgets/create_post_container.dart';
import 'package:muro_dentcloud/src/widgets/drawer_appbar.dart';
import 'package:muro_dentcloud/src/widgets/horizontal_scroll_view.dart';

import '../../palette.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _screenSize = MediaQuery.of(context).size;
    final datauser = ModalRoute.of(context).settings.arguments;
    return Scaffold(
      drawer: NavDrawer(),
      body: CustomScrollView(
        slivers: [
          _crearAppbar(datauser,_screenSize,context),
          SliverPadding(
            padding: const EdgeInsets.fromLTRB(0.0, 10.0, 0.0, 5.0),
            sliver: SliverToBoxAdapter(
              child: Rooms(),
            ),
          ),
          //   SliverPadding(
          //   padding: const EdgeInsets.fromLTRB(0.0, 5.0, 0.0, 5.0),
          //   sliver: SliverToBoxAdapter(
          //     child: Stories(
          //       //currentUser: currentUser,
          //       // stories: stories,
          //     ),
          //   ),
          // ),
        ],
      ),
    );
  }

  _crearAppbar(Object datauser,Size screensize,BuildContext context) {
    return SliverAppBar(
      elevation: 2.0,
      expandedHeight: screensize.height*0.45,
      brightness: Brightness.dark,
      backgroundColor: Colors.indigoAccent,
      pinned: false,
      flexibleSpace: FlexibleSpaceBar(
        centerTitle: false,
        title: Text(
        'DentCloud',
        style: const TextStyle(
          color: Colors.white,
          fontSize: 16.0,
          fontWeight: FontWeight.bold,
          letterSpacing: -1.2,
        ),
      ),
      background: Container(
        child: Stack(
          fit: StackFit.expand,
          children: [
            FadeInImage(
              image: NetworkImage('https://www.webdesignerdepot.com/cdn-origin/uploads/2013/06/featured48.jpg'),
              // image: NetworkImage('https://images.vexels.com/media/users/3/772/preview2/75138e91581bc09618e7080f19a576aa-abstract-wavy-background-vector.jpg'),
              placeholder: AssetImage('assets/loading.gif'),
              fit: BoxFit.fill,
            ),
            Table(
              border: TableBorder.all(),
              children: [
                TableRow(
                  children: [
                    Container(height: screensize.height*0.08,),Container()
                  ]
                ),
                TableRow(children: [
                  Center(
                    child: Container(
                      height: screensize.height*0.2,
                      width: screensize.width*0.4,
                        decoration: BoxDecoration(border: Border.all(width:5,color: Colors.blueGrey.shade100),
                          borderRadius: BorderRadius.circular(100.0),
                          color: Colors.white,
                          ),
                      child: ClipRRect(
                         child: FadeInImage(
                           image: NetworkImage('https://images8.alphacoders.com/897/thumb-1920-897232.jpg'),
                           placeholder: AssetImage('assets/loading.gif'),
                           fit: BoxFit.cover,
                         ),
                         borderRadius: BorderRadius.circular(100.0),
                        ),
                    ),
                  ),
                  Center(
                    child: Container(
                      height: screensize.height*0.20,
                      width: screensize.width*0.3,
                      child: Column(
                        children: [
                          RichText(text: TextSpan(
                            style: DefaultTextStyle.of(context).style,
                            children:<TextSpan>[
                            TextSpan(
                              text: 'Mas Frecuentes',
                              style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 15.0 )
                            )
                          ] )),
                          Expanded(
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(40.0),
                                color: Colors.white,
                                border: Border.all(width:5,color: Colors.blueGrey.shade100),
                                ),
                              child: ClipRRect(
                               child: FadeInImage(
                                 image: NetworkImage('https://www.clinicablancohungria.es/wp-content/uploads/2018/05/extraccion.jpg'),
                                 placeholder: AssetImage('assets/loading.gif'),
                                 fit: BoxFit.cover,
                               ),
                               borderRadius: BorderRadius.circular(40.0),
                              ),
                            ),
                          ),
                            RichText(text: TextSpan(
                            style: DefaultTextStyle.of(context).style,
                            children:<TextSpan>[
                            TextSpan(
                              text: 'Extraccion',
                              style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 15.0 )
                            )
                          ] )),
                        ],
                      ),
                    ),
                  ),
                  
                ]),
                TableRow(
                  children: [
                    Container(
                      child: Center(
                        child: Column(
                          children: [
                            Text('Freddy Murillo'),
                            Text('Manta, Manabi, Ecuador'),
                            OutlineButton(
                              onPressed: (){
                                
                              },
                              child: Text('Seguir'),
                              
                            ),
                          ],
                        ),
                      ),
                    ),
                    Container(
                      child: Center(
                    child: Container(
                      height: screensize.height*0.18,
                      width: screensize.width*0.28,
                      child: Column(
                        children: [
                          SizedBox(height: screensize.height*0.02,),
                          Container(
                            height: screensize.height*0.13,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(40.0),
                                color: Colors.white,
                                border: Border.all(width:5,color: Colors.blueGrey.shade100),
                                ),
                              child: ClipRRect(
                               child: FadeInImage(
                                 image: NetworkImage('https://www.clinicablancohungria.es/wp-content/uploads/2018/05/extraccion.jpg'),
                                 placeholder: AssetImage('assets/loading.gif'),
                                 fit: BoxFit.cover,
                               ),
                               borderRadius: BorderRadius.circular(40.0),
                              ),
                            ),
                          
                            RichText(text: TextSpan(
                            style: DefaultTextStyle.of(context).style,
                            children:<TextSpan>[
                            TextSpan(
                              text: 'Curacion',
                              style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 15.0 )
                            )
                          ] )),
                        ],
                      ),
                    ),
                  ),
                    )
                  ]
                )

              
            ],),
          ],
        )
        // 
      ),
      ),
      
      centerTitle: false,
      floating: false,
      actions: [

        CircleButton(
          icon: MdiIcons.facebookMessenger,
          iconsize: 30.0,
          onPressed: () => print('Messenger'),
        )
      ],
      
    );
  }
}



// Row(
//           children: <Widget>[
//             Column(
//               children: <Widget>[
//               Container(
//                 
//                 child: ClipRRect(
//                   child: FadeInImage(
//                     image: NetworkImage('https://images8.alphacoders.com/897/thumb-1920-897232.jpg'),
//                     placeholder: AssetImage('assets/loading.gif'),
//                     fit: BoxFit.cover,
//                   ),
//                   borderRadius: BorderRadius.circular(100.0),
//                 ),
//               )
//             ],
//             ),
//             Column(
//               children: <Widget>[
//                 Container(
//                 height: screensize.height*0.2,
//                 width: screensize.width*0.4,
//                 child: ClipRRect(
//                   child: FadeInImage(
//                     image: NetworkImage('https://images8.alphacoders.com/897/thumb-1920-897232.jpg'),
//                     placeholder: AssetImage('assets/loading.gif'),
//                     fit: BoxFit.cover,
//                   ),
//                   borderRadius: BorderRadius.circular(100.0),
//                 ),
//               )
//               ],
//             ) 
//           ],
//         )