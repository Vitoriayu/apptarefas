import 'package:app_lista_tarefas/modelo/objeto_data_hora.dart';
import 'package:app_lista_tarefas/widgets/itens_lista.dart';
import 'package:flutter/material.dart';

final TextEditingController email_controle = TextEditingController();

class Pagina_Lista extends StatefulWidget {
  @override
  State<Pagina_Lista> createState() => _Pagina_ListaState();
}

class _Pagina_ListaState extends State<Pagina_Lista> {
  final TextEditingController mensagensControlador = TextEditingController();

  List<Data_Hora> Mensagens = [];
  Data_Hora? deletar_itens;
  int? posicao_atual_deletar;

  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: mensagensControlador,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: "Adicione uma tarefa",
                        hintText: "Digite aqui"),
                  ),
                ),
                SizedBox(width: 8),
                ElevatedButton(
                  onPressed: () {
                    String qualquercoisa = mensagensControlador.text;
                    setState(() {
                      Data_Hora item_data_hora = Data_Hora(
                          titulo: qualquercoisa, data_hora: DateTime.now());
                      Mensagens.add(item_data_hora);
                    });
                    mensagensControlador.clear();
                  },
                        style: ElevatedButton.styleFrom(
                        primary: Color.fromARGB(255, 250, 0, 175),
                        padding: EdgeInsets.all(20)),
                    child: Icon(
                      Icons.add,
                      size: 30,
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 40,
              ),
              Flexible(
              child: ListView(
                shrinkWrap: true,
                children: [
                  for (Data_Hora mensagem_controle in Mensagens)
                    tudoItemLista(
                      mensagem_data_hora: mensagem_controle,
                      item_deletar_tarefas: deletar_tarefas,
                    ),
                ],
              ),
            ),
            SizedBox(
              height: 40,
            ),
            Row(
              children: [
                Expanded(
                    child: TextField(
                  decoration: InputDecoration(
                    labelText:
                        "Você possui ${Mensagens.length} tarefas pendentes",
                  ),
                )),
                SizedBox(width: 8),
                ElevatedButton(
                  onPressed: () {
                      mensagem_confirmacao();
                  },
                  style: ElevatedButton.styleFrom(
                    primary: Color.fromARGB(255, 250, 0, 175),
                  ),
                  child: Text("Limpar"),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void deletar_tarefas(Data_Hora item_data_hora) {
    deletar_itens = item_data_hora;
    posicao_atual_deletar = Mensagens.indexOf(item_data_hora);
    setState(() {
      Mensagens.remove(item_data_hora);
    });
    ScaffoldMessenger.of(context).showSnackBar(
     SnackBar(
        content: Text(
          "Tarefa ${item_data_hora.titulo} foi removida com sucesso",
          style: TextStyle(
              color: Colors.black, fontSize: 14, fontWeight: FontWeight.w600),
        ),
        backgroundColor: Color.fromARGB(204, 47, 238, 212),
        action: SnackBarAction(
          label: "Desfazer",
          onPressed: () {
            setState(() {
              Mensagens.insert(posicao_atual_deletar!, deletar_itens!);
            });
          },
        ),
      ),
    );
  }

  void mensagem_confirmacao() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("Limpar tudo?"),
          content:
              Text("Você tem certeza que deseja apagar todas as tarefas? "),
          actions: [
            TextButton(
              onPressed: () {
                setState(() {
                  Navigator.pop(context);
                });
              },
              child: Text("Cancelar"),
            ),
            TextButton(
              onPressed: () {
                setState(() {
                  Mensagens.clear();
                  Navigator.pop(context);
                });
              },
              child: Text("Limpar tudo"),
            ),
          ],
        );
      },
    );
  }
}