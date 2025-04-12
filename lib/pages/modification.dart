import 'package:essabu/utils/app_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class Modification extends StatelessWidget {
  //
  Map produit;
  //
  var box = GetStorage();
  //
  AppController appController = Get.find();
  //
  Modification(this.produit);
  //
  TextEditingController quantite = TextEditingController(text: "1");
  //
  @override
  Widget build(BuildContext context) {
    //
    return Scaffold(
      appBar: AppBar(title: Text("Modifier la quantité")),
      body: Container(
        color: Colors.white,
        padding: EdgeInsets.all(20),
        child: Column(
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
                    text: '${produit['name']}\n',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 30,
                    ), // Noir standard
                  ),
                  TextSpan(
                    text: '${produit['price']}\n',
                    style: TextStyle(
                      color: Colors.black87,
                    ), // Noir légèrement adouci
                  ),
                  TextSpan(
                    text: '${produit['currency']['name']}',
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
                    produit['currentStock']) {
                  Get.snackbar(
                    "Erreur",
                    "Stock insuffisant désolé",
                    backgroundColor: Colors.red.shade700,
                    colorText: Colors.white,
                  );
                } else {
                  appController.produits.forEach((p) {
                    if (p['id'] == produit['id']) {
                      p['quantity'] = double.parse(
                        quantite.text.isEmpty ? "1" : quantite.text,
                      );
                    }
                  });

                  //appController.produits
                  box.write("produits", appController.produits.toList());

                  // for (Map p in appController.produits){
                  //
                  // }
                  //appController.produits.add();
                  //
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
                  "Modifier le produit",
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                  ),
                ),
              ),
            ),
            //
          ],
        ),
      ),
    );
  }

  //
}
