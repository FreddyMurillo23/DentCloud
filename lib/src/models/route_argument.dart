class RouteArgument {
  String id;
  String heroTag;
  List<dynamic> list;
  String ruc;

  dynamic param;
  String image;
  String parentId;

  RouteArgument({this.id, this.ruc, this.list,this.heroTag, this.param, this.image,this.parentId});

  @override
  String toString() {
    return '{id: $id, heroTag:${heroTag.toString()}}';
  }
}
