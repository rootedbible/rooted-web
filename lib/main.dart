import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rooted_web/bloc/organizations/organizations_bloc.dart';
import 'package:rooted_web/ui/screens/auth/splash_screen.dart';
import 'package:universal_html/html.dart';
import 'bloc/auth/auth_bloc.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    if (window.location.href.contains('close')) {
      window.close();
    }
    const workSans = TextStyle(
      fontFamily: 'WorkSans',
    );
    return MultiBlocProvider(
      providers: [
        BlocProvider<AuthBloc>(
          create: (BuildContext context) => AuthBloc()..add(CheckIfSignedIn()),
        ),
        BlocProvider<OrganizationsBloc>(
          create: (BuildContext context) => OrganizationsBloc(),
        ),
      ],
      child: MaterialApp(
        home: const SplashScreen(),
        title: 'Rooted',
        darkTheme: ThemeData(
          colorScheme: ColorScheme.fromSeed(
            seedColor: const Color.fromRGBO(1, 68, 74, 1),
            brightness: Brightness.dark,
          ),
          inputDecorationTheme: const InputDecorationTheme(
            border: OutlineInputBorder(borderSide: BorderSide()),
          ),
          useMaterial3: true,
        ),
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          fontFamily: 'WorkSans',
          textTheme: TextTheme(
            displayLarge: workSans.copyWith(
              fontSize: 24.0,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
            bodyLarge: workSans.copyWith(
              fontSize: 16.0,
              color: Colors.grey[800],
            ),
            labelLarge: workSans.copyWith(
              fontSize: 16.0,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
            titleMedium: workSans.copyWith(
              fontSize: 18.0,
              fontWeight: FontWeight.normal,
            ),
          ),
          colorScheme: ColorScheme.fromSeed(
            seedColor: const Color(0xFF475E5E),
          ).copyWith(
            primary: const Color(0xFF475E5E),
            secondary: const Color(0xFFC1A45E),
            tertiary: const Color(0xFFDFE6E4),
            background: const Color(0xFFEFEFEA),
            surface: const Color(0xFFDFE6E4),
          ),
          inputDecorationTheme: const InputDecorationTheme(
            border: OutlineInputBorder(borderSide: BorderSide()),
          ),
          useMaterial3: true,
        ),
      ),
    );
  }
}
