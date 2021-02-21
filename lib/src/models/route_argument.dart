class RouteArgument {
  String id;
  String heroTag;
  dynamic param;
  String image;
  String parentId;

  RouteArgument({this.id, this.heroTag, this.param, this.image,this.parentId});

  @override
  String toString() {
    return '{id: $id, heroTag:${heroTag.toString()}}';
  }
}
