import 'package:flutter/material.dart';
import 'package:crud_projetoi_lista/database/db_cmd.dart';
import 'package:crud_projetoi_lista/models/contato.dart';
import 'package:crud_projetoi_lista/database/script.dart';

class ListaUser extends StatelessWidget {
  // Criar uma instância da classe dbCmd para usar seus métodos
  final ContatoComando _dbCmd = ContatoComando();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Lista Telefônica'),
      ),
      body: FutureBuilder<List<Contato>>(
        future: _dbCmd.findAll(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Erro: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('Nenhum contato encontrado.'));
          } else {
            final contatos = snapshot.data!;
            return ListView.builder(
              itemCount: contatos.length,
              itemBuilder: (context, index) {
                final contato = contatos[index];
                return ListTile(
                  title: Text(contato.nome),
                  subtitle: Text(contato.email),
                  trailing: Text(contato.telefone),
                );
              },
            );
          }
        },
      ),
    );
  }
}
