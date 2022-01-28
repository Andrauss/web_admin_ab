enum TipoEmpresa { AUTONOMO, CNPJ, ALL }

String tipoEmpresaToString(TipoEmpresa t) {
  return '$t'.split('.').last;
}

TipoEmpresa tipoEmpresaFromString(String s) {
  return TipoEmpresa.values.firstWhere((v) => tipoEmpresaToString(v) == s);
}
