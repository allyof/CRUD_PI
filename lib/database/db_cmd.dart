import 'package:crud_projetoi_lista/database/db_config.dart';
import 'package:crud_projetoi_lista/models/contato.dart';
import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';

class ContatoComando {
  Future<Database> _getDatabase() async {
    try {
      return await DatabaseConfig.getDatabase();
    } catch (e) {
      print("Erro ao obter o banco de dados: $e");
      rethrow;
    }
  }

  Future<List<Contato>> findAll() async {
    final db = await _getDatabase();

    final List<Map<String, dynamic>> contato = await db.query('contato');

    return List.generate(contato.length, (i) {
      return Contato(
        id: contato[i]['id'],
        nome: contato[i]['nome'],
        email: contato[i]['email'],
        telefone: contato[i]['telefone'],
      );
    });
  }

  Future<void> create(Contato contato) async {
    final db = await _getDatabase();
    try {
      Map<String, dynamic> contatoMap = contato.toJson();
      contatoMap.remove('id');
      await db.insert(
        'contato',
        contatoMap,
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
    } catch (e) {
      print("Erro ao criar contato: $e");
    }
  }

  Future<void> update(Contato contato) async {
    final db = await _getDatabase();
    try {
      await db.update(
        'contato',
        contato.toJson(),
        where: 'id = ?',
        whereArgs: [contato.id],
      );
    } catch (e) {
      print("Erro ao atualizar contato: $e");
    }
  }

  Future<void> delete(int id) async {
    final db = await _getDatabase();
    try {
      await db.delete(
        'contato',
        where: 'id = ?',
        whereArgs: [id],
      );
    } catch (e) {
      print("Erro ao deletar contato: $e");
    }
  }
}
