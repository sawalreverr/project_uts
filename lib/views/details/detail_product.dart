import 'package:flutter/material.dart';
import '../../helper/formatHelper.dart';

class DetailProduct extends StatelessWidget {
  final String title;
  final String imageURL;
  final double price;
  final double rating;
  final int quantity;
  final String description;
  final String category;

  const DetailProduct(
      {required this.title,
      required this.imageURL,
      required this.price,
      required this.rating,
      required this.quantity,
      required this.description,
      required this.category});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Detail Produk"),
        backgroundColor: Color(0xff186F65),
        elevation: 2,
        foregroundColor: Colors.white,
      ),
      body: detailProduk(),
    );
  }

  SingleChildScrollView detailProduk() {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Image.network(
            imageURL,
            height: 300,
            fit: BoxFit.cover,
          ),
          Padding(
            padding:
                const EdgeInsets.only(top: 10, left: 16, right: 16, bottom: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  CurrencyFormat.convertToIdr(price * 15000, 0),
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                Text(
                  title,
                  style: TextStyle(fontSize: 16),
                ),
                SizedBox(height: 10),
                Row(
                  children: [
                    Text(
                      "Terjual: ${quantity}+",
                      style: TextStyle(fontSize: 14),
                    ),
                    SizedBox(width: 8),
                    Card(
                      shape: RoundedRectangleBorder(
                          side: BorderSide(color: Colors.grey),
                          borderRadius: BorderRadius.circular(10)),
                      elevation: 0,
                      child: Padding(
                        padding: EdgeInsets.only(
                            top: 3, bottom: 3, left: 12, right: 12),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Icon(
                              Icons.star_rounded,
                              color: Color(0xff186F65),
                              size: 20,
                            ),
                            SizedBox(width: 3),
                            Text(
                              "${rating}",
                              style: TextStyle(fontSize: 14),
                            )
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 12),
                Text(
                  "Detail produk",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 6),
                Row(
                  children: [
                    Text("Kondisi", style: TextStyle(fontSize: 14)),
                    SizedBox(width: 88),
                    Text("Baru")
                  ],
                ),
                Divider(),
                Row(
                  children: [
                    Text("Min. Pemesanan", style: TextStyle(fontSize: 14)),
                    SizedBox(width: 24),
                    Text("1 Buah")
                  ],
                ),
                Divider(),
                Row(
                  children: [
                    Text("Kategori", style: TextStyle(fontSize: 14)),
                    SizedBox(width: 80),
                    Text(
                      "${category}",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Color(0xff186F65)),
                    )
                  ],
                ),
                Divider(),
                SizedBox(height: 12),
                Text(
                  "Deskripsi produk",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 6),
                Text("${description}")
              ],
            ),
          ),
          Padding(
              padding: const EdgeInsets.only(bottom: 4, left: 16, right: 16),
              child: ElevatedButton(
                onPressed: () {},
                child: Text(
                  "Beli Produk",
                  style: TextStyle(color: Colors.white),
                ),
                style: ButtonStyle(
                    backgroundColor:
                        MaterialStatePropertyAll<Color>(Color(0xff186F65))),
              ))
        ],
      ),
    );
  }
}
