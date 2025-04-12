import 'package:data_table_2/data_table_2.dart';
import 'package:essabu/utils/app_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class Vente extends StatelessWidget {
  //
  String? titre;
  //
  var box = GetStorage();
  //
  RxList ventes = [].obs;
  //
  Vente(this.titre) {
    //
    ventes.value = box.read("ventes") ?? [];
  }
  //
  AppController appController = Get.find();
  //
  @override
  Widget build(BuildContext context) {
    //
    return Scaffold(
      appBar: AppBar(title: Text(titre!)),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Expanded(
              flex: 9,
              child: Obx(
                () => DataTable2(
                  columnSpacing: 12,
                  horizontalMargin: 12,
                  minWidth: context.width,

                  columns: [
                    DataColumn2(label: Text('Produit'), size: ColumnSize.L),
                    DataColumn2(label: Text('Prix'), size: ColumnSize.S),
                    DataColumn2(label: Text('Quantité'), size: ColumnSize.S),
                    // DataColumn2(
                    //   label: Text(''),
                    //   size: ColumnSize.S,
                    //   numeric: true,
                    // ),
                  ],
                  rows: List<DataRow>.generate(
                    ventes.length,
                    (index) => DataRow(
                      // onSelectChanged: (t) {
                      //
                      //   print("Je: $t");
                      // },
                      onLongPress: () {
                        //
                      },
                      cells: [
                        DataCell(Text("${ventes[index]['name']}")),
                        DataCell(Text("${ventes[index]['prix']}")),
                        DataCell(
                          Text("${ventes[index]['quantity']}"),
                          showEditIcon: true,
                        ),
                        //DataCell(Text('D' * (15 - (index + 10) % 10))),
                        //DataCell(Text(((index + 0.1) * 25.4).toString())),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            Expanded(
              flex: 1,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Text(
                    "Total",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  Obx(() {
                    RxDouble px = 0.0.obs;
                    appController.produits.forEach((element) {
                      px.value =
                          px.value + (element['quantity'] * element['prix']);
                    });
                    return Text(
                      "$px \$",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    );
                  }),
                ],
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          //
        },
        child: Icon(Icons.sync),
      ),
    );
  }

  //
}
