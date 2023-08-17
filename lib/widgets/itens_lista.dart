import 'package:app_lista_tarefas/modelo/objeto_data_hora.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:intl/intl.dart';

class tudoItemLista extends StatelessWidget {
  const tudoItemLista({super.key, required this.mensagem_data_hora,
  required this.item_deletar_tarefas,});

  final Data_Hora mensagem_data_hora;
  final Function(Data_Hora) item_deletar_tarefas;

  @override
  Widget build(BuildContext context) {
    return Slidable(
      endActionPane: ActionPane(
        motion: const ScrollMotion(),
        children: [
          SlidableAction(
            flex: 2,
            onPressed: (context) {
              item_deletar_tarefas(mensagem_data_hora);
            },
           backgroundColor: Color.fromARGB(255, 124, 52, 219),
            foregroundColor: Color.fromARGB(255, 57, 228, 157),
            icon: Icons.delete,
            label: 'Deletar',
          ),
        ],
      ),
        child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            color:  Color.fromARGB(255, 238, 134, 207),
          ),
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  DateFormat("dd/MM/yyyy - HH:mm")
                      .format(mensagem_data_hora.data_hora),
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                ),
                Text(
                  mensagem_data_hora.titulo,
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}