import 'dart:async';
import 'dart:io';

import 'package:essabu/pages/accueil.dart';
import 'package:essabu/pages/login.dart';
import 'package:essabu/utils/app_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:get/utils.dart';

class Splash extends StatelessWidget {
  //
  PageController pageController = PageController();
  //
  Splash() {
    //
    Timer(const Duration(seconds: 3), () {
      //
      //Get.offAll(Login());
    });
  }
  @override
  Widget build(BuildContext context) {
    //
    return Scaffold(
      body: PageView(
        controller: pageController,
        children: [
          Page(
            pageController,
            "Scan des produits",
            "Facile sans ce prendre la tete.",
            false,
            1,
          ),
          Page(
            pageController,
            "Sécurité",
            "Vérifiez les informations affichées",
            false,
            2,
          ),
          Page(
            pageController,
            "Rapidité",
            "Confirmez et préparez la mise en vente",
            true,
            3,
          ),
        ],
      ),
    );
  }

  //
}

class Page extends StatelessWidget {
  //
  PageController pageController;
  //
  String titre;
  String description;
  //
  bool login;
  //
  int index;
  //
  Page(
    this.pageController,
    this.titre,
    this.description,
    this.login,
    this.index,
  );

  @override
  Widget build(BuildContext context) {
    //
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            flex: 9,
            child: Container(
              //color: Colors.grey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(height: 100),
                  Container(
                    height: 220,
                    width: 220,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(110),
                      color: Colors.grey.shade200,
                    ),
                    alignment: Alignment.center,
                    child:
                        index == 1
                            ? SvgPicture.asset(
                              "assets/HugeiconsQrCode.svg",
                              width: 150,
                              height: 150,
                              color: Colors.black,
                            )
                            : index == 2
                            ? SvgPicture.asset(
                              "assets/HugeiconsSecurityCheck.svg",
                              width: 150,
                              height: 150,
                              color: Colors.black,
                            )
                            : SvgPicture.asset(
                              "assets/HugeiconsDashboardSpeed02.svg",
                              width: 150,
                              height: 150,
                              color: Colors.black,
                            ),
                  ),
                  const SizedBox(height: 25),
                  Text(
                    titre,
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),

                  Text(
                    description,
                    style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.bold,
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                height: 10,
                width: 10,
                decoration: BoxDecoration(
                  color: index == 1 ? Colors.black : Colors.transparent,
                  borderRadius: BorderRadius.circular(5),
                ),
              ),
              const SizedBox(width: 3),
              Container(
                height: 10,
                width: 10,
                decoration: BoxDecoration(
                  color: index == 2 ? Colors.black : Colors.transparent,
                  borderRadius: BorderRadius.circular(5),
                ),
              ),
              const SizedBox(width: 3),
              Container(
                height: 10,
                width: 10,
                decoration: BoxDecoration(
                  color: index == 3 ? Colors.black : Colors.transparent,
                  borderRadius: BorderRadius.circular(5),
                ),
              ),
            ],
          ),
          Expanded(
            flex: 2,
            child: Container(
              alignment: Alignment.center,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  InkWell(
                    onTap: () {
                      if (index == 1) {
                        pageController.nextPage(
                          duration: const Duration(milliseconds: 500),
                          curve: Curves.linear,
                        );
                      } else if (index == 2) {
                        pageController.nextPage(
                          duration: const Duration(milliseconds: 500),
                          curve: Curves.linear,
                        );
                      } else {
                        Get.offAll(Login());
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
                        "Continuer",
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 15,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  TextButton(
                    onPressed: () {
                      //
                      exit(0);
                    },
                    child: Text("Quitter"),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
//
  //

