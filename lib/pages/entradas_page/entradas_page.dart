import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mispedidos/pages/entradas_page/widgets/entrada_tile.dart';
import 'package:mispedidos/pages/facturas_page/facturas_controller.dart';
import 'package:mispedidos/pages/widgets/empty_list.dart';
import 'package:mispedidos/pages/pedidos_page.dart/pedidos_controller.dart';
import 'package:mispedidos/pages/entradas_page/entradas_controller.dart';
import 'package:mispedidos/pages/entradas_page/widgets/solicitudes_information_bar.dart';

class EntradasPage extends StatelessWidget {
  const EntradasPage({Key? key,}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    PedidosController pedidosController = Get.find();
    FacturasController facturasController = Get.find();

    return GetBuilder<EntradasController>(
      init: EntradasController(),
      builder: (entradasController) => Scaffold(
        appBar: AppBar(
          title: Text(facturasController.facturas['${pedidosController.id}']!.pedidos[entradasController.cliente.obs]!.cliente.nombre),
          actions: [
            (facturasController.facturas['${pedidosController.id}']!.estado > 0) ? const SizedBox() : IconButton(
              onPressed: (){entradasController.onAgregarTap(null);},
              icon: const Icon(Icons.add)
            )
          ],
        ),
    
        bottomNavigationBar: EntradasInformationBar(
          adeudado: facturasController.facturas['${pedidosController.id}']!.pedidos[entradasController.cliente.obs]!.obtenerValor(),
          pagado: facturasController.facturas['${pedidosController.id}']!.pedidos[entradasController.cliente.obs]!.pagado,
          ganancia: facturasController.facturas['${pedidosController.id}']!.pedidos[entradasController.cliente.obs]!.obtenerGanancia(),
          valorDelDolar: facturasController.facturas['${pedidosController.id}']!.pedidos[entradasController.cliente.obs]!.valorDelDolar,
        ),
    
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    
        body: (facturasController.facturas['${pedidosController.id}']!.pedidos[entradasController.cliente.obs]!.entradas.isEmpty) 
        ? const EmptyList(label: 'Sin entradas') 
        : Column(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                height: 25,
                color: Colors.grey[700]!.withOpacity(0.3),
                child: Row(
                  children: [
                    Expanded(
                      flex: 3,
                      child: Container(
                        alignment: Alignment.centerLeft,
                        child: const Text('Producto', 
                          style: TextStyle(
                            fontSize: 14
                          )
                        )
                      )
                    ),

                    Expanded(
                      child: Container(
                        alignment: Alignment.center,
                        child: const Text('Cantidad', 
                          style: TextStyle(
                            fontSize: 14
                          )
                        )
                      )
                    ),

                    Expanded(
                      child: Container(
                        alignment: Alignment.centerRight,
                        child: const Text('Valor', 
                          style: TextStyle(
                            fontSize: 14
                          )
                        )
                      )
                    ),
                  ],
                ),
              ),

              Expanded(
                child: ListView.builder(
                  padding: const EdgeInsets.only(top: 10),
                  itemCount: facturasController.facturas['${pedidosController.id}']!.pedidos[entradasController.cliente.obs]!.entradas.entries.length,
                  itemBuilder: (context, index) => EntradaTile(
                    producto: facturasController.facturas['${pedidosController.id}']!.pedidos[entradasController.cliente.obs]!.entradas.entries.elementAt(index).key,
                    entrada: facturasController.facturas['${pedidosController.id}']!.pedidos[entradasController.cliente.obs]!.entradas.entries.elementAt(index).value,
                    onTap: (facturasController.facturas['${pedidosController.id}']!.estado > 0) ? null : (){entradasController.onAgregarTap(facturasController.facturas['${pedidosController.id}']!.pedidos[entradasController.cliente.obs]!.entradas.entries.elementAt(index).key);},
                  )
                ),
              ),
            ] 
        ),
      )
    );
  }
}