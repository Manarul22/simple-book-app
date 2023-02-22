import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/book_provider.dart';
import 'book_detail_page.dart';
import 'package:books_app/models/book_images.dart';

class BookListPage extends StatelessWidget {
  const BookListPage({super.key});

  @override
  Widget build(BuildContext context) {
    BookProvider bookProvider = Provider.of<BookProvider>(context);
    var listBook = bookProvider.allBook;
    return Scaffold(
      appBar: AppBar(
        title: const Text('List Book'),
        centerTitle: true,
      ),
      body: FutureBuilder(
          future: bookProvider.getAllBook(),
          builder: (context, snapshot) {
            // tampilkan circular loading ketika data sedang dimuat
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else {
              // tampilan text ketika data gagal dimuat
              if (listBook.isEmpty) {
                return const Center(
                  child: Text('Tidak ada data..'),
                );
              }
            }
            return ListView.builder(
              itemCount: listBook.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) {
                      return BookDetailPage(
                        isbn13: listBook[index].isbn13,
                        imageAsset: bookImages[index],
                      );
                    }));
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    // Card Container
                    child: Card(
                      elevation: 5,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ListTile(
                          leading: Container(
                            width: 50,
                            height: 100,
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                  image: AssetImage(bookImages[index]),
                                  fit: BoxFit.cover),
                            ),
                          ),
                          title: Padding(
                            padding: const EdgeInsets.only(bottom: 4),
                            child: Text(listBook[index].title),
                          ),
                          subtitle: Text(listBook[index].subtitle),
                          trailing: Text(listBook[index].price),
                        ),
                      ),
                    ),
                  ),
                );
              },
            );
          }),
    );
  }
}
