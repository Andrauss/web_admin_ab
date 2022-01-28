enum StatusAgendamento {
  AGUARDANDO,
  CONFIRMADO,
  FINALIZADO,
  REAGENDADO,
  CANCELADO
}

String statusAgendamentoToString(StatusAgendamento t) {
  return '$t'.split('.').last;
}

StatusAgendamento statusAgendamentoFromString(String s) {
  return StatusAgendamento.values
      .firstWhere((v) => statusAgendamentoToString(v) == s);
}
