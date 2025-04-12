import 'dart:io';

import 'package:essabu/pages/accueil.dart';
import 'package:essabu/pages/achat.dart';
import 'package:essabu/utils/app_controller.dart';
import 'package:essabu/utils/loader.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:qr_code_scanner_plus/qr_code_scanner_plus.dart';
import 'package:simple_barcode_scanner/simple_barcode_scanner.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
//import 'package:sursa_mobile/utils/app_controller.dart';

class QRViewExample extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _QRViewExampleState();
  }
}

class _QRViewExampleState extends State<QRViewExample> {
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  Barcode? result;
  QRViewController? controller;
  BarcodeViewController? controller2;
  //
  PageController pageController = PageController();
  //
  AppController appController = Get.find();
  //
  List produits = [];
  //
  String id = "", name = "";
  //
  int currentStock = 0;
  //
  var box = GetStorage();
  //
  String devise = "";
  double price = 0.0;
  //
  //AppController appController = Get.find();

  // In order to get hot reload to work we need to pause the camera if the platform
  // is android, or resume the camera if the platform is iOS.
  @override
  void reassemble() {
    super.reassemble();
    if (Platform.isAndroid) {
      controller!.pauseCamera();
    } else if (Platform.isIOS) {
      controller!.resumeCamera();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(backgroundColor: Colors.black),
      body: PageView(
        controller: pageController,
        physics:
            NeverScrollableScrollPhysics(), // Désactive le swipe avec le doigt
        children: [
          Column(
            children: <Widget>[
              const SizedBox(height: 20),
              Expanded(
                flex: 5,
                child: Achat(),
                // child: Stack(
                //   children: [
                //     Center(
                //       // child: QRView(
                //       //   key: qrKey,
                //       //   onQRViewCreated: _onQRViewCreated,
                //       // ),
                //       // child: SimpleBarcodeScanner(
                //       //   scaleHeight: 200,
                //       //   scaleWidth: 400,
                //       //   onScanned: (code) {
                //       //     setState(() {
                //       //       part1 = code;
                //       //       //String data = "${result!.code}".split(",")[0].split(":")[1];
                //       //       print("La valeur vaut id: $code");
                //       //       //
                //       //       pageController.nextPage(
                //       //         duration: const Duration(milliseconds: 500),
                //       //         curve: Curves.linear,
                //       //       );
                //       //     });
                //       //   },
                //       //   continuous: true,
                //       //   onBarcodeViewCreated: (
                //       //     BarcodeViewController controller,
                //       //   ) {
                //       //     controller2 = controller;
                //       //   },
                //       // ),
                //     ),
                //     Align(
                //       alignment: Alignment.center,
                //       child: Container(
                //         height: 200,
                //         width: 200,
                //         decoration: BoxDecoration(
                //           color: Colors.transparent,
                //           borderRadius: BorderRadius.circular(20),
                //           border: Border.all(color: Colors.red, width: 4),
                //         ),
                //       ),
                //     ),
                //   ],
                // ),
              ),
              InkWell(
                onTap: () async {
                  //
                  String? res = await SimpleBarcodeScanner.scanBarcode(
                    context,
                    cancelButtonText: "Annuler",
                    barcodeAppBar: const BarcodeAppBar(
                      appBarTitle: 'Essabu',
                      centerTitle: true,
                      enableBackButton: true,
                      backButtonIcon: Icon(Icons.arrow_back_ios),
                    ),
                    isShowFlashIcon: false,
                    delayMillis: 2000,
                    cameraFace: CameraFace.back,

                    // child: Align(
                    //   alignment: Alignment.center,
                    //   child: Container(
                    //     height: 200,
                    //     width: 200,
                    //     decoration: BoxDecoration(
                    //       color: Colors.transparent,
                    //       borderRadius: BorderRadius.circular(20),
                    //       border: Border.all(color: Colors.red, width: 4),
                    //     ),
                    //   ),
                    // ),
                  );
                  setState(() {
                    String barcode = res as String;
                    //

                    //
                    List produits = box.read("produits") ?? [];
                    //
                    Map produit = {};
                    //
                    for (Map p in produits) {
                      if ("${p['barcode']}" == barcode) {
                        produit = p;
                        break;
                      }
                    }
                    //
                    print("part1: $barcode == ${barcode != "-1"}");
                    //&&
                    //|| || part1 != "-1"
                    //produit.isNotEmpty
                    if (produit['name'] != null) {
                      //4006381333931
                      // Get.snackbar(
                      //   "Barecode",
                      //   "$barcode : ${produit['name']}",
                      //   backgroundColor: Colors.white,
                      //   colorText: Colors.black,
                      // );

                      try {
                        devise = produit['currency']['name'];

                        price = double.parse(produit['price'] ?? "0.0");
                        name = produit['name']; //"Produit 1"; //
                        id = produit['id'] ?? "";
                        //"01962948-c44b-782a-bff9-bc484bfcc1f4";
                        //
                        currentStock = produit['currentStock'] ?? 0;
                        //
                        Get.to(
                          Details(
                            pageController,
                            id,
                            name,
                            price,
                            devise,
                            currentStock,
                          ),
                        );
                        // pageController.nextPage(
                        //   duration: const Duration(milliseconds: 500),
                        //   curve: Curves.linear,
                        // );
                      } catch (e) {
                        Get.snackbar(
                          "Erreur",
                          "Du à: $e",
                          backgroundColor: Colors.red.shade700,
                          colorText: Colors.white,
                        );
                      }

                      //
                      // showModalBottomSheet(
                      //   context: context,
                      //   isScrollControlled: true,
                      //   builder: (context) {
                      //     return Container(
                      //       decoration: BoxDecoration(
                      //         borderRadius: BorderRadius.only(
                      //           topLeft: Radius.circular(15),
                      //           topRight: Radius.circular(15),
                      //         ),
                      //       ),
                      //       height: Get.size.height / 1.3,
                      //       width: Get.size.width,
                      //       child: Details(
                      //         pageController,
                      //         id,
                      //         name,
                      //         price,
                      //         devise,
                      //         currentStock,
                      //       ),
                      //     );
                      //   },
                      // );
                    } else {
                      Get.snackbar(
                        "Erreur",
                        "Aucun produit trouvé.",
                        backgroundColor: Colors.yellow,
                        colorText: Colors.black,
                      );
                    }
                  });
                },
                child: Container(
                  alignment: Alignment.center,
                  width: 250,
                  height: 48,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.black,
                  ),
                  child: Text(
                    "Scanner",
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 15,
                    ),
                  ),
                ),
              ),
              Expanded(
                flex: 1,
                child: Container(
                  color: Colors.white,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      // Container(
                      //   child:
                      //       (result != null)
                      //           ? Obx(() {
                      //             return Text(
                      //               'Produit scanné: ${appController.produits.length}',
                      //             );
                      //           })
                      //           : Text('Zero produit scanné'),
                      // ),
                      // const SizedBox(height: 10),
                      InkWell(
                        onTap: () async {
                          //
                          if (appController.produits.isEmpty) {
                            Get.snackbar(
                              "Oups",
                              "Aucun produit scanné ajouté.",
                              colorText: Colors.white,
                              backgroundColor: Colors.red.shade700,
                            );
                            //
                            //Get.to(Achat());
                            //
                          } else {
                            final List<ConnectivityResult> connectivityResult =
                                await (Connectivity().checkConnectivity());

                            //
                            if (connectivityResult.contains(
                                  ConnectivityResult.mobile,
                                ) ||
                                connectivityResult.contains(
                                  ConnectivityResult.wifi,
                                )) {
                              //
                              Loader.load();
                              //
                              Map user = box.read("user");
                              /**
                               * "noCustomer": user['data']['name'],
                                "noCustomerPhone": user['data']['phoneNumber'],
                               */
                              //
                              List items = [];
                              //
                              for (Map e in appController.produits.toList()) {
                                items.add({
                                  "product": "/api/products/${e['id']}",
                                  "quantity": e['quantity'],
                                });
                              }
                              //
                              Map commande = {
                                "noCustomer": "",
                                "noCustomerPhone": "",
                                "items": items,
                              };
                              //
                              bool rep = await appController.envoiCommande(
                                commande,
                                user['token'],
                              );
                              if (rep) {
                                appController.produits.clear();
                                Get.back();
                                Get.snackbar(
                                  "Succès",
                                  "Commande envoyé avec succès.",
                                  backgroundColor: Colors.white,
                                );
                              } else {
                                Get.back();
                                Get.snackbar(
                                  "Erreur",
                                  "Commande enregistré en local.",
                                  backgroundColor: Colors.red.shade700,
                                );
                              }
                            } else {
                              List ventes = box.read("ventes") ?? [];
                              //
                              ventes.addAll(appController.produits.toList());
                              //
                              box.write("ventes", ventes);
                            }
                            //
                            // appController.produits.clear();
                            // Get.offAll(Accueil());
                            // Get.snackbar(
                            //   "Succès",
                            //   "Produit enregistré temporairement",
                            // );
                          }
                        },
                        child: Container(
                          alignment: Alignment.center,
                          width: 250,
                          height: 48,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.black,
                          ),
                          child: Text(
                            "Passer la commande",
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 15,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 10),
                    ],
                  ),
                ),
              ),
            ],
          ),
          Details(pageController, id, name, price, devise, currentStock),
        ],
      ),
    );
  }

  // void _onQRViewCreated(QRViewController controller) {
  //   this.controller = controller;
  //   controller.scannedDataStream.listen((scanData) {
  //     setState(() {
  //       result = scanData;
  //       String code = result!.code!;
  //       part1 = code;
  //       //String data = "${result!.code}".split(",")[0].split(":")[1];
  //       print("La valeur vaut id: $code");
  //       //
  //       pageController.nextPage(
  //         duration: const Duration(milliseconds: 500),
  //         curve: Curves.linear,
  //       );
  //       //
  //       controller?.dispose();
  //       //Get.back();
  //       //appController.scanner(code);
  //     });
  //   });
  // }

  @override
  void dispose() {
    controller?.dispose();
    //controller2?.;
    super.dispose();
  }
}

