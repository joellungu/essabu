import 'package:essabu/pages/vente.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import 'scan.dart';

class Accueil extends StatelessWidget {
  //
  PageController pageController = PageController();
  //
  //
  @override
  Widget build(BuildContext context) {
    //
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            //
            showModalBottomSheet(
              context: context,
              builder: (context) {
                return Container();
              },
            );
          },
          icon: SvgPicture.asset(
            "assets/HugeiconsBubbleChatQuestion.svg",
            color: Colors.black,
            height: 35,
            width: 35,
            semanticsLabel: 'Dart Logo',
          ),
        ),
      ),
      body: Stack(
        children: [
          PageView(
            controller: pageController,
            physics: NeverScrollableScrollPhysics(),
            children: [
              Entree(),
              ListView(
                padding: EdgeInsets.all(20),
                children: [
                  Text(
                    """Quis sunt culpa ex velit. Occaecat quis veniam fugiat culpa consectetur ipsum. Commodo veniam cupidatat fugiat aliqua ad nulla et esse consequat fugiat nulla proident quis. Ullamco Lorem consectetur cupidatat proident aute nulla consequat elit ea enim ut laboris.

Voluptate veniam ullamco ut veniam. Id aute culpa aliquip qui aliqua dolor elit cillum eiusmod do incididunt tempor aute occaecat. Excepteur in velit nostrud eu commodo minim reprehenderit eiusmod sit. Occaecat officia exercitation fugiat officia ullamco qui duis irure sint Lorem ea. Anim tempor do adipisicing incididunt esse est eu minim velit qui. Nisi non nostrud laborum occaecat.

Laboris velit cillum laborum adipisicing consequat irure laboris exercitation est cillum et ullamco cupidatat ea. Ipsum mollit dolor quis laborum eu ad incididunt dolor. Dolore eiusmod amet aliquip culpa enim eu amet sunt excepteur anim laborum ullamco sunt sint. Aute aliquip do elit ad laboris commodo. Id ullamco eiusmod reprehenderit officia labore veniam adipisicing ad velit.

Consectetur ex non exercitation adipisicing adipisicing. Ad duis ad fugiat quis dolor ipsum commodo cillum tempor ut consequat minim dolor. Qui culpa non non irure pariatur. Labore sit reprehenderit consectetur consequat fugiat do ea irure. Reprehenderit amet anim laboris ex fugiat.

Sint in tempor fugiat dolore. Duis Lorem dolore adipisicing consequat. Eu non nostrud tempor cupidatat anim enim est pariatur dolor duis culpa. Enim esse id enim reprehenderit elit veniam amet veniam enim eiusmod nisi.

Consectetur mollit eu labore velit tempor aliquip. Ea magna excepteur cillum ullamco commodo aute ad. Sint quis tempor duis do dolor mollit ex amet ex commodo ut ut labore. Nostrud ad occaecat deserunt dolore. Consequat tempor fugiat in deserunt incididunt exercitation amet. Occaecat tempor nisi dolor ut ea dolor sint qui.

Velit elit eiusmod cupidatat esse occaecat. Excepteur laboris excepteur do qui proident. Irure irure elit nulla magna consectetur id commodo magna Lorem adipisicing in do amet. Elit excepteur qui eu sunt dolore cupidatat reprehenderit ut veniam elit.""",
                  ),
                ],
              ),
            ],
          ),
          Padding(
            padding: EdgeInsets.only(bottom: 30),
            child: Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                height: 90,
                child: Row(
                  children: [
                    Expanded(
                      flex: 4,
                      child: Container(
                        padding: EdgeInsets.only(left: 20),
                        //color: Colors.grey,
                        alignment: Alignment.centerLeft,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            InkWell(
                              onTap: () {
                                //
                                pageController.previousPage(
                                  duration: const Duration(milliseconds: 500),
                                  curve: Curves.linear,
                                );
                              },
                              child: Container(
                                height: 60,
                                width: 60,
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                  color: Colors.black,
                                  borderRadius: BorderRadius.circular(30),
                                ), //
                                child: SvgPicture.asset(
                                  "assets/HugeiconsHome05.svg",
                                  width: 35,
                                  height: 35,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                            const SizedBox(width: 20),
                            InkWell(
                              onTap: () {
                                //
                                pageController.nextPage(
                                  duration: const Duration(milliseconds: 500),
                                  curve: Curves.linear,
                                );
                              },
                              child: Container(
                                height: 60,
                                width: 60,
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                  color: Colors.black,
                                  borderRadius: BorderRadius.circular(30),
                                ),
                                child: SvgPicture.asset(
                                  "assets/HugeiconsUser02.svg",
                                  width: 35,
                                  height: 35,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 4,
                      child: Container(
                        padding: EdgeInsets.only(right: 20),
                        alignment: Alignment.centerRight,
                        child: InkWell(
                          onTap: () {
                            //
                            Get.to(QRViewExample());
                          },
                          child: Container(
                            height: 60,
                            width: 60,
                            child: Icon(
                              Icons.qr_code,
                              color: Colors.white,
                              size: 35,
                            ),
                            decoration: BoxDecoration(
                              color: Colors.black,
                              borderRadius: BorderRadius.circular(30),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  //
}

class Entree extends StatelessWidget {
  //
  final String part1 = "Bienvenue";
  final String part2 = "sur votre guichet";
  final String part3 = "de prévente intelligent !";
  //
  List options = [
    {"logo": "HugeiconsShoppingCartCheck02", "desc": "Produits vendu"},
    {"logo": "HugeiconsQrCode", "desc": "Ventes synchronisées"},
    {"logo": "HugeiconsWifiError01", "desc": "Non synchronisées"},
    {"logo": "HugeiconsClock01", "desc": "Historique"},
  ];
  //
  @override
  Widget build(BuildContext context) {
    //
    return Column(
      children: [
        Expanded(
          flex: 3,
          child: Container(
            alignment: Alignment.center,
            child: RichText(
              textAlign: TextAlign.left,

              text: TextSpan(
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                children: [
                  TextSpan(
                    text: '$part1\n',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 30,
                    ), // Noir standard
                  ),
                  TextSpan(
                    text: '$part2\n',
                    style: TextStyle(
                      color: Colors.black87,
                    ), // Noir légèrement adouci
                  ),
                  TextSpan(
                    text: '$part3',
                    style: TextStyle(
                      color: Colors.black54,
                    ), // Noir plus doux encore
                  ),
                ],
              ),
            ),
          ),
        ),
        Expanded(
          flex: 9,
          child: Center(
            child: GridView.count(
              shrinkWrap: true,
              mainAxisSpacing: 10,
              crossAxisSpacing: 10,
              padding: EdgeInsets.all(20),
              crossAxisCount: 2,
              children: List.generate(options.length, (e) {
                return Card(
                  elevation: 1,
                  child: InkWell(
                    onTap: () {
                      //
                      if (e == 0) {
                        Get.to(Vente(options[e]['desc']));
                      }
                      //
                      if (e == 1) {
                        Get.to(Vente(options[e]['desc']));
                      }
                      //
                      if (e == 2) {}
                      //
                      if (e == 3) {}
                    },
                    child: Container(
                      padding: EdgeInsets.all(10),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SvgPicture.asset(
                            "assets/${options[e]['logo']}.svg",
                            color: Colors.black,
                            height: 50,
                            width: 50,
                            semanticsLabel: 'Dart Logo',
                          ),
                          Text(
                            "${options[e]['desc']}",
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                          ),
                          Text(
                            "65 760",
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.grey,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              }),
            ),
          ),
        ),
        Expanded(flex: 2, child: Container()),
        // Expanded(
        //   flex: 2,
        //   child: Container(
        //     alignment: Alignment.center,
        //     child: InkWell(
        //       onTap: () {
        //         Get.to(QRViewExample());
        //       },
        //       child: Container(
        //         alignment: Alignment.center,
        //         width: 250,
        //         height: 48,
        //         decoration: BoxDecoration(
        //           borderRadius: BorderRadius.circular(10),
        //           color: Colors.black,
        //         ),
        //         child: Text(
        //           "Faire un scan",
        //           style: TextStyle(
        //             color: Colors.white,
        //             fontWeight: FontWeight.bold,
        //             fontSize: 15,
        //           ),
        //         ),
        //       ),
        //     ),
        //     //color: Colors.grey,
        //   ),
        // ),
      ],
    );
  }

  //
}
