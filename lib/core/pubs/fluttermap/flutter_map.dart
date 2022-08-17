library flutter_map;

import 'dart:async';
import 'dart:math';

import 'package:flutter/gestures.dart';
import 'package:flutter/widgets.dart';
import 'package:latlong2/latlong.dart';
import 'package:positioned_tap_detector_2/positioned_tap_detector_2.dart';

import 'package:flutter_web3_games/core/pubs/fluttermap/src/core/center_zoom.dart';
import 'package:flutter_web3_games/core/pubs/fluttermap/src/core/point.dart';
import 'package:flutter_web3_games/core/pubs/fluttermap/src/geo/crs/crs.dart';
import 'package:flutter_web3_games/core/pubs/fluttermap/src/geo/latlng_bounds.dart';
import 'package:flutter_web3_games/core/pubs/fluttermap/src/gestures/interactive_flag.dart';
import 'package:flutter_web3_games/core/pubs/fluttermap/src/gestures/map_events.dart';
import 'package:flutter_web3_games/core/pubs/fluttermap/src/gestures/multi_finger_gesture.dart';
import 'package:flutter_web3_games/core/pubs/fluttermap/src/layer/layer.dart';
import 'package:flutter_web3_games/core/pubs/fluttermap/src/map/flutter_map_state.dart';
import 'package:flutter_web3_games/core/pubs/fluttermap/src/map/map.dart';
import 'package:flutter_web3_games/core/pubs/fluttermap/src/plugins/plugin.dart';

export 'package:flutter_web3_games/core/pubs/fluttermap/src/core/center_zoom.dart';
export 'package:flutter_web3_games/core/pubs/fluttermap/src/core/point.dart';
export 'package:flutter_web3_games/core/pubs/fluttermap/src/geo/crs/crs.dart';
export 'package:flutter_web3_games/core/pubs/fluttermap/src/geo/latlng_bounds.dart';
export 'package:flutter_web3_games/core/pubs/fluttermap/src/gestures/interactive_flag.dart';
export 'package:flutter_web3_games/core/pubs/fluttermap/src/gestures/map_events.dart';
export 'package:flutter_web3_games/core/pubs/fluttermap/src/gestures/multi_finger_gesture.dart';
export 'package:flutter_web3_games/core/pubs/fluttermap/src/layer/attribution_layer.dart';
export 'package:flutter_web3_games/core/pubs/fluttermap/src/layer/circle_layer.dart';
export 'package:flutter_web3_games/core/pubs/fluttermap/src/layer/group_layer.dart';
export 'package:flutter_web3_games/core/pubs/fluttermap/src/layer/layer.dart';
export 'package:flutter_web3_games/core/pubs/fluttermap/src/layer/marker_layer.dart';
export 'package:flutter_web3_games/core/pubs/fluttermap/src/layer/overlay_image_layer.dart';
export 'package:flutter_web3_games/core/pubs/fluttermap/src/layer/polygon_layer.dart';
export 'package:flutter_web3_games/core/pubs/fluttermap/src/layer/polyline_layer.dart';
export 'package:flutter_web3_games/core/pubs/fluttermap/src/layer/tile_layer/coords.dart';
export 'package:flutter_web3_games/core/pubs/fluttermap/src/layer/tile_layer/tile.dart';
export 'package:flutter_web3_games/core/pubs/fluttermap/src/layer/tile_layer/tile_builder.dart';
export 'package:flutter_web3_games/core/pubs/fluttermap/src/layer/tile_layer/tile_layer.dart';
export 'package:flutter_web3_games/core/pubs/fluttermap/src/layer/tile_layer/tile_provider/base_tile_provider.dart';
export 'package:flutter_web3_games/core/pubs/fluttermap/src/layer/tile_layer/tile_provider/file_tile_provider_io.dart'
    if (dart.library.html) 'package:flutter_web3_games/core/pubs/fluttermap/src/layer/tile_layer/tile_provider/file_tile_provider_web.dart';
export 'package:flutter_web3_games/core/pubs/fluttermap/src/layer/tile_layer/tile_provider/tile_provider_io.dart'
    if (dart.library.html) 'package:flutter_web3_games/core/pubs/fluttermap/src/layer/tile_layer/tile_provider/tile_provider_web.dart';
