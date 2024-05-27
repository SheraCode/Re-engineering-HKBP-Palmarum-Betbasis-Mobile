import 'package:flutter/material.dart';
import 'package:hkbp_palmarum_app/user/DrawerWidget.dart';

class admin extends StatelessWidget {
  final token;

  const admin({@required this.token, Key? key}) : super(key: key);

  static const List<String> imgSrc = [
    "assets/jemaat.png",
    "assets/icon_kegiatan.png",
    "assets/pemasukan_dashboard.png",
    "assets/pengeluaran.png",
    "assets/baptis.png",
    "assets/wedding.png",
    "assets/malua.png",
    "assets/warta.png"

  ];

  static const List<String> titles = [
    "Jemaat",
    "Kegiatan",
    "Pemasukan",
    "Pengeluaran",
    "Baptis",
    "Pernikahan",
    "Angkat Sidi",
    "Warta Jemaat"

  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
          child: Container(
            color: Colors.indigo,
            child: Column(
              children: [
                Container(
                  height: MediaQuery.of(context).size.height * 0.22,
                  width: MediaQuery.of(context).size.width,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(padding: EdgeInsets.only(top: 25, left: 15, right: 15)),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 15),
                            child: Builder(
                              builder: (BuildContext context) {
                                return InkWell(
                                  onTap: () {
                                    Scaffold.of(context).openDrawer();
                                  },
                                  child: Icon(
                                    Icons.sort,
                                    color: Colors.white,
                                    size: 45,
                                  ),
                                );
                              },
                            ),
                          ),
                        ],
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                            top: 20,
                            left: 15,
                            right: 15
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("Dashboard",
                              style: TextStyle(
                                  fontSize: 30,
                                  color: Colors.white,
                                  fontWeight: FontWeight.w500,
                                  letterSpacing: 1
                              ),
                            ),
                            SizedBox(height: 10,),
                            Text("Last Update: 7 Aug 2023",
                              style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.white54,
                                  letterSpacing: 1
                              ),
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                ),
                SingleChildScrollView(
                  child: Container(
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(30),
                          topRight: Radius.circular(30),
                        )
                    ),
                    padding: EdgeInsets.symmetric(vertical: 20),
                    child: GridView.builder(
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          childAspectRatio: 1.1,
                          mainAxisSpacing: 25,
                        ),
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: imgSrc.length,
                        itemBuilder: (context, index) {
                          return InkWell(
                            onTap: (){},
                            child: Container(
                              margin: EdgeInsets.symmetric(vertical: 8, horizontal: 20),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  color: Colors.white,
                                  boxShadow: [
                                    BoxShadow(
                                        color: Colors.black26,
                                        spreadRadius: 1,
                                        blurRadius: 6
                                    )
                                  ]
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: [
                                  Image.asset(imgSrc[index],
                                    width: 100,
                                  ),
                                  Text(
                                    titles[index],
                                    style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold
                                    ),
                                  )
                                ],
                              ),
                            ),
                          );
                        }
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
      drawer: DrawerWidget(), // Panggil DrawerWidget
    );
  }
}
