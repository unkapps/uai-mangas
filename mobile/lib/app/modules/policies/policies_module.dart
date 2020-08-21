import 'package:flutter_modular/flutter_modular.dart';
import 'package:leitor_manga/app/modules/policies/dmca/dmca.dart';
import 'package:leitor_manga/app/modules/policies/policies_routes.dart';

class PoliciesModule extends ChildModule {
  @override
  List<Bind> get binds => [];

  @override
  List<Router> get routers => [
        Router(PoliciesRoutes.DMCA_RELATIVE, child: (_, args) => DMCA()),
      ];

  static Inject get to => Inject<PoliciesModule>.of();
}
