import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'circle_button.dart';
// import 'package:flutter/material.dart';

class ProfileAppBar extends StatefulWidget {
  ProfileAppBar({Key key}) : super(key: key);

  @override
  _ProfileAppBarState createState() => _ProfileAppBarState();
}

class _ProfileAppBarState extends State<ProfileAppBar> {
  @override
  Widget build(BuildContext context) {
    // final Publicacion publicacion = ModalRoute.of(context).settings.arguments;
    final _screenSize = MediaQuery.of(context).size;
    return SliverAppBar(
      elevation: 2.0,
      expandedHeight: _screenSize.height * 0.45,
      brightness: Brightness.dark,
      backgroundColor: Colors.indigoAccent,
      pinned: false,
      flexibleSpace: FlexibleSpaceBar(
        centerTitle: false,
        titlePadding: EdgeInsets.fromLTRB(20, 50, 100, 5),
        title: Text(
          'Freddy Murillo',
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
            Image(image: AssetImage('assets/fondo.jpg'),fit: BoxFit.cover,),
            // FadeInImage(
            //   image: NetworkImage(
            //       'https://www.webdesignerdepot.com/cdn-origin/uploads/2013/06/featured48.jpg'),
            //   // image: NetworkImage('https://images.vexels.com/media/users/3/772/preview2/75138e91581bc09618e7080f19a576aa-abstract-wavy-background-vector.jpg'),
            //   placeholder: AssetImage('assets/loading.gif'),
            //   fit: BoxFit.fill,
            // ),
            Table(
              // border: TableBorder.all(),
              children: [
                TableRow(children: [
                  Container(
                    height: _screenSize.height * 0.08,
                  ),
                  Container()
                ]),
                seccion1(_screenSize, context),
                seccion2(_screenSize, context),
              ],
            ),
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

  TableRow seccion1(Size screensize, BuildContext context) {
    return TableRow(children: [
      Center(
        child: Container(
          height: screensize.height * 0.2,
          width: screensize.width * 0.4,
          decoration: BoxDecoration(
            border: Border.all(width: 5, color: Colors.blueGrey.shade100),
            borderRadius: BorderRadius.circular(100.0),
            color: Colors.white,
          ),
          child: ClipRRect(
            child: FadeInImage(
              image: NetworkImage(
                  'https://images8.alphacoders.com/897/thumb-1920-897232.jpg'),
              placeholder: AssetImage('assets/loading.gif'),
              fit: BoxFit.cover,
            ),
            borderRadius: BorderRadius.circular(100.0),
          ),
        ),
      ),
      Center(
        child: Container(
          height: screensize.height * 0.20,
          width: screensize.width * 0.3,
          child: Column(
            children: [
              RichText(
                  text: TextSpan(
                      style: DefaultTextStyle.of(context).style,
                      children: <TextSpan>[
                    TextSpan(
                        text: 'Favoritos',
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 17.0))
                  ])),
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(40.0),
                    color: Colors.white,
                    border:
                        Border.all(width: 5, color: Colors.blueGrey.shade100),
                  ),
                  child: ClipRRect(
                    child: FadeInImage(
                      image: NetworkImage(
                          'https://www.clinicablancohungria.es/wp-content/uploads/2018/05/extraccion.jpg'),
                      placeholder: AssetImage('assets/loading.gif'),
                      fit: BoxFit.cover,
                    ),
                    borderRadius: BorderRadius.circular(40.0),
                  ),
                ),
              ),
              RichText(
                  text: TextSpan(
                      style: DefaultTextStyle.of(context).style,
                      children: <TextSpan>[
                    TextSpan(
                        text: 'Extraccion',
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 15.0))
                  ])),
            ],
          ),
        ),
      ),
    ]);
  }

  TableRow seccion2(Size screensize, BuildContext context) {
    return TableRow(children: [
      Container(
        child: Center(
          child: Column(
            children: [
              SizedBox(
                height: screensize.height * 0.01,
              ),
              Text(
                '',
                style: TextStyle(color: Colors.white),
              ),
              SizedBox(
                height: screensize.height * 0.01,
              ),
              Text(
                'Manta, Manabi, Ecuador',
                style: TextStyle(color: Colors.white),
              ),
              SizedBox(
                height: screensize.height * 0.01,
              ),
              ShaderMask(
                shaderCallback: (rect) => LinearGradient(colors: [
                  Color(0xFFCDDC39),
                  Color(0xFF4BCB1F),
                  Color(0xFF1777F2)
                ]).createShader(rect),
                child: RaisedButton(
                  onPressed: () {},
                  child: Text('Seguir'),
                ),
              ),
            ],
          ),
        ),
      ),
      Container(
        child: Center(
          child: Container(
            height: screensize.height * 0.18,
            width: screensize.width * 0.28,
            child: Column(
              children: [
                SizedBox(
                  height: screensize.height * 0.02,
                ),
                Container(
                  height: screensize.height * 0.13,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(40.0),
                    color: Colors.white,
                    border:
                        Border.all(width: 5, color: Colors.blueGrey.shade100),
                  ),
                  child: ClipRRect(
                    child: FadeInImage(
                      image: NetworkImage(
                          'https://www.clinicablancohungria.es/wp-content/uploads/2018/05/extraccion.jpg'),
                      placeholder: AssetImage('assets/loading.gif'),
                      fit: BoxFit.cover,
                    ),
                    borderRadius: BorderRadius.circular(40.0),
                  ),
                ),
                RichText(
                    text: TextSpan(
                        style: DefaultTextStyle.of(context).style,
                        children: <TextSpan>[
                      TextSpan(
                          text: 'Curacion',
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 15.0))
                    ])),
              ],
            ),
          ),
        ),
      )
    ]);
  }
}
