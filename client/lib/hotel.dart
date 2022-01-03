class Hotel {
  List<dynamic> list;

  Hotel(this.list);

  factory Hotel.fromJson(dynamic json) {
    return Hotel(json['Comparison'] as List<dynamic>);
  }

  @override
  String toString() {
    return '{ ${this.list} }';
  }
}
