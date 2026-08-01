import 'dart:async';
import 'dart:math' as math;

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_osm_plugin/flutter_osm_plugin.dart';
import 'package:pointer_interceptor/pointer_interceptor.dart';

class OsmWidget extends StatefulWidget {
  const OsmWidget({super.key});

  @override
  State<OsmWidget> createState() => _OsmWidgetState();
}

class _OsmWidgetState extends State<OsmWidget> {
  late MapController controller;

  @override
  void initState() {
    super.initState();
    controller = MapController(
      initPosition: GeoPoint(
        latitude: 3.1582,
        longitude: 101.7122,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (kIsWeb) {
      return const WebOsmMap();
    }

    return OSMFlutter(
      controller: controller,
      osmOption: const OSMOption(
        isPicker: true,
        showZoomController: true,
        enableRotationByGesture: true,
      ),
      mapIsLoading: const Center(
        child: CircularProgressIndicator(),
      ),
      onMapIsReady: (isReady) {
        if (isReady) {
          controller.addMarker(
            GeoPoint(
              latitude: 3.1582,
              longitude: 101.7122,
            ),
            markerIcon: const MarkerIcon(
              icon: Icon(Icons.location_on, color: Colors.red),
            ),
          );
        }
      },
    );
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }
}

class WebOsmMap extends StatefulWidget {
  final Widget Function(String url)? tileBuilder;

  const WebOsmMap({
    super.key,
    this.tileBuilder,
  });

  @override
  State<WebOsmMap> createState() => _WebOsmMapState();
}

class _WebOsmMapState extends State<WebOsmMap> {
  static const _latitude = 3.1582;
  static const _longitude = 101.7122;
  static const _tileSize = 256.0;
  static const _tileRadius = 3;

  int _zoom = 14;
  Offset _pan = Offset.zero;

  double _tileX(double longitude, int zoom) {
    final tiles = math.pow(2, zoom).toDouble();
    return (longitude + 180) / 360 * tiles;
  }

  double _tileY(double latitude, int zoom) {
    final tiles = math.pow(2, zoom).toDouble();
    final radians = latitude * math.pi / 180;
    final mercator = math.log(
      math.tan(radians) + (1 / math.cos(radians)),
    );
    return (1 - (mercator / math.pi)) / 2 * tiles;
  }

  void _changeZoom(int delta) {
    setState(() {
      _zoom = (_zoom + delta).clamp(3, 18);
      _pan = Offset.zero;
    });
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final centerX = _tileX(_longitude, _zoom);
        final centerY = _tileY(_latitude, _zoom);
        final baseX = centerX.floor();
        final baseY = centerY.floor();
        final tileCount = math.pow(2, _zoom).toInt();

        return Semantics(
          label: 'OpenStreetMap centered on Kuala Lumpur',
          child: ClipRect(
            child: Stack(
              children: [
                Positioned.fill(
                  child: GestureDetector(
                    behavior: HitTestBehavior.opaque,
                    onPanUpdate: (details) {
                      setState(() {
                        _pan = Offset(
                          (_pan.dx + details.delta.dx).clamp(-220.0, 220.0),
                          (_pan.dy + details.delta.dy).clamp(-220.0, 220.0),
                        );
                      });
                    },
                    child: ColoredBox(
                      color: const Color(0xFFE8E4DD),
                      child: Stack(
                        children: [
                          for (var y = -_tileRadius; y <= _tileRadius; y++)
                            for (var x = -_tileRadius; x <= _tileRadius; x++)
                              Positioned(
                                left: constraints.maxWidth / 2 +
                                    ((baseX + x - centerX) * _tileSize) +
                                    _pan.dx,
                                top: constraints.maxHeight / 2 +
                                    ((baseY + y - centerY) * _tileSize) +
                                    _pan.dy,
                                width: _tileSize,
                                height: _tileSize,
                                child: _buildTile(
                                  'https://tile.openstreetmap.org/$_zoom/'
                                  '${(baseX + x) % tileCount}/'
                                  '${(baseY + y).clamp(0, tileCount - 1)}.png',
                                ),
                              ),
                        ],
                      ),
                    ),
                  ),
                ),
                Positioned(
                  left: (constraints.maxWidth / 2) - 18 + _pan.dx,
                  top: (constraints.maxHeight / 2) - 36 + _pan.dy,
                  child: const IgnorePointer(
                    child: Icon(
                      Icons.location_on,
                      color: Color(0xFFE7483D),
                      size: 36,
                      semanticLabel: 'Kuala Lumpur marker',
                    ),
                  ),
                ),
                Positioned(
                  top: 12,
                  right: 12,
                  child: Material(
                    elevation: 2,
                    borderRadius: BorderRadius.circular(12),
                    clipBehavior: Clip.antiAlias,
                    child: Column(
                      children: [
                        IconButton(
                          tooltip: 'Zoom in',
                          onPressed: _zoom == 18 ? null : () => _changeZoom(1),
                          icon: const Icon(Icons.add),
                        ),
                        const Divider(height: 1),
                        IconButton(
                          tooltip: 'Zoom out',
                          onPressed: _zoom == 3 ? null : () => _changeZoom(-1),
                          icon: const Icon(Icons.remove),
                        ),
                      ],
                    ),
                  ),
                ),
                Positioned(
                  right: 8,
                  bottom: 6,
                  child: DecoratedBox(
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.9),
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 6, vertical: 3),
                      child: Text(
                        '© OpenStreetMap contributors',
                        style: TextStyle(color: Colors.black87, fontSize: 11),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildTile(String url) {
    final tileBuilder = widget.tileBuilder;
    if (tileBuilder != null) {
      return tileBuilder(url);
    }

    return Image.network(
      url,
      fit: BoxFit.fill,
      filterQuality: FilterQuality.medium,
      excludeFromSemantics: true,
      errorBuilder: (context, error, stackTrace) => const ColoredBox(
        color: Color(0xFFD8D3C9),
      ),
    );
  }
}

class PickerOSM extends StatefulWidget {
  const PickerOSM({super.key});

  @override
  State<PickerOSM> createState() => _PickerOSMState();
}

class _PickerOSMState extends State<PickerOSM> {
  ValueNotifier<GeoPoint?> notifier = ValueNotifier(null);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ValueListenableBuilder<GeoPoint?>(
              valueListenable: notifier,
              builder: (ctx, p, child) {
                return Center(
                  child: Text(
                    p?.toString() ?? "",
                    textAlign: TextAlign.center,
                  ),
                );
              },
            ),
            Column(
              children: [
                ElevatedButton(
                  onPressed: () async {
                    var p = await Navigator.pushNamed(context, "/search");
                    if (p != null) {
                      notifier.value = p as GeoPoint;
                    }
                  },
                  child: const Text("pick address"),
                ),
                ElevatedButton(
                  onPressed: () async {
                    var p = await showSimplePickerLocation(
                      context: context,
                      isDismissible: true,
                      title: "location picker",
                      textConfirmPicker: "pick",
                      zoomOption: const ZoomOption(
                        initZoom: 8,
                      ),
                      initPosition: GeoPoint(
                        latitude: 47.4358055,
                        longitude: 8.4737324,
                      ),
                      radius: 8.0,
                    );
                    if (p != null) {
                      notifier.value = p;
                    }
                  },
                  child: const Text("show picker address"),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class SimpleOSM extends StatefulWidget {
  const SimpleOSM({super.key});

  @override
  State<StatefulWidget> createState() => SimpleOSMState();
}

class SimpleOSMState extends State<SimpleOSM>
    with AutomaticKeepAliveClientMixin {
  late MapController controller;

  @override
  void initState() {
    super.initState();
    controller = MapController(
      // initMapWithUserPosition: const UserTrackingOption(),
      initPosition: GeoPoint(
        latitude: 3.1582,
        longitude: 101.7122,
      ),
    );
  }

  @override
  @mustCallSuper
  Widget build(BuildContext context) {
    super.build(context);
    return OSMFlutter(
      controller: controller,
      osmOption: const OSMOption(
        isPicker: true,
        showZoomController: true,
        enableRotationByGesture: true,
      ),
      mapIsLoading: const Center(
        child: CircularProgressIndicator(),
      ),
      onMapIsReady: (isReady) {
        final randomCoor = GeoPoint(
          latitude: 3.15 +
              (0.01 * (1 - 2 * (DateTime.now().millisecondsSinceEpoch % 2))),
          longitude: 101.71 +
              (0.01 * (1 - 2 * (DateTime.now().millisecondsSinceEpoch % 2))),
        );
        controller.addMarker(
          randomCoor,
          markerIcon: const MarkerIcon(
            icon: Icon(Icons.location_on),
          ),
        );
      },
      onMapMoved: (c) {
        debugPrint('${c.center}');
      },
      onLocationChanged: (p0) {
        debugPrint('$p0');
      },
      onGeoPointClicked: (p0) {
        // show snackbar
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              'Latitude: ${p0.latitude}, Longitude: ${p0.longitude}',
            ),
          ),
        );

        // move to the location
        controller.moveTo(p0);
      },
    );
  }

  @override
  bool get wantKeepAlive => true;
}

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<StatefulWidget> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  late TextEditingController textEditingController = TextEditingController();
  late PickerMapController controller = PickerMapController(
    initMapWithUserPosition: const UserTrackingOption(),
  );

  @override
  void initState() {
    super.initState();
    textEditingController.addListener(textOnChanged);
  }

  void textOnChanged() {
    controller.setSearchableText(textEditingController.text);
  }

  @override
  void dispose() {
    textEditingController.removeListener(textOnChanged);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CustomPickerLocation(
      controller: controller,
      showDefaultMarkerPickWidget: true,
      topWidgetPicker: Padding(
        padding: const EdgeInsets.only(
          top: 56,
          left: 8,
          right: 8,
        ),
        child: Column(
          children: [
            Row(
              children: [
                PointerInterceptor(
                  child: TextButton(
                    style: TextButton.styleFrom(),
                    onPressed: () => Navigator.of(context).pop(),
                    child: const Icon(
                      Icons.arrow_back_ios,
                    ),
                  ),
                ),
                Expanded(
                  child: PointerInterceptor(
                    child: TextField(
                      controller: textEditingController,
                      onEditingComplete: () async {
                        FocusScope.of(context).requestFocus(FocusNode());
                      },
                      decoration: InputDecoration(
                        prefixIcon: const Icon(
                          Icons.search,
                          color: Colors.black,
                        ),
                        suffix: ValueListenableBuilder<TextEditingValue>(
                          valueListenable: textEditingController,
                          builder: (ctx, text, child) {
                            if (text.text.isNotEmpty) {
                              return child!;
                            }
                            return const SizedBox.shrink();
                          },
                          child: InkWell(
                            focusNode: FocusNode(),
                            onTap: () {
                              textEditingController.clear();
                              controller.setSearchableText("");
                              FocusScope.of(context).requestFocus(FocusNode());
                            },
                            child: const Icon(
                              Icons.close,
                              size: 16,
                              color: Colors.black,
                            ),
                          ),
                        ),
                        focusColor: Colors.black,
                        filled: true,
                        hintText: "search",
                        border: InputBorder.none,
                        enabledBorder: InputBorder.none,
                        fillColor: Colors.grey[300],
                        errorBorder: const OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.red),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 8,
            ),
            const TopSearchWidget()
          ],
        ),
      ),
      bottomWidgetPicker: Positioned(
        bottom: 12,
        right: 8,
        child: PointerInterceptor(
          child: FloatingActionButton(
            onPressed: () async {
              GeoPoint p = await controller.selectAdvancedPositionPicker();
              if (!context.mounted) return;
              Navigator.pop(context, p);
            },
            child: const Icon(Icons.arrow_forward),
          ),
        ),
      ),
      pickerConfig: const CustomPickerLocationConfig(
        zoomOption: ZoomOption(
          initZoom: 8,
        ),
      ),
    );
  }
}

class TopSearchWidget extends StatefulWidget {
  const TopSearchWidget({super.key});

  @override
  State<StatefulWidget> createState() => _TopSearchWidgetState();
}

class _TopSearchWidgetState extends State<TopSearchWidget> {
  late PickerMapController controller;
  ValueNotifier<GeoPoint?> notifierGeoPoint = ValueNotifier(null);
  ValueNotifier<bool> notifierAutoCompletion = ValueNotifier(false);

  late StreamController<List<SearchInfo>> streamSuggestion = StreamController();
  late Future<List<SearchInfo>> _futureSuggestionAddress;
  String oldText = "";
  Timer? _timerToStartSuggestionReq;
  final Key streamKey = const Key("streamAddressSug");

  @override
  void initState() {
    super.initState();
    controller = CustomPickerLocation.of(context);
    controller.searchableText.addListener(onSearchableTextChanged);
  }

  void onSearchableTextChanged() async {
    final v = controller.searchableText.value;
    if (v.length > 3 && oldText != v) {
      oldText = v;
      if (_timerToStartSuggestionReq != null &&
          _timerToStartSuggestionReq!.isActive) {
        _timerToStartSuggestionReq!.cancel();
      }
      _timerToStartSuggestionReq =
          Timer.periodic(const Duration(seconds: 3), (timer) async {
        await suggestionProcessing(v);
        timer.cancel();
      });
    }
    if (v.isEmpty) {
      await reInitStream();
    }
  }

  Future reInitStream() async {
    notifierAutoCompletion.value = false;
    await streamSuggestion.close();
    setState(() {
      streamSuggestion = StreamController();
    });
  }

  Future<void> suggestionProcessing(String addr) async {
    notifierAutoCompletion.value = true;
    _futureSuggestionAddress = addressSuggestion(
      addr,
      limitInformation: 5,
    );
    _futureSuggestionAddress.then((value) {
      streamSuggestion.sink.add(value);
    });
  }

  @override
  void dispose() {
    controller.searchableText.removeListener(onSearchableTextChanged);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<bool>(
      valueListenable: notifierAutoCompletion,
      builder: (ctx, isVisible, child) {
        return AnimatedContainer(
          duration: const Duration(
            milliseconds: 500,
          ),
          height: isVisible ? MediaQuery.of(context).size.height / 4 : 0,
          child: Card(
            child: child!,
          ),
        );
      },
      child: StreamBuilder<List<SearchInfo>>(
        stream: streamSuggestion.stream,
        key: streamKey,
        builder: (ctx, snap) {
          if (snap.hasData) {
            return ListView.builder(
              itemExtent: 50.0,
              itemBuilder: (ctx, index) {
                return PointerInterceptor(
                  child: ListTile(
                    title: Text(
                      snap.data![index].address.toString(),
                      maxLines: 1,
                      overflow: TextOverflow.fade,
                    ),
                    onTap: () async {
                      /// go to location selected by address
                      controller.goToLocation(
                        snap.data![index].point!,
                      );

                      /// hide suggestion card
                      notifierAutoCompletion.value = false;
                      await reInitStream();
                      if (!context.mounted) return;
                      FocusScope.of(context).requestFocus(
                        FocusNode(),
                      );
                    },
                  ),
                );
              },
              itemCount: snap.data!.length,
            );
          }
          if (snap.connectionState == ConnectionState.waiting) {
            return const Card(
              child: Center(
                child: CircularProgressIndicator(),
              ),
            );
          }
          return const SizedBox();
        },
      ),
    );
  }
}