class Details extends StatelessWidget {
  //
  AppController appController = Get.find();
  //
  PageController pageController;
  //
  Details(
    this.pageController,
    this.id,
    this.name,
    this.price,
    this.devise,
    this.currentStock,
  );
  //
  String id;
  String name;
  int currentStock;
  String devise;
  double price;
  String part1 = "Tomate";
  String part2 = "1.99 \$";
  String part3 = "Tomate serise de Goma";
  //
  TextEditingController quantite = TextEditingController(text: "1");
  //
  @override
  Widget build(BuildContext context) {
    //
    return Scaffold(
      appBar: AppBar(),
      body: Container(
        color: Colors.white,
        padding: EdgeInsets.all(30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            //
            Container(
              height: 220,
              width: 220,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(110),
                color: Colors.grey.shade200,
              ),
              alignment: Alignment.center,
              child: SvgPicture.asset(
                "assets/HugeiconsShoppingCartCheck02.svg",
                width: 150,
                height: 150,
                color: Colors.black,
              ),
            ),
            const SizedBox(height: 20),
            RichText(
              textAlign: TextAlign.left,

              text: TextSpan(
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                children: [
                  TextSpan(
                    text: '$name\n',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 30,
                    ), // Noir standard
                  ),
                  TextSpan(
                    text: '$price\n',
                    style: TextStyle(
                      color: Colors.black87,
                    ), // Noir légèrement adouci
                  ),
                  TextSpan(
                    text: devise,
                    style: TextStyle(
                      color: Colors.black54,
                    ), // Noir plus doux encore
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            Container(
              alignment: Alignment.center,
              width: 250,

              //height: 48,
              child: TextField(
                keyboardType: TextInputType.number,
                autofocus: true,
                controller: quantite,
                decoration: InputDecoration(
                  hintText: "Quantité par Kg",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(color: Colors.black, width: 2),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
            InkWell(
              onTap: () {
                //Get.offAll(Login());
                if (double.parse(quantite.text.isEmpty ? "1" : quantite.text) >
                    currentStock) {
                  Get.snackbar(
                    "Erreur",
                    "Stock insuffisant désolé",
                    backgroundColor: Colors.red.shade700,
                    colorText: Colors.white,
                  );
                } else {
                  appController.produits.add({
                    "id": id,
                    "name": name,
                    "quantity": double.parse(
                      quantite.text.isEmpty ? "1" : quantite.text,
                    ),
                    "prix": 1.99,
                  });
                  //
                  Get.back();
                  // pageController.previousPage(
                  //   duration: const Duration(milliseconds: 500),
                  //   curve: Curves.linear,
                  // );
                }
              },
              child: Container(
                alignment: Alignment.center,
                width: 250,
                height: 48,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.black,
                ),
                child: Text(
                  "Ajouter le produit",
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
    );
  }

  //
}