export 'package:flutter_web3_games/core/pubs/fluttermap/src/plugins/plugin.dart';

/// Renders a map composed of a list of layers powered by [LayerOptions].
///
/// Use a [MapController] to interact programmatically with the map.
///
/// Through [MapOptions] map's callbacks and properties can be defined.
class FlutterMap extends StatefulWidget {
  /// A set of layers' options to used to create the layers on the map.
  ///
  /// Usually a list of [TileLayerOptions], [MarkerLayerOptions] and
  /// [PolylineLayerOptions].
  ///
  /// These layers will render above [children]
  final List<LayerOptions> layers;

  /// These layers won't be rotated.
  /// Usually these are plugins which are floating above [layers]
  ///
  /// These layers will render above [nonRotatedChildren]
  final List<LayerOptions> nonRotatedLayers;

  /// A set of layers' widgets to used to create the layers on the map.
  final List<Widget> children;

  /// These layers won't be rotated.
  ///
  /// These layers will render above [layers]
  final List<Widget> nonRotatedChildren;

  /// [MapOptions] to create a [MapState] with.
  ///
  /// This property must not be null.
  final MapOptions options;

  /// A [MapController], used to control the map.
  final MapController mapController;

  FlutterMap({
    Key? key,
    required this.options,
    this.layers = const [],
    this.nonRotatedLayers = const [],
    this.children = const [],
    this.nonRotatedChildren = const [],
    MapController? mapController,
  })  : mapController = mapController ?? MapController(),
        super(key: key);

  @override
  FlutterMapState createState() => FlutterMapState();
}

/// Controller to programmatically interact with [FlutterMap].
///
/// It allows for map movement through [move], rotation through [rotate]
/// and to fit the map bounds with [fitBounds].
///
/// It also provides current map properties.
abstract class MapController {
  /// Moves the map to a specific location and zoom level
  ///
  /// Optionally provide [id] attribute and if you listen to [mapEventStream]
  /// later a [MapEventMove] event will be emitted (if move was success) with
  /// same [id] attribute. Event's source attribute will be
  /// [MapEventSource.mapController].
  ///
  /// returns `true` if move was success (for example it won't be success if
  /// navigating to same place with same zoom or if center is out of bounds and
  /// [MapOptions.slideOnBoundaries] isn't enabled)
  bool move(LatLng center, double zoom, {String? id});

  /// Sets the map rotation to a certain degrees angle (in decimal).
  ///
  /// Optionally provide [id] attribute and if you listen to [mapEventStream]
  /// later a [MapEventRotate] event will be emitted (if rotate was success)
  /// with same [id] attribute. Event's source attribute will be
  /// [MapEventSource.mapController].
  ///
  /// returns `true` if rotate was success (it won't be success if rotate is
  /// same as the old rotate)
  bool rotate(double degree, {String? id});

  /// Calls [move] and [rotate] together however layers will rebuild just once
  /// instead of twice
  MoveAndRotateResult moveAndRotate(LatLng center, double zoom, double degree,
      {String? id});

  /// Fits the map bounds. Optional constraints can be defined
  /// through the [options] parameter.
  void fitBounds(LatLngBounds bounds, {FitBoundsOptions? options});

  /// Calcs the new center and zoom for the map bounds. Optional constraints can be defined
  /// through the [options] parameter.
  CenterZoom centerZoomFitBounds(LatLngBounds bounds,
      {FitBoundsOptions? options});

  Future<void> get onReady;

  LatLng get center;

  LatLngBounds? get bounds;

  double get zoom;

  double get rotation;

  Stream<MapEvent> get mapEventStream;

  StreamSink<MapEvent> get mapEventSink;

  set state(MapState state);

  void dispose();

  LatLng? pointToLatLng(CustomPoint point);

  factory MapController() => MapControllerImpl();
}

typedef TapCallback = void Function(TapPosition tapPosition, LatLng point);
typedef LongPressCallback = void Function(
    TapPosition tapPosition, LatLng point);
typedef PointerDownCallback = void Function(
    PointerDownEvent event, LatLng point);
