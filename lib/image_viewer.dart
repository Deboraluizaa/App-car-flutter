import 'package:flutter/material.dart';
import 'dart:io';

class ImageViewer extends StatelessWidget {
  final String photoPath;

  ImageViewer({required this.photoPath});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Visualizar Foto')),
      body: Center(
        child: photoPath.isEmpty
            ? Text('Nenhuma foto disponível.')
            : Image.file(File(photoPath)),
      ),
    );
  }
}
