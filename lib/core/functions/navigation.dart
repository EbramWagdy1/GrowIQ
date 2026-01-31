  import 'package:go_router/go_router.dart';

void customNavigate( dynamic context , String path) {
     GoRouter.of(context).push(path);
  }


void customReplacementNavigate( dynamic context , String path) {
     GoRouter.of(context).pushReplacement(path);
  }