typedef PointerUpCallback = void Function(PointerUpEvent event, LatLng point);
typedef PointerCancelCallback = void Function(
    PointerCancelEvent event, LatLng point);
typedef PointerHoverCallback = void Function(
    PointerHoverEvent event, LatLng point);
typedef PositionCallback = void Function(MapPosition position, bool hasGesture);
typedef MapCreatedCallback = void Function(MapController mapController);

/// Allows you to provide your map's starting properties for [zoom], [rotation]
/// and [center]. Alternatively you can provide [bounds] instead of [center].
/// If both, [center] and [bounds] are provided, bounds will take preference
/// over [center].
/// Zoom, pan boundary and interactivity constraints can be specified here too.
///
/// Callbacks for [onTap], [onLongPress] and [onPositionChanged] can be
/// registered here.
///
/// Through [crs] the Coordinate Reference System can be
/// defined, it defaults to [Epsg3857].
///
/// Checks if a coordinate is outside of the map's
/// defined boundaries.
///
/// If you download offline tiles dynamically, you can set [adaptiveBoundaries]
/// to true (make sure to pass [screenSize] and an external [controller]), which
/// will enforce panning/zooming to ensure there is never a need to display
/// tiles outside the boundaries set by [swPanBoundary] and [nePanBoundary].
class MapOptions {
  final Crs crs;
  final double zoom;
  final double rotation;

  /// Prints multi finger gesture winner Helps to fine adjust
  /// [rotationThreshold] and [pinchZoomThreshold] and [pinchMoveThreshold]
  /// Note: only takes effect if [enableMultiFingerGestureRace] is true
  final bool debugMultiFingerGestureWinner;

  /// If true then [rotationThreshold] and [pinchZoomThreshold] and
  /// [pinchMoveThreshold] will race If multiple gestures win at the same time
  /// then precedence: [pinchZoomWinGestures] > [rotationWinGestures] >
  /// [pinchMoveWinGestures]
  final bool enableMultiFingerGestureRace;

  /// Rotation threshold in degree default is 20.0 Map starts to rotate when
  /// [rotationThreshold] has been achieved or another multi finger gesture wins
  /// which allows [MultiFingerGesture.rotate] Note: if [interactiveFlags]
  /// doesn't contain [InteractiveFlag.rotate] or [enableMultiFingerGestureRace]
  /// is false then rotate cannot win
  final double rotationThreshold;

  /// When [rotationThreshold] wins over [pinchZoomThreshold] and
  /// [pinchMoveThreshold] then [rotationWinGestures] gestures will be used. By
  /// default only [MultiFingerGesture.rotate] gesture will take effect see
  /// [MultiFingerGesture] for custom settings
  final int rotationWinGestures;

  /// Pinch Zoom threshold default is 0.5 Map starts to zoom when
  /// [pinchZoomThreshold] has been achieved or another multi finger gesture
  /// wins which allows [MultiFingerGesture.pinchZoom] Note: if
  /// [interactiveFlags] doesn't contain [InteractiveFlag.pinchZoom] or
  /// [enableMultiFingerGestureRace] is false then zoom cannot win
  final double pinchZoomThreshold;

  /// When [pinchZoomThreshold] wins over [rotationThreshold] and
  /// [pinchMoveThreshold] then [pinchZoomWinGestures] gestures will be used. By
  /// default [MultiFingerGesture.pinchZoom] and [MultiFingerGesture.pinchMove]
  /// gestures will take effect see [MultiFingerGesture] for custom settings
  final int pinchZoomWinGestures;

  /// Pinch Move threshold default is 40.0 (note: this doesn't take any effect
  /// on drag) Map starts to move when [pinchMoveThreshold] has been achieved or
  /// another multi finger gesture wins which allows
  /// [MultiFingerGesture.pinchMove] Note: if [interactiveFlags] doesn't contain
  /// [InteractiveFlag.pinchMove] or [enableMultiFingerGestureRace] is false
  /// then pinch move cannot win
  final double pinchMoveThreshold;

