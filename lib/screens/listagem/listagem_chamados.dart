import 'package:flutter/material.dart';

import '../../model/chamado.dart';
import '../../database/chamado_dao.dart';

class ListagemChamados extends StatefulWidget {

  ListagemChamados({Key? key}) : super(key: key);

  @override
  State<ListagemChamados> createState() => _ListagemChamadosState();
}

class _ListagemChamadosState extends State<ListagemChamados> {
  Future<List<Chamado>> _chamados = ChamadoDAO.buscaChamadosPorCliente();

  @override
  void initState() {
    super.initState();
    _chamados = ChamadoDAO.buscaChamadosPorCliente();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Central de Atendimento de TI',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.purple,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          SizedBox(height: 30),
          const Center(
            child: Text(
              'Histórico de chamados',
              style: TextStyle(
                fontSize: 35,
              ),
            ),
          ),
          Expanded(
            child: FutureBuilder<List<Chamado>>(
              future: _chamados,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return Center(child: Text('Nenhum chamado encontrado.'));
                } else {
                  return ListView.builder(
                    itemCount: snapshot.data!.length,
                    itemBuilder: (context, index) {
                      return ItemChamado(chamado: snapshot.data![index]);
                    },
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}

class ItemChamado extends StatelessWidget {
  final Chamado chamado;

  ItemChamado({Key? key, required this.chamado}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: Colors.black),
        ),
        child: ListTile(
          title: Text(
            chamado.titulo,
            style: TextStyle(fontSize: 25),
          ),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(chamado.descricao, style: TextStyle(fontSize: 15)),
              Text('Status: ${chamado.status}', style: TextStyle(fontSize: 15)),
            ],
          ),
        ),
      ),
    );
  }
}
