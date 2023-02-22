import 'package:books_app/pages/book_list_page.dart';
import 'package:books_app/providers/book_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) {
        return BookProvider();
      },
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Books App',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: const BookListPage(),
      ),
    );
  }
}
