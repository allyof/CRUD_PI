import 'package:crud_projetoi_lista/components/EditarContato.dart';
import 'package:crud_projetoi_lista/database/db_cmd.dart';
import 'package:crud_projetoi_lista/models/contato.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:flutter_masked_text2/flutter_masked_text2.dart';

class UserHome extends StatefulWidget {
  @override
  _UserHomeState createState() => _UserHomeState();
}

class _UserHomeState extends State<UserHome> {
  final ContatoComando comando = ContatoComando();
  late Future<List<Contato>> contatosFuture;
  // List<Contato> contatos = [];
  // List<Contato> contatosFiltro = [];
  // TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    contatosFuture = comando.findAll();
  }

  void _refreshContatos() {
    setState(() {
      contatosFuture = comando.findAll();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Lista de Contatos'),
        actions: <Widget>[
          TextButton.icon(
            //adicionar contato
            icon: Icon(Icons.add, color: Colors.white),
            label: Text('ADD', style: TextStyle(color: Colors.white)),
            onPressed: () async {
              final newContato = await Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => EditarContato(
                      contato:
                          Contato(id: 0, nome: '', email: '', telefone: '')),
                ),
              );
              if (newContato != null) {
                await comando.create(newContato);
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('Contato adicionado com sucesso!'),
                    backgroundColor: Colors.black,
                  ),
                );
                _refreshContatos();
              }
            },
          )
        ],
      ),
      body: FutureBuilder<List<Contato>>(
          future: contatosFuture,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(child: Text('Erro: ${snapshot.error}'));
            } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
              return Center(child: Text('Nenhum contato encontrado'));
            } else {
              return ListView.builder(
                  itemCount: snapshot.data!.length,
                  itemBuilder: (context, index) {
                    final contato = snapshot.data![index];
                    return Container(
                      decoration: BoxDecoration(
                        border: Border(
                          bottom: BorderSide(width: 1.0, color: Colors.grey),
                        ),
                      ),
                      child: ListTile(
                        title: Text(contato.nome),
                        subtitle: Text(
                            'Email: ${contato.email}\nTelefone: ${contato.telefone}'),
                        // ontap para abrir a pagina do contato => construir
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            IconButton(
                                icon: Icon(Icons.edit),
                                onPressed: () async {
                                  //Editar o contato
                                  final updatedContato = await Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            EditarContato(contato: contato),
                                      ));
                                  if (updatedContato != null) {
                                    await comando.update(updatedContato);
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                        content: Text(
                                            'Contato editado com sucesso!'),
                                        backgroundColor: Colors.black,
                                      ),
                                    );
                                    _refreshContatos();
                                  }
                                }),
                            IconButton(
                                icon: Icon(Icons.delete),
                                color: Colors.red,
                                onPressed: () async {
                                  await comando.delete(contato.id!);

                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content:
                                          Text('Contato deletado com sucesso!'),
                                      backgroundColor: Colors.black,
                                    ),
                                  );
                                  _refreshContatos();
                                }) // contato deletado
                          ],
                        ),
                      ),
                    );
                  });
            }
          }),
    );
  }
}
