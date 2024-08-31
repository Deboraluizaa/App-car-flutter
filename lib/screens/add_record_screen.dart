import 'dart:io';
import 'package:flutter/material.dart';
import '../models/mileage_record.dart';
import '../services/database_helper.dart';
import '../helpers/image_helper.dart';

class AddRecordScreen extends StatefulWidget {
  @override
  _AddRecordScreenState createState() => _AddRecordScreenState();
}

class _AddRecordScreenState extends State<AddRecordScreen> {
  final _mileageController = TextEditingController();
  final _driverController = TextEditingController();
  final _destinationController = TextEditingController();
  File? _imageFile;

  Future<void> _takePhoto() async {
    try {
      final imageHelper = ImageHelper();
      final image = await imageHelper.pickImage();
      setState(() {
        _imageFile = image;
      });
    } catch (e) {
      // Exibir uma mensagem de erro se a captura da imagem falhar
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Erro ao capturar imagem: $e')),
      );
    }
  }

  Future<int> _generateId() async {
    final db = await DatabaseHelper().database;
    final List<Map<String, dynamic>> result = await db.rawQuery('SELECT MAX(id) + 1 as id FROM mileage_records');
    return result.first['id'] ?? 1;
  }

  Future<void> _saveRecord() async {
    final mileage = _mileageController.text.trim();
    final driver = _driverController.text.trim();
    final destination = _destinationController.text.trim();
    final photoPath = _imageFile?.path ?? '';

    // Validação: Verifica se os campos obrigatórios estão preenchidos
    if (mileage.isEmpty || driver.isEmpty || destination.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Por favor, preencha todos os campos.')),
      );
      return;
    }

    try {
      final id = await _generateId();

      final record = MileageRecord(
        id: id,
        mileage: mileage,
        driver: driver,
        destination: destination,
        photoPath: photoPath,
      );

      await DatabaseHelper().insertRecord(record);

      // Exibe uma mensagem de sucesso
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Registro salvo com sucesso!')),
      );

      Navigator.pop(context);
    } catch (e) {
      // Exibe uma mensagem de erro
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Erro ao salvar registro: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Adicionar Registro')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView( // Permite rolar a tela caso o teclado apareça
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextField(
                controller: _mileageController,
                decoration: InputDecoration(labelText: 'Quilometragem'),
                keyboardType: TextInputType.number, // Tipo de teclado numérico
              ),
              TextField(
                controller: _driverController,
                decoration: InputDecoration(labelText: 'Motorista'),
              ),
              TextField(
                controller: _destinationController,
                decoration: InputDecoration(labelText: 'Destino'),
              ),
              SizedBox(height: 16),
              _imageFile == null
                  ? Text('Nenhuma foto selecionada.')
                  : Image.file(_imageFile!),
              ElevatedButton(
                onPressed: _takePhoto,
                child: Text('Tirar Foto'),
              ),
              SizedBox(height: 16),
              ElevatedButton(
                onPressed: _saveRecord,
                child: Text('Salvar Registro'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
