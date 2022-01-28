class Horario {
  Horario({
    this.diaSemana,
    this.expediente,
    this.horaInicio,
    this.horaFim,
    this.intervalo,
    this.intervaloInicio,
    this.intervaloFim,
  });

  int? diaSemana;
  bool? expediente;
  String? horaInicio;
  String? horaFim;
  String? intervalo;
  String? intervaloInicio;
  String? intervaloFim;

  factory Horario.fromJson(Map<String, dynamic> json) => Horario(
        diaSemana: json["diaSemana"],
        expediente: json["expediente"],
        horaInicio: json["horaInicio"] == null ? null : json["horaInicio"],
        horaFim: json["horaFim"] == null ? null : json["horaFim"],
        intervalo: json["intervalo"] == null ? null : json["intervalo"],
        intervaloInicio:
            json["intervaloInicio"] == null ? null : json["intervaloInicio"],
        intervaloFim:
            json["intervaloFim"] == null ? null : json["intervaloFim"],
      );

  Map<String, dynamic> toJson() => {
        "diaSemana": diaSemana,
        "expediente": expediente,
        "horaInicio": horaInicio == null ? null : horaInicio,
        "horaFim": horaFim == null ? null : horaFim,
        "intervalo": intervalo == null ? null : intervalo,
        "intervaloInicio": intervaloInicio == null ? null : intervaloInicio,
        "intervaloFim": intervaloFim == null ? null : intervaloFim,
      };
}
