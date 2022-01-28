enum TipoAtendimento { DOMICILO, ESTABELECIMENTO, AMBOS }

String tipoAtendimentoToString(TipoAtendimento t) {
  return '$t'.split('.').last;
}

TipoAtendimento tipoAtendimentoFromString(String s) {
  return TipoAtendimento.values
      .firstWhere((v) => tipoAtendimentoToString(v) == s);
}
