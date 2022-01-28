/// Identifica a origem do agendamento
///
/// APP - Cadastrado por um usuário do app
/// MANUAL - Cadastrado pelo Salão/Profissional
enum TipoAgendamento { MANUAL, APP }

String tipoAgendamentoToString(TipoAgendamento t) {
  return '$t'.split('.').last;
}

TipoAgendamento tipoAgendamentoFromString(String s) {
  return TipoAgendamento.values
      .firstWhere((v) => tipoAgendamentoToString(v) == s);
}
