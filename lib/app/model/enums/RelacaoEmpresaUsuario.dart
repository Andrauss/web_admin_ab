enum RelacaoEmpresaUsuario { ADMIN, FUNCIONARIO }

String relacaoEmpresaUsuarioToString(RelacaoEmpresaUsuario t) {
  return '$t'.split('.').last;
}

RelacaoEmpresaUsuario relacaoEmpresaUsuarioFromString(String s) {
  return RelacaoEmpresaUsuario.values
      .firstWhere((v) => relacaoEmpresaUsuarioToString(v) == s);
}
