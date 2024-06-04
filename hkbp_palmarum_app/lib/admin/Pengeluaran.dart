import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:intl/intl.dart';
import 'package:hkbp_palmarum_app/admin/KelolaPengeluaran.dart';
import 'package:hkbp_palmarum_app/admin/TambahPengeluaran.dart';
import 'package:hkbp_palmarum_app/user/DrawerWidget.dart';

class pengeluaran extends StatefulWidget {
  @override
  State<pengeluaran> createState() => _pengeluaranState();
}

class _pengeluaranState extends State<pengeluaran> {
  var height, width;
  List<String> imgSrc = [];
  List<String> titles = [];
  List<int> pengeluaranIds = [];
  int totalPengeluaran = 0;
  bool isApiActive = true;

  Future<void> fetchData() async {
    final Uri url = Uri.parse('http://172.20.10.4:2005/pengeluaran');
    try {
      final response = await http.get(url);

      if (response.statusCode == 200) {
        final List<dynamic> data = jsonDecode(response.body);

        setState(() {
          imgSrc = List<String>.generate(data.length, (index) => "assets/pengeluaran.png");
          titles = List<String>.generate(data.length, (index) => data[index]['keterangan_pengeluaran'].toString());
          pengeluaranIds = List<int>.generate(data.length, (index) => data[index]['id_pengeluaran']);
          totalPengeluaran = data.fold<int>(0, (sum, item) => sum + (item['jumlah_pengeluaran'] ?? 0) as int);
          isApiActive = true; // Set flag to true if API call succeeds
        });
      } else {
        setState(() {
          isApiActive = false; // Set flag to false if API call fails
        });
        throw Exception('Failed to load data');
      }
    } catch (e) {
      print('Error fetching data: $e');
      setState(() {
        isApiActive = false; // Set flag to false if API call throws an exception
      });
    }
  }

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  @override
  Widget build(BuildContext context) {
    height = MediaQuery.of(context).size.height;
    width = MediaQuery.of(context).size.width;

    final NumberFormat formatCurrency = NumberFormat.currency(locale: 'id_ID', symbol: 'IDR ');

    return Scaffold(
      body: SafeArea(
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
                            "Pengeluaran",
                            style: TextStyle(
                              fontSize: 30,
                              color: Colors.white,
                              fontWeight: FontWeight.w500,
                              letterSpacing: 1,
                            ),
                          ),
                          SizedBox(height: 10),
                          Text(
                            "Pengeluaran HKBP Palmarum Tarutung",
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.white54,
                              letterSpacing: 1,
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),

              if (!isApiActive)
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(30),
                        topRight: Radius.circular(30),
                      ),
                    ),
                    padding: EdgeInsets.symmetric(
                      vertical: MediaQuery.of(context).size.height * 0.2,
                      horizontal: MediaQuery.of(context).size.width * 0.1,
                    ),
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset(
                            'assets/server-down.png',
                            width: MediaQuery.of(context).size.width * 0.5,
                            height: MediaQuery.of(context).size.width * 0.5,
                          ),
                          SizedBox(height: MediaQuery.of(context).size.height * 0.05),
                          Text(
                            'Server tidak aktif',
                            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),

              if (isApiActive)
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(30),
                        topRight: Radius.circular(30),
                      ),
                    ),
                    padding: EdgeInsets.symmetric(vertical: 20),
                    child: ListView.builder(
                      itemCount: imgSrc.length,
                      itemBuilder: (context, index) {
                        return InkWell(
                          onTap: () {
                            // Handle item tap
                          },
                          child: Container(
                            margin: EdgeInsets.symmetric(vertical: 8, horizontal: 20),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color: Colors.white,
                              boxShadow: [
                                BoxShadow(color: Colors.black26, spreadRadius: 1, blurRadius: 6),
                              ],
                            ),
                            child: Row(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Image.asset(
                                    imgSrc[index],
                                    width: 80,
                                  ),
                                ),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Text(
                                        titles[index], // Display title from API
                                        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                                      ),
                                      Text(
                                        "Pengeluaran Keuangan ${titles[index]}",
                                        style: TextStyle(fontSize: 14),
                                      ),
                                      SizedBox(height: 8),
                                      Align(
                                        alignment: Alignment.centerRight,
                                        child: Padding(
                                          padding: EdgeInsets.only(right: 16, bottom: 8),
                                          child: ElevatedButton(
                                            onPressed: () {
                                              Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                  builder: (context) => KelolaPengeluaran(idPemasukan: pengeluaranIds[index]),
                                                ),
                                              );
                                            },
                                            style: ElevatedButton.styleFrom(
                                              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
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
                      },
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Container(
        padding: EdgeInsets.symmetric(horizontal: 15),
        height: 70,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Text(
                  "Total: ",
                  style: TextStyle(fontSize: 19, fontWeight: FontWeight.bold),
                ),
                SizedBox(width: 15),
                Text(
                  formatCurrency.format(totalPengeluaran),
                  style: TextStyle(fontSize: 19, fontWeight: FontWeight.bold, color: Colors.indigo),
                ),
              ],
            ),
          ],
        ),
      ),
      floatingActionButton: isApiActive
          ? FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => TambahPengeluaran()),
          );
        },
        child: Icon(Icons.add, color: Colors.white),
        backgroundColor: Colors.indigo,
      )
          : null, // Hide FloatingActionButton when isApiActive is false
      drawer: DrawerWidget(),
    );
  }
}
