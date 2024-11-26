import 'dart:io';
import 'package:flutter/services.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelper {
  static Database? _database;

  // Função para obter o caminho do banco de dados
  static Future<String> _getDatabasePath() async {
    final databasesPath = await getDatabasesPath();
    return join(databasesPath, 'BDD/BDD');
  }

  // Função para inicializar o banco de dados
  static Future<Database> initializeDatabase() async {
    if (_database != null) {
      return _database!;
    }

    // Verifica se o banco já existe no dispositivo
    String path = await _getDatabasePath();
    bool dbExists = await databaseExists(path);

    if (!dbExists) {
      // Se o banco não existir, copia da pasta assets
      await _copyDatabaseFromAssets(path);
    }

    // Abre ou cria o banco de dados
    _database = await openDatabase(path);
    return _database!;
  }

  // Função para copiar o banco de dados da pasta assets
  static Future<void> _copyDatabaseFromAssets(String path) async {
    // Carrega o banco de dados de assets
    final ByteData data = await rootBundle.load('BDD/BDD');
    final List<int> bytes = data.buffer.asUint8List();

    // Cria o arquivo no caminho do dispositivo
    await File(path).writeAsBytes(bytes);
  }
}