enum ComoConheceu {
  PLAY_STORE,
  APPLE_STORE,
  GOOGLE,
  INSTAGRAM,
  FACEBOOK,
  SITE,
  PROFISSIONAL,
  VISITA,
  OUTRO
}

String comoConheceuToString(ComoConheceu t) {
  return '$t'.split('.').last;
}

ComoConheceu comoConheceuFromString(String s) {
  return ComoConheceu.values.firstWhere((v) => comoConheceuToString(v) == s);
}
