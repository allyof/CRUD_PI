import 'package:crud_projetoi_lista/database/db_cmd.dart';
import 'package:crud_projetoi_lista/models/contato.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart';

class EditarContato extends StatefulWidget {
  final Contato contato;
  EditarContato({required this.contato});

  @override
  _EditarContatoState createState() => _EditarContatoState();
}

class _EditarContatoState extends State<EditarContato> {
  late TextEditingController _nomeController;
  late TextEditingController _emailsController;
  late TextEditingController _telefoneController;

  @override
  void initState() {
    super.initState();
    _nomeController = TextEditingController(text: widget.contato.nome);
    _emailsController = TextEditingController(text: widget.contato.email);
    _telefoneController = TextEditingController(text: widget.contato.telefone);
  }

  @override
  void dispose() {
    _nomeController.dispose();
    _emailsController.dispose();
    _telefoneController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text('Editando contato')),
        body: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                TextField(
                  controller: _nomeController,
                  decoration: InputDecoration(
                      labelText: 'Nome',
                      border: OutlineInputBorder(),
                      hintText: 'Digite o nome',
                      prefixIcon: Icon(Icons.account_box)),
                ),
                SizedBox(height: 20),
                TextField(
                  controller: _emailsController,
                  decoration: InputDecoration(
                    labelText: 'Email',
                    border: OutlineInputBorder(),
                    hintText: 'Digite o email',
                    prefixIcon: Icon(Icons.email),
                  ),
                  keyboardType: TextInputType.emailAddress,
                ),
                SizedBox(height: 20),
                TextField(
                  controller: _telefoneController,
                  decoration: InputDecoration(
                    labelText: 'Telefone',
                    border: OutlineInputBorder(),
                    hintText: 'Digite o telefone',
                    prefixIcon: Icon(Icons.phone),
                  ),
                  keyboardType: TextInputType.phone,
                ),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    final updatedContato = Contato(
                        id: widget.contato.id,
                        nome: _nomeController.text,
                        email: _emailsController.text,
                        telefone: _telefoneController.text);
                    Navigator.pop(context, updatedContato);
                  },
                  child: Text('Salvar'),
                ),
              ],
            )));
  }
}
