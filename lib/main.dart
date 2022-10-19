import 'package:breakingbad/app_router.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(breakingBadApp(appRouter: AppRouter(),));
}

class breakingBadApp extends StatelessWidget {
  final AppRouter appRouter;

   breakingBadApp({Key? key,required this.appRouter}) : super(key: key);
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {

    return MaterialApp(
    debugShowCheckedModeBanner: false,
      onGenerateRoute: appRouter.generateRoute,
    );
  }

}
