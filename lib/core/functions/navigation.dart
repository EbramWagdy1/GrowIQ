  import 'package:go_router/go_router.dart';

Future<dynamic> customNavigate(dynamic context, String path) {
  return GoRouter.of(context).push(path);
}


void customReplacementNavigate( dynamic context , String path) {
     GoRouter.of(context).pushReplacement(path);
  }

void customPop(dynamic context, {dynamic result}) {
  GoRouter.of(context).pop(result);
}