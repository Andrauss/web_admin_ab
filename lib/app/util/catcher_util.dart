import 'package:agenda_beauty_online/app/security/AuthStore.dart';
import 'package:catcher/catcher.dart';

class CatcherUtil {
  static catchError(dynamic exception, dynamic stackTrace) async {
    final user = await AuthStore.getUsuario();

    final userData =
        "[id: ${user!.id}, email: ${user.preferredEmail}, name: ${user.name}]";

    Catcher.reportCheckedError("$userData - $exception", stackTrace);
  }
}
