import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

final List<String> gifUrls = [
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
    final reduceMotion = MediaQuery.disableAnimationsOf(context);
    return CarouselSlider(
      options: CarouselOptions(
        height: 200,
        autoPlay: !reduceMotion,
        enlargeCenterPage: true,
      ),
      items: gifUrls.indexed.map((entry) {
        final index = entry.$1;
        final url = entry.$2;
        return Builder(
          builder: (BuildContext context) {
            return Container(
              width: MediaQuery.of(context).size.width,
              margin: const EdgeInsets.symmetric(horizontal: 5.0),
              decoration: BoxDecoration(
                color: Colors.transparent,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Image.network(
                url,
                fit: BoxFit.cover,
                semanticLabel: 'Interactive Flutter demo ${index + 1}',
                errorBuilder: (context, error, stackTrace) => const ColoredBox(
                  color: Color(0xFF121212),
                  child: Center(
                    child: Icon(
                      Icons.image_not_supported_outlined,
                      color: Colors.white70,
                      semanticLabel: 'Demo image unavailable',
                    ),
                  ),
                ),
              ),
            );
          },
        );
      }).toList(),
    );
  }
}
