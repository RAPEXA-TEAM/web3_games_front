import 'dart:io';

import 'package:flutter/widgets.dart';
import 'package:http/http.dart';
import 'package:http/retry.dart';

import 'package:flutter_web3_games/core/pubs/fluttermap/flutter_map.dart';
import 'package:flutter_web3_games/core/pubs/fluttermap/src/layer/tile_layer/tile_provider/network_image_provider.dart';
import 'package:flutter_web3_games/core/pubs/fluttermap/src/layer/tile_layer/tile_provider/network_no_retry_image_provider.dart';

/// [TileProvider] that uses [FMNetworkImageProvider] internally
///
/// This image provider automatically retries some failed requests up to 3 times.
///
/// Note that this provider may be slower than [NetworkNoRetryTileProvider] when fetching tiles due to internal reasons.
///
/// Note that the 'User-Agent' header and the [RetryClient] cannot be changed, on the web platform.
class NetworkTileProvider extends TileProvider {
  NetworkTileProvider({
    Map<String, String>? headers,
    RetryClient? retryClient,
  }) {
    this.headers = headers ?? {};
    this.retryClient = retryClient ?? RetryClient(Client());
  }

  late final RetryClient retryClient;

  @override
  ImageProvider getImage(Coords<num> coords, TileLayerOptions options) =>
      HttpOverrides.runZoned<FMNetworkImageProvider>(
        () => FMNetworkImageProvider(
          getTileUrl(coords, options),
          headers: headers,
          retryClient: retryClient,
        ),
        createHttpClient: (c) => _FlutterMapHTTPOverrides().createHttpClient(c),
      );
}

/// [TileProvider] that uses [FMNetworkNoRetryImageProvider] internally
///
/// This image provider does not automatically retry any failed requests. This provider is the default and the recommended provider, unless your tile server is especially unreliable.
///
/// Note that the 'User-Agent' header and the [HttpClient] cannot be changed, on the web platform.
class NetworkNoRetryTileProvider extends TileProvider {
  NetworkNoRetryTileProvider({
    Map<String, String>? headers,
    HttpClient? httpClient,
  }) {
    this.headers = headers ?? {};
    this.httpClient = httpClient ?? HttpClient()
      ..userAgent = null;
  }

  late final HttpClient httpClient;

  @override
  ImageProvider getImage(Coords<num> coords, TileLayerOptions options) =>
      FMNetworkNoRetryImageProvider(
        getTileUrl(coords, options),
        headers: headers,
        httpClient: httpClient,
      );
}

/// Deprecated due to internal refactoring. The name is misleading, as the internal [ImageProvider] always caches, and this is recommended by most tile servers anyway. For the same functionality, migrate to [NetworkNoRetryTileProvider] before the next minor update.
@Deprecated(
    '`NonCachingNetworkTileProvider` has been deprecated due to internal refactoring. The name is misleading, as the internal `ImageProvider` always caches, and this is recommended by most tile servers anyway. For the same functionality, migrate to `NetworkNoRetryTileProvider` before the next minor update.')
class NonCachingNetworkTileProvider extends TileProvider {
  NonCachingNetworkTileProvider({
    Map<String, String>? headers,
    HttpClient? httpClient,
  }) {
    this.headers = headers ?? {};
    this.httpClient = httpClient ?? HttpClient()
      ..userAgent = null;
  }

  late final HttpClient httpClient;

  @override
  ImageProvider getImage(Coords<num> coords, TileLayerOptions options) =>
      NetworkNoRetryTileProvider(
        headers: headers,
        httpClient: httpClient,
      ).getImage(coords, options);
}

class AssetTileProvider extends TileProvider {
  AssetTileProvider();

  @override
  ImageProvider getImage(Coords<num> coords, TileLayerOptions options) {
    return AssetImage(getTileUrl(coords, options));
  }
}

/// A very basic [TileProvider] implementation, that can be extended to create your own provider
///
/// Using this method is not recommended any more, except for very simple custom [TileProvider]s. Instead, visit the online documentation at https://docs.fleaflet.dev/plugins/making-a-plugin/creating-new-tile-providers.
class CustomTileProvider extends TileProvider {
  final String Function(Coords coors, TileLayerOptions options) customTileUrl;

  CustomTileProvider({required this.customTileUrl});

  @override
  String getTileUrl(Coords coords, TileLayerOptions options) {
    return customTileUrl(coords, options);
  }

  @override
  ImageProvider getImage(Coords<num> coords, TileLayerOptions options) {
    return AssetImage(getTileUrl(coords, options));
  }
}

class _FlutterMapHTTPOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)..userAgent = null;
  }
}
