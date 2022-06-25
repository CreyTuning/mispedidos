import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mispedidos/pages/clientes_page/clientes_controller.dart';
import 'package:mispedidos/pages/pedidos_page.dart/views/seleccionar_cliente/seleccionar_cliente_controller.dart';

class SeleccionarClienteView extends StatelessWidget {
  const SeleccionarClienteView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    SeleccionarClienteController seleccionarClienteController = Get.put(SeleccionarClienteController());

    return Scaffold(
      appBar: AppBar(
        title: const Text('Seleccionar Cliente'),
      ),

      body: ListView.builder(
        itemCount: seleccionarClienteController.clientesDisponibles.length,
        itemBuilder: (context, index) => ListTile(
          onTap: (){Get.back(result:seleccionarClienteController.clientesDisponibles[index]);},
          title: Text(seleccionarClienteController.clientesDisponibles[index].nombre),
          leading: CircleAvatar(
            child: Text('${index + 1}'),
          ),
        ),
      ),
    );
  }
}