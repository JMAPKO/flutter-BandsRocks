class bandasRock{
  String ID;
  String name;
  int votos;

  bandasRock({required this.ID, required this.name, required this.votos});

  factory bandasRock.isFromMap(Map<String, dynamic> obj){
    return bandasRock(
        ID: obj["id"],
        name: obj["name"],
        votos: obj["votos"],
    );
  }
}