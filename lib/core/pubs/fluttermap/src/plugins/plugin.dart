import 'package:flutter/widgets.dart';
import 'package:flutter_web3_games/core/pubs/fluttermap/src/layer/layer.dart';
import 'package:flutter_web3_games/core/pubs/fluttermap/src/map/map.dart';

abstract class MapPlugin {
  bool supportsLayer(LayerOptions options);
  Widget createLayer(
      LayerOptions options, MapState mapState, Stream<void> stream);
}
