import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../controller/pedidoitens_controller.dart';

class ListItem extends StatefulWidget {
    final String comanda;
  const ListItem({Key? key, required this.comanda}) : super(key: key);

  @override
  State<ListItem> createState() => _ListItemState();
}

class _ListItemState extends State<ListItem> {
  final controller = PedidoItens_Controller();

_loading() {
  return const Center(child: CircularProgressIndicator());
}

_start() {
  return Container();
}

_error() {
  return Center(
    child: ElevatedButton(
      onPressed: () {
        controller.start(widget.comanda,'0');
      },
      child: const Text('Tentar Novamente'),
    ),
  );
}

stateManagement(PedidoItensState state) {
  switch (state) {
    case PedidoItensState.start:
      return _start();

    case PedidoItensState.loading:
      return _loading();

    case PedidoItensState.sucess:
      return _sucess();

    case PedidoItensState.error:
      return _error();
    default:
      return _start();
  }
}

_sucess() {
  return ListView.builder(
    itemCount: controller.lista.length,
    itemBuilder: (context, index) {
      return Card(
        child: ListTile(
          leading:  Icon(
            _iconitem(index),
            size: 35,
            color: Colors.blueGrey,
          ),


          title: Text('${controller.lista[index].codBarras.toString()} - ${controller.lista[index].descricao.toString()}',
            style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
          ),
          subtitle: Text('${controller.lista[index].qnt} X ${formate
              .format(double.parse(controller.lista[index].total.toString()))
              .toString()}'),

        ),
      );
    },
  );
}

@override
void initState() {
  super.initState();
  controller.start(widget.comanda,'0');
}

final formate = NumberFormat.currency(locale: 'pt_br', symbol: "R\$");
@override
Widget build(BuildContext context) {
  return   AnimatedBuilder(
      animation: controller.state,
      builder: (context, child) {
        return stateManagement(controller.state.value);
      },

  );
}
_iconitem(int i){
  if(controller.lista[i].classificacao=='1'||controller.lista[i].classificacao=='2'||controller.lista[i].classificacao=='5'
      ||controller.lista[i].classificacao=='4'){
    return Icons.fastfood;
  }

  if(controller.lista[i].classificacao=='3'){
    return Icons.local_drink;
  }
  if(controller.lista[i].classificacao=='4'){
    return Icons.icecream;
  }


}
}