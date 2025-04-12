import 'package:data_table_2/data_table_2.dart';
import 'package:essabu/utils/app_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Vente extends StatelessWidget {
  String? titre;
  //
  Vente(this.titre);
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
                    appController.produits.length,
                    (index) => DataRow(
                      // onSelectChanged: (t) {
                      //
                      //   print("Je: $t");
                      // },
                      onLongPress: () {
                        //
                      },
                      cells: [
                        DataCell(
                          Text("${appController.produits[index]['name']}"),
                        ),
                        DataCell(
                          Text("${appController.produits[index]['prix']}"),
                        ),
                        DataCell(
                          Text("${appController.produits[index]['quantity']}"),
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
                  Text(
                    "1 238 \$",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  //
}
