import 'package:get_it/get_it.dart';

import 'repository/empresa_perfil.dart';
import 'service/usuario_service.dart';

GetIt locator = GetIt.instance;

void setupLocator() {
  // locator.registerLazySingleton(() => NavigatorService());
  // locator.registerLazySingleton(() => NotificatorService());
  // locator.registerLazySingleton(() => NotificationStoreService());
  // locator.registerLazySingleton(() => AgendamentoService());
  // locator.registerLazySingleton(() => GrupoServicoService());
  // locator.registerLazySingleton(() => EnderecoService());
  // locator.registerLazySingleton(() => FotoServicoService());
  // locator.registerLazySingleton(() => HorarioEmpresaService());
  locator.registerLazySingleton(() => UsuarioService());
  // locator.registerLazySingleton(() => FavoritoService());
  // locator.registerLazySingleton(() => PesquisaService());
  // locator.registerLazySingleton(() => ProfissionalEmpresaService());
  // locator.registerLazySingleton(() => ProfissionalServicoService());
  locator.registerLazySingleton(() => EmpresaPerfilService());
  // locator.registerLazySingleton(() => CategoriaService());
}
