import 'package:flutter/material.dart';
import 'screens/home_screen.dart'; // Apenas este import é necessário
import 'theme.dart' as app_theme;

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Controle de Quilometragem',
      theme: app_theme.themeData,  // Use o prefixo para acessar a definição correta
      home: HomeScreen(),
    );
  }
}

