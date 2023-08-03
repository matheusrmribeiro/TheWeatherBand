class CityEntity {
  CityEntity({required this.id, required this.uf, required this.name});

  final int id;
  final String uf;
  final String name;

  Map<String, dynamic> toJson() => {"id": id, "name": name, "uf": uf};

  static CityEntity? mapper(Map<String, dynamic>? response) => (response == null)
      ? null
      : CityEntity(
          id: response["id"],
          name: response["name"],
          uf: response["uf"],
        );
}
