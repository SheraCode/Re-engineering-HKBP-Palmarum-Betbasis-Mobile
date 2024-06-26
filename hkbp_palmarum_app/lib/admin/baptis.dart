import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:hkbp_palmarum_app/admin/KelolaBaptis.dart';
import 'package:hkbp_palmarum_app/user/DrawerWidget.dart';

class baptis extends StatefulWidget {
  @override
  _BaptisState createState() => _BaptisState();
}

class _BaptisState extends State<baptis> {
  var height, width;
  List<String> imgSrc = [
    "assets/baptis.png",
    "assets/baptis.png",
    "assets/baptis.png",
    "assets/baptis.png",
    "assets/baptis.png",
    // "assets/baptis.png",
    // "assets/baptis.png",
  ];

  List<Map<String, dynamic>> data = [];

  @override
  void initState() {
    super.initState();
    fetchBaptisData();
  }

  Future<void> fetchBaptisData() async {
    final response = await http.get(Uri.parse('http://172.20.10.4:2005/registrasi-baptis'));

    if (response.statusCode == 200) {
      List<dynamic> jsonData = json.decode(response.body);
      setState(() {
        data = jsonData.map((item) => {
          'id': item['id_registrasi_baptis'],
          'nama_lengkap': item['nama_lengkap']
        }).toList();
      });
    } else {
      throw Exception('Failed to load data');
    }
  }

  @override
  Widget build(BuildContext context) {
    height = MediaQuery.of(context).size.height;
    width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
          child: Container(
            color: Colors.indigo,
            child: Column(
              children: [
                Container(
                  height: height * 0.22,
                  width: width,
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
                        padding: EdgeInsets.only(top: 20, left: 15, right: 15),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Pembaptisan",
                              style: TextStyle(
                                  fontSize: 30,
                                  color: Colors.white,
                                  fontWeight: FontWeight.w500,
                                  letterSpacing: 1),
                            ),
                            SizedBox(height: 10),
                            Text(
                              "Request Surat Pembaptisan Jemaat",
                              style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.white54,
                                  letterSpacing: 1),
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
                        )),
                    padding: EdgeInsets.symmetric(vertical: 20),
                    child: data.isEmpty
                        ? Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset(
                            "assets/baptis.png",
                            width: 100,
                            height: 100,
                          ),
                          SizedBox(height: 10),
                          Text(
                            "Tidak Ada Request Baptis",
                            style: TextStyle(
                              fontSize: 19,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    )
                        : ListView.builder(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: data.length,
                        itemBuilder: (context, index) {
                          return InkWell(
                            onTap: () {},
                            child: Container(
                              margin: EdgeInsets.symmetric(vertical: 8, horizontal: 20),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  color: Colors.white,
                                  boxShadow: [
                                    BoxShadow(
                                        color: Colors.black26,
                                        spreadRadius: 1,
                                        blurRadius: 6)
                                  ]),
                              child: Row(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Image.asset(
                                      data.isEmpty ? "assets/baptis.png" : imgSrc[index % imgSrc.length],
                                      width: 80, // Adjusted image width
                                    ),
                                  ),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                      children: [
                                        Text(
                                          data[index]['nama_lengkap'],
                                          style: TextStyle(
                                              fontSize: 18, // Adjusted font size
                                              fontWeight: FontWeight.bold),
                                        ),
                                        Text(
                                          "Request Surat Pembaptisan Jemaat ${data[index]['nama_lengkap']}",
                                          style: TextStyle(
                                            fontSize: 14,
                                          ),
                                        ),
                                        SizedBox(height: 8),
                                        Align(
                                          alignment: Alignment.centerRight,
                                          child: Padding(
                                            padding: EdgeInsets.only(right: 16, bottom: 8), // Adjusted padding
                                            child: ElevatedButton(
                                              onPressed: () {
                                                Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                    builder: (context) => kelolaBaptis(idRegistrasiBaptis: data[index]['id']),
                                                  ),
                                                );
                                              },
                                              style: ElevatedButton.styleFrom(
                                                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8), // Adjusted button padding
                                              ),
                                              child: Text('Kelola'),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        }),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
      drawer: DrawerWidget(), // Call DrawerWidget
    );
  }
}
