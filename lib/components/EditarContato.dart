import 'package:crud_projetoi_lista/database/db_cmd.dart';
import 'package:crud_projetoi_lista/models/contato.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:flutter_masked_text2/flutter_masked_text2.dart';

class EditarContato extends StatefulWidget {
  final Contato contato;
  EditarContato({required this.contato});

  @override
  _EditarContatoState createState() => _EditarContatoState();
}

class _EditarContatoState extends State<EditarContato> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _nomeController;
  late TextEditingController _emailsController;
  late MaskedTextController _telefoneController;

  @override
  void initState() {
    super.initState();
    _nomeController = TextEditingController(text: widget.contato.nome);
    _emailsController = TextEditingController(text: widget.contato.email);
    _telefoneController = MaskedTextController(
        mask: '(00) 00000-0000', text: widget.contato.telefone);
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
            child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    TextFormField(
                        controller: _nomeController,
                        decoration: InputDecoration(
                            labelText: 'Nome',
                            border: OutlineInputBorder(),
                            hintText: 'Digite o nome',
                            prefixIcon: Icon(Icons.account_box)),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Por favor, insira um nome';
                          }
                          return null;
                        }),
                    SizedBox(height: 20),
                    TextFormField(
                      controller: _emailsController,
                      decoration: InputDecoration(
                        labelText: 'Email',
                        border: OutlineInputBorder(),
                        hintText: 'Digite o email',
                        prefixIcon: Icon(Icons.email),
                      ),
                      keyboardType: TextInputType.emailAddress,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Por favor, insira um email';
                        } else if (!RegExp(r'^[^@]+@[^@+\.[^@]+')
                            .hasMatch(value)) {
                          return 'Por favor, insira um email válido';
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 20),
                    TextFormField(
                      controller: _telefoneController,
                      decoration: InputDecoration(
                        labelText: 'Telefone',
                        border: OutlineInputBorder(),
                        hintText: 'Digite o telefone',
                        prefixIcon: Icon(Icons.phone),
                      ),
                      keyboardType: TextInputType.phone,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Por favor, insira um telefone';
                        } else if (!RegExp(r'^\(\d{2}\) \d{5}-\d{4}$')
                            .hasMatch(value)) {
                          return 'Por favor, insira um telefone válido';
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          final updatedContato = Contato(
                              id: widget.contato.id,
                              nome: _nomeController.text,
                              email: _emailsController.text,
                              telefone: _telefoneController.text);
                          Navigator.pop(context, updatedContato);
                        }
                      },
                      child: Text('Salvar'),
                    ),
                  ],
                ))));
  }
}
