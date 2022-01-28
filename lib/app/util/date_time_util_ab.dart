class DateUtilsAB {
  static bool isToday(DateTime d1) {
    return isSameDay(d1, DateTime.now());
  }

  static bool isSameDay(DateTime d1, DateTime d2) {
    final date1 = DateTime(d1.year, d1.month, d1.day);
    final date2 = DateTime(d2.year, d2.month, d2.day);
    return date1 == date2;
  }

  static String getAsYYYYMMDD(DateTime data) {
    return data.toIso8601String().split('T').first;
  }

  static isAntesHorario(DateTime dataInicio, String inicioAtendimento) {
    final date1 = createFrom(dataInicio, inicioAtendimento);
    return dataInicio.isBefore(date1);
  }

  static isDepoisHorario(DateTime dataFim, String fimAtendimento) {
    final date1 = createFrom(dataFim, fimAtendimento);
    return date1.isBefore(dataFim);
  }

  static DateTime createFrom(DateTime dia, String horario) {
    final horaParts = horario.split(':');
    return DateTime(
      dia.year,
      dia.month,
      dia.day,
      int.parse(horaParts.first),
      int.parse(horaParts.last),
    );
  }

  static DateTime clear(DateTime dia) {
    return DateTime(
      dia.year,
      dia.month,
      dia.day,
      dia.hour,
      dia.minute,
    );
  }

  static isBetween(DateTime data, DateTime dataIni, DateTime dataFim) {
    final sanitizedData = clear(data);

    return (sanitizedData == dataIni ||
        (sanitizedData.isAfter(dataIni) && sanitizedData.isBefore(dataFim)));
  }

  static DateTime getFomDDMMYYYY(String value) {
    final datePats = value.split("/");
    return DateTime(
      int.parse(datePats[2]),
      int.parse(datePats[1]),
      int.parse(datePats[0]),
    );
  }
}
