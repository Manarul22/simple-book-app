import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../models/book.dart';
import 'dart:convert';

class BookProvider with ChangeNotifier {

  // variabel penampung listbook
  final List<Book> allBook = [];

  Future getAllBook() async {
    var url = Uri.parse('https://api.itbook.store/1.0/new');
    var response = await http.get(url);
    // simpan type Map ke dalam bentuk List
    List datas = (json.decode(response.body) as Map<String, dynamic>)['books'];
    // loop list untuk mendapatkan listbook
    for (var element in datas) {
      allBook.add(Book.fromJson(element));
    }
   
  }
   

    // Map book detail
  Map<String, dynamic>? bookDetail;
  // Fetch Api Detail book with isbn13
  Future getDetailBook(isbn13) async {
    var url = Uri.parse('https://api.itbook.store/1.0/books/$isbn13');
    var response = await http.get(url);
    var data = json.decode(response.body) as Map<String, dynamic>;
    bookDetail = data;
  }

  @override
    notifyListeners();

}