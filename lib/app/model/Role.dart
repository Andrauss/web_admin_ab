class Role {
  Role({
    this.name,
    this.description,
  });

  Name? name;
  Description? description;

  factory Role.fromJson(Map<String, dynamic> json) => Role(
        name: nameValues.map![json["name"]],
        description: descriptionValues.map![json["description"]],
      );

  Map<String, dynamic> toJson() => {
        "name": nameValues.reverse![name],
        "description": descriptionValues.reverse![description],
      };
}

enum Description {
  USUARIO_QUE_POSSUI_EMPRESA_OU_E_UM_PROFISSIONAL,
  USUARIO_COMUM_DA_PLATAFORMA
}

final descriptionValues = EnumValues({
  "Usuario comum da plataforma": Description.USUARIO_COMUM_DA_PLATAFORMA,
  "Usuario que possui empresa ou e um profissional":
      Description.USUARIO_QUE_POSSUI_EMPRESA_OU_E_UM_PROFISSIONAL
});

enum Name { ROLE_PROFESSIONAL, ROLE_USER }

final nameValues = EnumValues(
    {"ROLE_PROFESSIONAL": Name.ROLE_PROFESSIONAL, "ROLE_USER": Name.ROLE_USER});

class EnumValues<T> {
  Map<String, T>? map;
  Map<T, String>? reverseMap;

  EnumValues(this.map);

  Map<T, String>? get reverse {
    if (reverseMap == null) {
      reverseMap = map?.map((k, v) => new MapEntry(v, k));
    }
    return reverseMap;
  }
}
