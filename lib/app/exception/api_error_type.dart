/// Tipos de erro tratados pela Api do Agenda Beauty
enum ApiErrorType {
  RESOURCE_NOT_FOUND,
  UNSUPPORTED_VERSION,
  INSUFFICIENT_PERMISSION,
  HORARIO_INDISPONIVEL,
  STATUS_CHANGED,
  CLIENTE_BLOCKED,
  ENDERECO_REQUIRED,
  USER_DISABLED,
  USER_NOT_VERIFIED,
  TIPO_ATENDIMENTO_UNAVAILABLE,
  SERVICO_INDISPONIVEL
}

String apiErrorTypeToString(ApiErrorType t) {
  return '$t'.split('.').last;
}

ApiErrorType apiErrorTypeFromString(String s) {
  return ApiErrorType.values.firstWhere((v) => apiErrorTypeToString(v) == s);
}