  /// When [pinchMoveThreshold] wins over [rotationThreshold] and
  /// [pinchZoomThreshold] then [pinchMoveWinGestures] gestures will be used. By
  /// default [MultiFingerGesture.pinchMove] and [MultiFingerGesture.pinchZoom]
  /// gestures will take effect see [MultiFingerGesture] for custom settings
  final int pinchMoveWinGestures;

  /// If true then the map will scroll when the user uses the scroll wheel on
  /// his mouse. This is supported on web and desktop, but might also work well
  /// on Android. A [Listener] is used to capture the onPointerSignal events.
  final bool enableScrollWheel;
  final double scrollWheelVelocity;

  final double? minZoom;
  final double? maxZoom;

  /// see [InteractiveFlag] for custom settings
  final int interactiveFlags;

  final bool allowPanning;
  final bool allowPanningOnScrollingParent;

  final TapCallback? onTap;
  final LongPressCallback? onLongPress;
  final PointerDownCallback? onPointerDown;
  final PointerUpCallback? onPointerUp;
  final PointerCancelCallback? onPointerCancel;
  final PointerHoverCallback? onPointerHover;
  final PositionCallback? onPositionChanged;
  final MapCreatedCallback? onMapCreated;
  final List<MapPlugin> plugins;
  final bool slideOnBoundaries;
  final Size? screenSize;
  final bool adaptiveBoundaries;
  final MapController? controller;
  final LatLng center;
  final LatLngBounds? bounds;
  final FitBoundsOptions boundsOptions;
  final LatLng? swPanBoundary;
  final LatLng? nePanBoundary;

  /// Restrict outer edges of map to LatLng Bounds, to prevent gray areas when
  /// panning or zooming. LatLngBounds(LatLng(-90, -180.0), LatLng(90.0, 180.0))
  /// would represent the full extent of the map, so no gray area outside of it.
  final LatLngBounds? maxBounds;

  _SafeArea? _safeAreaCache;
  double? _safeAreaZoom;

  MapOptions({
    this.allowPanningOnScrollingParent = true,
    this.crs = const Epsg3857(),
    LatLng? center,
    this.bounds,
    this.boundsOptions = const FitBoundsOptions(),
    this.zoom = 13.0,
    this.rotation = 0.0,
    this.debugMultiFingerGestureWinner = false,
    this.enableMultiFingerGestureRace = false,
    this.rotationThreshold = 20.0,
    this.rotationWinGestures = MultiFingerGesture.rotate,
    this.pinchZoomThreshold = 0.5,
    this.pinchZoomWinGestures =
        MultiFingerGesture.pinchZoom | MultiFingerGesture.pinchMove,
    this.pinchMoveThreshold = 40.0,
    this.pinchMoveWinGestures =
        MultiFingerGesture.pinchZoom | MultiFingerGesture.pinchMove,
    this.enableScrollWheel = true,
    this.scrollWheelVelocity = 0.005,
    this.minZoom,
    this.maxZoom,
    this.interactiveFlags = InteractiveFlag.all,
    this.allowPanning = true,
    this.onTap,
    this.onLongPress,
    this.onPointerDown,
    this.onPointerUp,
    this.onPointerCancel,
    this.onPointerHover,
    this.onPositionChanged,
    this.onMapCreated,
    this.plugins = const [],
    this.slideOnBoundaries = false,
    this.adaptiveBoundaries = false,
    this.screenSize,
    this.controller,
    this.swPanBoundary,
    this.nePanBoundary,
    this.maxBounds,
  })  : center = center ?? LatLng(50.5, 30.51),
        assert(rotationThreshold >= 0.0),
        assert(pinchZoomThreshold >= 0.0),
        assert(pinchMoveThreshold >= 0.0) {
    _safeAreaZoom = zoom;
    assert(slideOnBoundaries ||
        !isOutOfBounds(center)); //You cannot start outside pan boundary
    assert(!adaptiveBoundaries || screenSize != null,
        'screenSize must be set in order to enable adaptive boundaries.');
    assert(!adaptiveBoundaries || controller != null,
        'controller must be set in order to enable adaptive boundaries.');
  }

