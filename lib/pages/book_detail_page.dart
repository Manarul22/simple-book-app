import 'package:flutter/material.dart';
import 'package:books_app/models/book_images.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import '../providers/book_provider.dart';

class BookDetailPage extends StatefulWidget {
  const BookDetailPage(
      {super.key, required this.isbn13, required this.imageAsset});

  final String isbn13;
  final String imageAsset;

  @override
  State<BookDetailPage> createState() => _BookDetailPageState();
}

class _BookDetailPageState extends State<BookDetailPage> {
  BookProvider? bookProvider;
  Map<String, dynamic>? detailBook;

  @override
  void initState() {
    super.initState();
    bookProvider = Provider.of<BookProvider>(context, listen: false);
    bookProvider?.getDetailBook(widget.isbn13);
    detailBook = bookProvider?.bookDetail;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Detail Book'),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.share),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 20),
            // card detail
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Image Detail
                  Expanded(
                    flex: 1,
                    child: SizedBox(
                      child: Image.asset(widget.imageAsset),
                    ),
                  ),
                  const SizedBox(width: 10),
                  // Title, authors, subtitle, price detail
                  Expanded(
                    flex: 2,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '${detailBook?['title']}',
                          style: const TextStyle(
                              fontSize: 20, fontWeight: FontWeight.w700),
                        ),
                        Text(
                          '${detailBook?['authors']}',
                          style: const TextStyle(color: Colors.grey),
                        ),
                        const SizedBox(height: 10),
                        Text(
                          '${detailBook?['subtitle']}',
                          style: const TextStyle(color: Colors.grey),
                        ),
                        const SizedBox(height: 4),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              '${detailBook?['price']}',
                              style: const TextStyle(
                                  color: Colors.green, fontSize: 18),
                            ),
                            // tampilan rating
                            // Row(
                            //   children: List.generate(5, (index) {
                            //     return Icon(
                            //       Icons.star,
                            //       color: index <
                            //               int.parse(detailBook?['rating'])
                            //           ? Colors.yellow
                            //           : Colors.grey,
                            //     );
                            //   }),
                            // ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            // button buy
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: SizedBox(
                height: 36,
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () async {
                    Uri url = Uri.parse(detailBook?['url']);
                    try {
                      (await canLaunchUrl(url))
                          ? launchUrl(url)
                          // ignore: avoid_print
                          : print('tidak bisa membuka');
                    } catch (e) {
                      rethrow;
                    }
                  },
                  child: const Text('Buy'),
                ),
              ),
            ),
            const SizedBox(height: 50),
            // text description
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Text(
                '${detailBook?['desc']}',
                maxLines: 5,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            const SizedBox(height: 8),
            // textbutton readmore
            TextButton(
              onPressed: () {},
              child: const Text(
                'Read More',
                style:
                    TextStyle(fontWeight: FontWeight.w600, color: Colors.blue),
              ),
            ),
            const SizedBox(height: 20),
            // text simillar book and text btn more
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Simillar',
                    style: TextStyle(fontWeight: FontWeight.w500),
                  ),
                  TextButton(
                    onPressed: () {},
                    child: const Text(
                      'More',
                      style: TextStyle(
                          fontWeight: FontWeight.w600, color: Colors.blue),
                    ),
                  ),
                ],
              ),
            ),
            // Horizontal list book
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Padding(
                padding: const EdgeInsets.only(left: 20),
                child: Row(
                  children: List.generate(bookImages.length, (index) {
                    return Padding(
                      padding: const EdgeInsets.only(right: 8),
                      child: Container(
                        width: 100,
                        height: 150,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage(bookImages[index]),
                          ),
                        ),
                      ),
                    );
                  }).toList(),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
