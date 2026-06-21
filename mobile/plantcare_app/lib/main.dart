import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:plantcare_app/core/theme/app_theme.dart';
import 'package:plantcare_app/data/services/auth_service.dart';
import 'package:plantcare_app/data/services/token_service.dart';
import 'package:plantcare_app/presentation/auth/bloc/auth_bloc.dart';
import 'package:plantcare_app/presentation/auth/screens/login_screen.dart';
import 'package:plantcare_app/presentation/auth/screens/register_screen.dart';

void main() {
  runApp(const PlantCareApp());
}

class PlantCareApp extends StatelessWidget {
  const PlantCareApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => AuthBloc(AuthService(), TokenService()),
      child: MaterialApp(
        title: 'PlantCare',
        debugShowCheckedModeBanner: false,
        theme: AppTheme.lightTheme,
        initialRoute: '/login',
        routes: {
          '/login': (_) => const LoginScreen(),
          '/register': (_) => const RegisterScreen(),
          '/home': (_) => const Scaffold(
                body: Center(child: Text('Home — em breve')),
              ),
        },
      ),
    );
  }
}
