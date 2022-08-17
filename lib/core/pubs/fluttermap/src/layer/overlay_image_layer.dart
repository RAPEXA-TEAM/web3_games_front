import 'dart:async';

import 'package:flutter/widgets.dart';
import 'package:flutter_web3_games/core/pubs/fluttermap/flutter_map.dart';
import 'package:flutter_web3_games/core/pubs/fluttermap/src/map/map.dart';

class OverlayImageLayerOptions extends LayerOptions {
  final List<OverlayImage> overlayImages;

  OverlayImageLayerOptions({
    Key? key,
    this.overlayImages = const [],
    Stream<void>? rebuild,
  }) : super(key: key, rebuild: rebuild);
}

class OverlayImage {
  final LatLngBounds bounds;
  final ImageProvider imageProvider;
  final double opacity;
  final bool gaplessPlayback;

  OverlayImage({
    required this.bounds,
    required this.imageProvider,
    this.opacity = 1.0,
    this.gaplessPlayback = false,
  });
}

class OverlayImageLayerWidget extends StatelessWidget {
  final OverlayImageLayerOptions options;

  const OverlayImageLayerWidget({Key? key, required this.options})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final mapState = MapState.maybeOf(context)!;
    return OverlayImageLayer(options, mapState, mapState.onMoved);
  }
}

class OverlayImageLayer extends StatelessWidget {
  final OverlayImageLayerOptions overlayImageOpts;
  final MapState map;
  final Stream<void>? stream;

  OverlayImageLayer(this.overlayImageOpts, this.map, this.stream)
      : super(key: overlayImageOpts.key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<void>(
      stream: stream,
      builder: (BuildContext context, _) {
        return ClipRect(
          child: Stack(
            children: <Widget>[
              for (var overlayImage in overlayImageOpts.overlayImages)
                _positionedForOverlay(overlayImage),
            ],
          ),
        );
      },
    );
  }

  Positioned _positionedForOverlay(OverlayImage overlayImage) {
    final pixelOrigin = map.getPixelOrigin();
    final upperLeftPixel =
        map.project(overlayImage.bounds.northWest) - pixelOrigin;
    final bottomRightPixel =
        map.project(overlayImage.bounds.southEast) - pixelOrigin;
    return Positioned(
      left: upperLeftPixel.x.toDouble(),
      top: upperLeftPixel.y.toDouble(),
      width: (bottomRightPixel.x - upperLeftPixel.x).toDouble(),
      height: (bottomRightPixel.y - upperLeftPixel.y).toDouble(),
      child: Image(
        image: overlayImage.imageProvider,
        fit: BoxFit.fill,
        color: Color.fromRGBO(255, 255, 255, overlayImage.opacity),
        colorBlendMode: BlendMode.modulate,
        gaplessPlayback: overlayImage.gaplessPlayback,
      ),
    );
  }
}