  //if there is a pan boundary, do not cross
  bool isOutOfBounds(LatLng? center) {
    if (adaptiveBoundaries) {
      return !_safeArea!.contains(center);
    }
    if (swPanBoundary != null && nePanBoundary != null) {
      if (center == null) {
        return true;
      } else if (center.latitude < swPanBoundary!.latitude ||
          center.latitude > nePanBoundary!.latitude) {
        return true;
      } else if (center.longitude < swPanBoundary!.longitude ||
          center.longitude > nePanBoundary!.longitude) {
        return true;
      }
    }
    return false;
  }

  LatLng containPoint(LatLng point, LatLng fallback) {
    if (adaptiveBoundaries) {
      return _safeArea!.containPoint(point, fallback);
    } else {
      return LatLng(
        point.latitude.clamp(swPanBoundary!.latitude, nePanBoundary!.latitude),
        point.longitude
            .clamp(swPanBoundary!.longitude, nePanBoundary!.longitude),
      );
    }
  }

  _SafeArea? get _safeArea {
    final controllerZoom = _getControllerZoom();
    if (controllerZoom != _safeAreaZoom || _safeAreaCache == null) {
      _safeAreaZoom = controllerZoom;
      final halfScreenHeight = _calculateScreenHeightInDegrees() / 2;
      final halfScreenWidth = _calculateScreenWidthInDegrees() / 2;
      final southWestLatitude = swPanBoundary!.latitude + halfScreenHeight;
      final southWestLongitude = swPanBoundary!.longitude + halfScreenWidth;
      final northEastLatitude = nePanBoundary!.latitude - halfScreenHeight;
      final northEastLongitude = nePanBoundary!.longitude - halfScreenWidth;
      _safeAreaCache = _SafeArea(
        LatLng(
          southWestLatitude,
          southWestLongitude,
        ),
        LatLng(
          northEastLatitude,
          northEastLongitude,
        ),
      );
    }
    return _safeAreaCache;
  }

  double _calculateScreenWidthInDegrees() {
    final zoom = _getControllerZoom();
    final degreesPerPixel = 360 / pow(2, zoom + 8);
    return screenSize!.width * degreesPerPixel;
  }

  double _calculateScreenHeightInDegrees() =>
      screenSize!.height * 170.102258 / pow(2, _getControllerZoom() + 8);

  double _getControllerZoom() => controller!.zoom;
}

class FitBoundsOptions {
  final EdgeInsets padding;
  final double maxZoom;
  final double? zoom;
  final bool inside;

  const FitBoundsOptions({
    this.padding = EdgeInsets.zero,
    this.maxZoom = 17.0,
    this.zoom,
    this.inside = false,
  });
}

/// Position's type for [PositionCallback].
class MapPosition {
  final LatLng? center;
  final LatLngBounds? bounds;
  final double? zoom;
  final bool hasGesture;

  MapPosition({this.center, this.bounds, this.zoom, this.hasGesture = false});

  @override
  int get hashCode => center.hashCode + bounds.hashCode + zoom.hashCode;

  @override
  bool operator ==(Object other) =>
      other is MapPosition &&
      other.center == center &&
      other.bounds == bounds &&
      other.zoom == zoom;
}

class _SafeArea {
  final LatLngBounds bounds;
  final bool isLatitudeBlocked;
  final bool isLongitudeBlocked;

  _SafeArea(LatLng southWest, LatLng northEast)
      : bounds = LatLngBounds(southWest, northEast),
        isLatitudeBlocked = southWest.latitude > northEast.latitude,
        isLongitudeBlocked = southWest.longitude > northEast.longitude;

  bool contains(LatLng? point) =>
      isLatitudeBlocked || isLongitudeBlocked ? false : bounds.contains(point);

  LatLng containPoint(LatLng point, LatLng fallback) => LatLng(
        isLatitudeBlocked
            ? fallback.latitude
            : point.latitude.clamp(bounds.south, bounds.north),
        isLongitudeBlocked
            ? fallback.longitude
            : point.longitude.clamp(bounds.west, bounds.east),
      );
}

class MoveAndRotateResult {
  final bool moveSuccess;
  final bool rotateSuccess;

  MoveAndRotateResult(this.moveSuccess, this.rotateSuccess);
}
