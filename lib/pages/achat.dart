import 'package:data_table_2/data_table_2.dart';
import 'package:essabu/pages/accueil.dart';
import 'package:essabu/pages/modification.dart';
import 'package:essabu/utils/app_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

class Achat extends StatelessWidget {
  //
  AppController appController = Get.find();
  //
  @override
  Widget build(BuildContext context) {
    //
    return Scaffold(
      //appBar: AppBar(title: Text("Paiemant")),
      body: Column(
        children: [
          Obx(
            () => RichText(
              textAlign: TextAlign.left,

              text: TextSpan(
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                children: [
                  TextSpan(
                    text: 'Total produits: ',
                    style: TextStyle(
                      color: Colors.grey,
                      fontSize: 20,
                    ), // Noir standard
                  ),
                  TextSpan(
                    text: '${appController.produits.length}',
                    style: TextStyle(
                      color: Colors.black87,
                    ), // Noir légèrement adouci
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            flex: 9,
            child: Padding(
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
                          DataColumn2(
                            label: Text('Produit'),
                            size: ColumnSize.L,
                          ),
                          DataColumn2(label: Text('Prix'), size: ColumnSize.S),
                          DataColumn2(
                            label: Text('Quantité'),
                            size: ColumnSize.S,
                          ),
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
                              Get.dialog(
                                Center(
                                  child: Card(
                                    child: Container(
                                      height: 200,
                                      width: 200,
                                      padding: EdgeInsets.all(10),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceAround,
                                        children: [
                                          Text(
                                            "Voulez-vous vraiment supprimer ce produit ? ${appController.produits[index]['name']}",
                                            textAlign: TextAlign.center,
                                          ),
                                          InkWell(
                                            onTap: () {
                                              appController.produits.removeAt(
                                                index,
                                              );
                                              Get.back();
                                            },
                                            child: Container(
                                              alignment: Alignment.center,
                                              width: 250,
                                              height: 48,
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                                color: Colors.red.shade700,
                                              ),
                                              child: Text(
                                                "Supprimer de la liste",
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 15,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            },
                            cells: [
                              DataCell(
                                Text(
                                  "${appController.produits[index]['name']}",
                                ),
                              ),
                              DataCell(
                                Text(
                                  "${appController.produits[index]['prix']}",
                                ),
                              ),
                              DataCell(
                                Text(
                                  "${appController.produits[index]['quantity']}",
                                ),
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
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Obx(() {
                          RxDouble px = 0.0.obs;
                          appController.produits.forEach((element) {
                            px.value =
                                px.value +
                                (element['quantity'] * element['prix']);
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
            // child: Obx(
            //   () => ListView(
            //     padding: EdgeInsets.all(20),
            //     children: List.generate(appController.produits.length, (p) {
            //       //
            //       Map produit = appController.produits[p];
            //       return ListTile(
            //         leading: SvgPicture.asset(
            //           "assets/HugeiconsShoppingCartCheck02.svg",
            //           width: 40,
            //           height: 40,
            //           color: Colors.black,
            //         ),
            //         title: Text(produit['produit']),
            //         subtitle: Text(
            //           "Q: ${produit['quantite']} / ${produit['prix']} \$",
            //           style: TextStyle(fontWeight: FontWeight.bold),
            //         ),
            //         trailing: IconButton(
            //           onPressed: () {},
            //           icon: Icon(Icons.delete, color: Colors.red),
            //         ),
            //       );
            //     }),
            //   ),
            // ),
          ),
          // InkWell(
          //   onTap: () {
          //     appController.produits.clear();
          //     Get.offAll(Accueil());
          //     Get.snackbar("Succès", "Produit enregistré temporairement");
          //   },
          //   child: Container(
          //     alignment: Alignment.center,
          //     width: 250,
          //     height: 48,
          //     decoration: BoxDecoration(
          //       borderRadius: BorderRadius.circular(10),
          //       color: Colors.black,
          //     ),
          //     child: Text(
          //       "Enregistrer",
          //       style: TextStyle(
          //         color: Colors.white,
          //         fontWeight: FontWeight.bold,
          //         fontSize: 15,
          //       ),
          //     ),
          //   ),
          // ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }

  //
}
