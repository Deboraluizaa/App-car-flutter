import 'dart:io';
import 'package:flutter/material.dart';
import '../image_viewer.dart'; // Verifique se o caminho está correto
import '../models/mileage_record.dart';
import '../services/database_helper.dart';
import 'add_record_screen.dart';

// Definindo o tema global para o aplicativo
final ThemeData themeData = ThemeData(
  primaryColor: Colors.black,
  scaffoldBackgroundColor: Colors.black,
  appBarTheme: AppBarTheme(
    color: Colors.black,
  ),
  textTheme: const TextTheme(
    bodyLarge: TextStyle(color: Colors.white),
    bodyMedium: TextStyle(color: Colors.white),
  ),
  buttonTheme: ButtonThemeData(
    buttonColor: Colors.yellow,
    textTheme: ButtonTextTheme.primary,
  ),
  colorScheme: ColorScheme.fromSwatch().copyWith(secondary: Colors.yellow),
);

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late Future<List<MileageRecord>> _recordsFuture;

  @override
  void initState() {
    super.initState();
    _loadRecords(); // Carrega os registros na inicialização
  }

  void _loadRecords() {
    setState(() {
      _recordsFuture = DatabaseHelper().getRecords(); // Atualiza os registros
    });
  }

  void _deleteRecord(int id) async {
    await DatabaseHelper().deleteRecord(id); // Exclui o registro
    _loadRecords(); // Recarrega a lista de registros
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Controle de Quilometragem'),
      ),
      body: FutureBuilder<List<MileageRecord>>(
        future: _recordsFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator()); // Carregando
          } else if (snapshot.hasError) {
            return Center(child: Text('Erro: ${snapshot.error}')); // Erro
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('Nenhum registro encontrado.')); // Sem dados
          }

          final records = snapshot.data!;

          return ListView.builder(
            itemCount: records.length,
            itemBuilder: (context, index) {
              final record = records[index];
              return ListTile(
                title: Text('Quilometragem: ${record.mileage}'),
                subtitle: Text('Motorista: ${record.driver}\nDestino: ${record.destination}'),
                leading: record.photoPath.isNotEmpty
                    ? SizedBox(
                        width: 60, // Definindo largura fixa para o ícone de imagem
                        height: 60, // Definindo altura fixa para o ícone de imagem
                        child: Image.file(
                          File(record.photoPath),
                          fit: BoxFit.cover, // Ajusta a imagem para cobrir o espaço disponível
                        ),
                      )
                    : null,
                trailing: IconButton(
                  icon: Icon(Icons.delete, color: Colors.red),
                  onPressed: () => _showDeleteConfirmationDialog(record.id),
                ),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ImageViewer(photoPath: record.photoPath),
                    ),
                  );
                },
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => AddRecordScreen(),
            ),
          ).then((_) {
            _loadRecords(); // Atualiza a lista após a navegação de retorno
          });
        },
      ),
    );
  }

  void _showDeleteConfirmationDialog(int id) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Excluir Registro'),
          content: Text('Você tem certeza que deseja excluir este registro?'),
          actions: <Widget>[
            TextButton(
              child: Text('Cancelar'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text('Excluir'),
              onPressed: () {
                _deleteRecord(id); // Exclui o registro
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}

