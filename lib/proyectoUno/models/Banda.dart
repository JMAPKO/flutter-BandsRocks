class Banda{
  String id;
  String nAme;
  int vote;

  Banda({required this.nAme, required this.id, required this.vote});

  factory Banda.isfromMap(Map<String, dynamic> obj) =>
      Banda(
          nAme: obj.containsKey("name") ? obj["name"] : "no hay nombre", //REGLA DE SEGURIDAD, por si los modelos son diferentes (ESTO ANULA EL PROBLEMA QUE YO SUFRI)
          id: obj.containsKey("id") ? obj["id"] : "no hay id",
          vote: obj.containsKey("vote") ? obj["vote"] : "no hay votos"
      );
}