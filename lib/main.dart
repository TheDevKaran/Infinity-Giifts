import 'package:flutter/material.dart';
import 'package:lastminutegift/common/widgets/bottom_bar.dart';
import 'package:lastminutegift/constants/gloVar.dart';
import 'package:lastminutegift/features/admin/screens/admin_screen.dart';
import 'package:lastminutegift/features/auth/screens/auth_screens.dart';
import 'package:lastminutegift/features/auth/services/auth_service.dart';
import 'package:lastminutegift/features/home/screens/home_screens.dart';
import 'package:lastminutegift/providers/user_provider.dart';
import 'package:lastminutegift/router.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(create: (context)=>UserProvider(),)
  ], child: const MyApp(),));
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final AuthService authService = AuthService();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    authService.getUserData(context);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(debugShowCheckedModeBanner: false,
      title: 'Last Minute Gift',
      theme: ThemeData(appBarTheme: const AppBarTheme(elevation: 0, iconTheme: IconThemeData(color: Colors.white)),
        scaffoldBackgroundColor: GlobalVariables.backgroundColor, colorScheme: const ColorScheme.light(primary: GlobalVariables.secondaryColor)
      ),
      onGenerateRoute: (settings) => generateRoute(settings),
      home:
      Provider.of<UserProvider>(context).user.token.isNotEmpty ?
      // Provider.of<UserProvider>(context).user.token=='user'?
      const BottomBar():
      // const AdminScreen():
        const AuthScreen()
    );
  }
}


