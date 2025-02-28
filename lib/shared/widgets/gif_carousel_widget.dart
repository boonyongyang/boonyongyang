import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

final List<String> gifUrls = [
  'https://i.giphy.com/media/v1.Y2lkPTc5MGI3NjExMHRyaDE1YXlxdzBqaTk0dGxneDVnZDR1M2Fya3Q1ODBpMW5icXRyeiZlcD12MV9pbnRlcm5hbF9naWZfYnlfaWQmY3Q9Zw/ZdIzhi10ZlKhU8EpDh/giphy.gif',
  'https://media.giphy.com/media/v1.Y2lkPTc5MGI3NjExaWUxczgxeThmYXFmdW1vaXUxNzBxdHUzejM4dW43a2xjaGZyMzNybyZlcD12MV9naWZzX3RyZW5kaW5nJmN0PWc/LTByspj8BjoVx9EPJq/giphy.gif',
  'https://media.giphy.com/media/FY8c5SKwiNf1EtZKGs/giphy.gif?cid=790b7611ie1s81y8faqfumoiu170qtu3z38un7klchfr33ro&ep=v1_gifs_trending&rid=giphy.gif&ct=g',
  'https://media.giphy.com/media/l1KVboXQeiaX7FHgI/giphy.gif?cid=790b76114a389p1a0e2mtigvhfnxue3ag49eomf772vmpj92&ep=v1_gifs_search&rid=giphy.gif&ct=g',
  'https://media.giphy.com/media/dUQL2bKltOU7cO9Maw/giphy.gif',
  'https://media.giphy.com/media/UCTaYoiR7pD2okgFK1/giphy.gif',
  'https://media.giphy.com/media/v1.Y2lkPTc5MGI3NjExNGEzODlwMWEwZTJtdGlndmhmbnh1ZTNhZzQ5ZW9tZjc3MnZtcGo5MiZlcD12MV9naWZzX3NlYXJjaCZjdD1n/SggILpMXO7Xt6/giphy.gif',
];

class GifCarousel extends StatelessWidget {
  const GifCarousel({super.key});

  @override
  Widget build(BuildContext context) {
    return CarouselSlider(
      options: CarouselOptions(
        height: 200,
        autoPlay: true,
        enlargeCenterPage: true,
      ),
      items: gifUrls.map((url) {
        return Builder(
          builder: (BuildContext context) {
            return Container(
              width: MediaQuery.of(context).size.width,
              margin: const EdgeInsets.symmetric(horizontal: 5.0),
              decoration: BoxDecoration(
                color: Colors.transparent,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Image.network(url),
            );
          },
        );
      }).toList(),
    );
  }
}
