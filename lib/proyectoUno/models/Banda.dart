class Banda{
  String name;
  String id;
  int voto;

  Banda({required this.name, required this.id, required this.voto});

  factory Banda.isfromMap(Map<String, dynamic> obj) =>
      Banda(
          name: obj["name"],
          id: obj["id"],
          voto: obj["voto"]
      );
}