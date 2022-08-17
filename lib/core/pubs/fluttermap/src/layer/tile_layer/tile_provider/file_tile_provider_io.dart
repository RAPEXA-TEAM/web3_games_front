import 'dart:io';

import 'package:flutter/widgets.dart';
import 'package:flutter_web3_games/core/pubs/fluttermap/flutter_map.dart';

/// [TileProvider] that uses [FileImage] internally on platforms other than web
class FileTileProvider extends TileProvider {
  FileTileProvider();

  @override
  ImageProvider getImage(Coords<num> coords, TileLayerOptions options) {
    return FileImage(File(getTileUrl(coords, options)));
  }
}
