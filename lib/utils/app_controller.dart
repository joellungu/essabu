import 'dart:convert';

import 'package:essabu/pages/accueil.dart';
import 'package:essabu/pages/login.dart';
import 'package:essabu/utils/requete.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;

class AppController extends GetxController {
  //
  RxList<Map> produits = RxList();
  //
  var box = GetStorage();
  //
  Requete requete = Requete();
  //
  getLogin(Map user) async {
    //String username, String password
    Response response = await requete.postEE("login", user);
    //
    if (response.statusCode == 200 || response.statusCode == 201) {
      //
      print(response.statusCode);
      print(response.body);
      //
      Map data = response.body;
      //
      box.write("user", data);
      //
      getAllProduits(data['token']);
      //
      // if (data['data']['type'] != "Subject") {
      //   //
      //   bool v1 = await getAllProduits();
      //   if (v1) {
      //   } else {
      //     Get.snackbar(
      //       "Erreur",
      //       "Nous n'avons pas pu recupèrer certaines informations du serveur.",
      //     );
      //     Get.offAll(Login());
      //   }
      // } else {
      //   //box.write("utilisateur", response.body);
      //   Get.offAll(Login());
      //   //
      // }

      //
    } else {
      print(response.statusCode);
      print(response.body);
      //
      Get.back();
      //
      Get.snackbar("Oups", "Un problème est survenu lors de la connexion.");
    }
  }

  //
  getAllProduits(String token) async {
    //
    Response response = await requete.getE("products", token);
    //
    if (response.statusCode == 200 || response.statusCode == 201) {
      //
      print("Status: ${response.status}");
      print("Produits: ${response.body}");
      //
      box.write("produits", response.body);
      //
      Get.offAll(Accueil());
    } else {
      //
      print("Status: ${response.status}");
      print("Produits: ${response.body}");
      //
      Get.snackbar("Erreur", "Nous n'avons pas pu recupèrer les produits.");
      Get.offAll(Login());
    }
  }

  Future<bool> envoiCommande(Map commande, String token) async {
    //https://essabu.com/api/invoices
    //Map user = box.read("user");
    //
    Response response = await requete.postE("invoices", commande, token);
    //
    if (response.statusCode == 200 || response.statusCode == 201) {
      //
      print("Status: ${response.status}");
      print("Produits: ${response.body}");
      //Get.back();
      getAllProduits2(token);
      //
      return true;
    } else {
      //
      print("Status: ${response.status}");
      print("Produits: ${response.body}");
      //Get.back();
      //
      return false;
    }
  }

  getAllProduits2(String token) async {
    //
    Response response = await requete.getE("products", token);
    //
    if (response.statusCode == 200 || response.statusCode == 201) {
      //
      print("Status: ${response.status}");
      print("Produits: ${response.body}");
      //
      box.write("produits", response.body);
      //
    }
  }
}
