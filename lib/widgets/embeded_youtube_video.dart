import 'dart:html' as html;
import 'dart:ui' as ui;

import 'package:flutter/material.dart';

class EmbededYoutubeVideo extends StatefulWidget {
  const EmbededYoutubeVideo({super.key});

  @override
  State<EmbededYoutubeVideo> createState() => _EmbededYoutubeVideoState();
}

class _EmbededYoutubeVideoState extends State<EmbededYoutubeVideo>
    with AutomaticKeepAliveClientMixin {
  final String viewID = 'youtube-video-${UniqueKey()}';

  @override
  Widget build(BuildContext context) {
    super.build(context);
    // ignore: undefined_prefixed_name
    ui.platformViewRegistry.registerViewFactory(
        viewID,
        (int id) => html.IFrameElement()
          ..width = MediaQuery.of(context).size.width.toString()
          ..height = MediaQuery.of(context).size.height.toString()
          ..src = 'https://www.youtube.com/embed/IyFZznAk69U'
          ..style.border = 'none');

    return SizedBox(
      height: 500,
      child: HtmlElementView(
        viewType: viewID,
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
