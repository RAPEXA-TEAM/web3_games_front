import 'dart:async';
import 'dart:math' as math;

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/physics.dart';
import 'package:flutter_web3_games/core/pubs/fluttermap/flutter_map.dart';
import 'package:flutter_web3_games/core/pubs/fluttermap/src/gestures/latlng_tween.dart';
import 'package:flutter_web3_games/core/pubs/fluttermap/src/map/map.dart';
import 'package:latlong2/latlong.dart';
import 'package:positioned_tap_detector_2/positioned_tap_detector_2.dart';

abstract class MapGestureMixin extends State<FlutterMap>
    with TickerProviderStateMixin {
  static const int _kMinFlingVelocity = 800;

  var _dragMode = false;
  var _gestureWinner = MultiFingerGesture.none;

  var _pointerCounter = 0;

  void onPointerDown(PointerDownEvent event) {
    ++_pointerCounter;
    if (mapState.options.onPointerDown != null) {
      final latlng = _offsetToCrs(event.localPosition);
      mapState.options.onPointerDown!(event, latlng);
    }
  }

  void onPointerUp(PointerUpEvent event) {
    --_pointerCounter;
    if (mapState.options.onPointerUp != null) {
      final latlng = _offsetToCrs(event.localPosition);
      mapState.options.onPointerUp!(event, latlng);
    }
  }

  void onPointerCancel(PointerCancelEvent event) {
    --_pointerCounter;
    if (mapState.options.onPointerCancel != null) {
      final latlng = _offsetToCrs(event.localPosition);
      mapState.options.onPointerCancel!(event, latlng);
    }
  }

  void onPointerHover(PointerHoverEvent event) {
    if (mapState.options.onPointerHover != null) {
      final latlng = _offsetToCrs(event.localPosition);
      mapState.options.onPointerHover!(event, latlng);
    }
  }

  void onPointerSignal(PointerSignalEvent pointerSignal) {
    // Handle mouse scroll events if the enableScrollWheel parameter is enabled
    if (pointerSignal is PointerScrollEvent &&
        mapState.options.enableScrollWheel &&
        pointerSignal.scrollDelta.dy != 0) {
      // Calculate new zoom level
      final minZoom = mapState.options.minZoom ?? 0.0;
      final maxZoom = mapState.options.maxZoom ?? double.infinity;
      final newZoom = (mapState.zoom -
              pointerSignal.scrollDelta.dy *
                  mapState.options.scrollWheelVelocity)
          .clamp(minZoom, maxZoom);
      // Calculate offset of mouse cursor from viewport center
      final List<dynamic> newCenterZoom = _getNewEventCenterZoomPosition(
          _offsetToPoint(pointerSignal.localPosition), newZoom);

      // Move to new center and zoom level
      mapState.move(newCenterZoom[0] as LatLng, newCenterZoom[1] as double,
          source: MapEventSource.scrollWheel);
    }
  }

  var _rotationStarted = false;
  var _pinchZoomStarted = false;
  var _pinchMoveStarted = false;
  var _dragStarted = false;
  var _flingAnimationStarted = false;

  // Helps to reset ScaleUpdateDetails.scale back to 1.0 when a multi finger
  // gesture wins
  late double _scaleCorrector;

  late double _lastRotation;
  late double _lastScale;
  late Offset _lastFocalLocal;

  late LatLng _mapCenterStart;
  late double _mapZoomStart;
  late Offset _focalStartLocal;
  late LatLng _focalStartLatLng;

  late final AnimationController _flingController;
  late Animation<Offset> _flingAnimation;

  late final AnimationController _doubleTapController;
  late Animation<double> _doubleTapZoomAnimation;
  late Animation<LatLng> _doubleTapCenterAnimation;

  StreamSubscription<MapEvent>? _mapControllerAnimationInterruption;

  int _tapUpCounter = 0;
  Timer? _doubleTapHoldMaxDelay;

  @override
  FlutterMap get widget;

  MapState get mapState;

  MapController get mapController;

  MapOptions get options;

  @override
  void initState() {
    super.initState();
    _flingController = AnimationController(vsync: this)
      ..addListener(_handleFlingAnimation)
      ..addStatusListener(_flingAnimationStatusListener);
    _doubleTapController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 200))
      ..addListener(_handleDoubleTapZoomAnimation)
      ..addStatusListener(_doubleTapZoomStatusListener);
  }

  @override
  void didUpdateWidget(FlutterMap oldWidget) {
    super.didUpdateWidget(oldWidget);

    final oldFlags = oldWidget.options.interactiveFlags;
    final flags = options.interactiveFlags;

    final oldGestures =
        _getMultiFingerGestureFlags(mapOptions: oldWidget.options);
    final gestures = _getMultiFingerGestureFlags();

    if (flags != oldFlags || gestures != oldGestures) {
      var emitMapEventMoveEnd = false;

      if (!InteractiveFlag.hasFlag(flags, InteractiveFlag.flingAnimation)) {
        closeFlingAnimationController(MapEventSource.interactiveFlagsChanged);
      }
      if (!InteractiveFlag.hasFlag(flags, InteractiveFlag.doubleTapZoom)) {
        closeDoubleTapController(MapEventSource.interactiveFlagsChanged);
      }

      if (_rotationStarted &&
          !(InteractiveFlag.hasFlag(flags, InteractiveFlag.rotate) &&
              MultiFingerGesture.hasFlag(
                  gestures, MultiFingerGesture.rotate))) {
        _rotationStarted = false;

        if (_gestureWinner == MultiFingerGesture.rotate) {
          _gestureWinner = MultiFingerGesture.none;
        }

        mapState.emitMapEvent(
          MapEventRotateEnd(
            center: mapState.center,
            zoom: mapState.zoom,
            source: MapEventSource.interactiveFlagsChanged,
          ),
        );
      }

      if (_pinchZoomStarted &&
          !(InteractiveFlag.hasFlag(flags, InteractiveFlag.pinchZoom) &&
              MultiFingerGesture.hasFlag(
                  gestures, MultiFingerGesture.pinchZoom))) {
        _pinchZoomStarted = false;
        emitMapEventMoveEnd = true;

        if (_gestureWinner == MultiFingerGesture.pinchZoom) {
          _gestureWinner = MultiFingerGesture.none;
        }
      }

      if (_pinchMoveStarted &&
          !(InteractiveFlag.hasFlag(flags, InteractiveFlag.pinchMove) &&
              MultiFingerGesture.hasFlag(
                  gestures, MultiFingerGesture.pinchMove))) {
        _pinchMoveStarted = false;
        emitMapEventMoveEnd = true;

        if (_gestureWinner == MultiFingerGesture.pinchMove) {
          _gestureWinner = MultiFingerGesture.none;
        }
      }

      if (_dragStarted &&
          !InteractiveFlag.hasFlag(flags, InteractiveFlag.drag)) {
        _dragStarted = false;
        emitMapEventMoveEnd = true;
      }

      if (emitMapEventMoveEnd) {
        mapState.emitMapEvent(
          MapEventRotateEnd(
            center: mapState.center,
            zoom: mapState.zoom,
            source: MapEventSource.interactiveFlagsChanged,
          ),
        );
      }
    }
  }

  void _yieldMultiFingerGestureWinner(
      int gestureWinner, bool resetStartVariables) {
    _gestureWinner = gestureWinner;

    if (resetStartVariables) {
      // note: here we could reset to current values instead of last values
      _scaleCorrector = 1.0 - _lastScale;
    }
  }

  int _getMultiFingerGestureFlags(
      {int? gestureWinner, MapOptions? mapOptions}) {
    gestureWinner ??= _gestureWinner;
    mapOptions ??= options;

    if (mapOptions.enableMultiFingerGestureRace) {
      if (gestureWinner == MultiFingerGesture.pinchZoom) {
        return mapOptions.pinchZoomWinGestures;
      } else if (gestureWinner == MultiFingerGesture.rotate) {
        return mapOptions.rotationWinGestures;
      } else if (gestureWinner == MultiFingerGesture.pinchMove) {
        return mapOptions.pinchMoveWinGestures;
      }

      return MultiFingerGesture.none;
    } else {
      return MultiFingerGesture.all;
    }
  }

  void closeFlingAnimationController(MapEventSource source) {
    _flingAnimationStarted = false;
    if (_flingController.isAnimating) {
      _flingController.stop();

      _stopListeningForAnimationInterruptions();

      mapState.emitMapEvent(
        MapEventFlingAnimationEnd(
            center: mapState.center, zoom: mapState.zoom, source: source),
      );
    }
  }

  void closeDoubleTapController(MapEventSource source) {
    if (_doubleTapController.isAnimating) {
      _doubleTapController.stop();

      _stopListeningForAnimationInterruptions();

      mapState.emitMapEvent(
        MapEventDoubleTapZoomEnd(
            center: mapState.center, zoom: mapState.zoom, source: source),
      );
    }
  }

  void handleScaleStart(ScaleStartDetails details) {
    _dragMode = _pointerCounter == 1;

    final eventSource = _dragMode
        ? MapEventSource.dragStart
        : MapEventSource.multiFingerGestureStart;
    closeFlingAnimationController(eventSource);
    closeDoubleTapController(eventSource);

    _gestureWinner = MultiFingerGesture.none;

    _mapZoomStart = mapState.zoom;
    _mapCenterStart = mapState.center;
    _focalStartLocal = _lastFocalLocal = details.localFocalPoint;
    _focalStartLatLng = _offsetToCrs(_focalStartLocal);

    _dragStarted = false;
    _pinchZoomStarted = false;
    _pinchMoveStarted = false;
    _rotationStarted = false;

    _lastRotation = 0.0;
    _scaleCorrector = 0.0;
    _lastScale = 1.0;
  }

  void handleScaleUpdate(ScaleUpdateDetails details) {
    if (_tapUpCounter == 1) {
      _handleDoubleTapHold(details);
      return;
    }

    final eventSource =
        _dragMode ? MapEventSource.onDrag : MapEventSource.onMultiFinger;

    final flags = options.interactiveFlags;
    final focalOffset = details.localFocalPoint;

    final currentRotation = radianToDeg(details.rotation);

    if (_dragMode) {
      if (InteractiveFlag.hasFlag(flags, InteractiveFlag.drag)) {
        if (!_dragStarted) {
          // We could emit start event at [handleScaleStart], however it is
          // possible drag will be disabled during ongoing drag then
          // [didUpdateWidget] will emit MapEventMoveEnd and if drag is enabled
          // again then this will emit the start event again.
          _dragStarted = true;
          mapState.emitMapEvent(
            MapEventMoveStart(
              center: mapState.center,
              zoom: mapState.zoom,
              source: eventSource,
            ),
          );
        }

        final oldCenterPt = mapState.project(mapState.center, mapState.zoom);
        final localDistanceOffset =
            _rotateOffset(_lastFocalLocal - focalOffset);

        final newCenterPt = oldCenterPt + _offsetToPoint(localDistanceOffset);
        final newCenter = mapState.unproject(newCenterPt, mapState.zoom);

        mapState.move(
          newCenter,
          mapState.zoom,
          hasGesture: true,
          source: eventSource,
        );
      }
    } else {
      final hasIntPinchMove =
          InteractiveFlag.hasFlag(flags, InteractiveFlag.pinchMove);
      final hasIntPinchZoom =
          InteractiveFlag.hasFlag(flags, InteractiveFlag.pinchZoom);
      final hasIntRotate =
          InteractiveFlag.hasFlag(flags, InteractiveFlag.rotate);

      if (hasIntPinchMove || hasIntPinchZoom || hasIntRotate) {
        final hasGestureRace = options.enableMultiFingerGestureRace;

        if (hasGestureRace && _gestureWinner == MultiFingerGesture.none) {
          if (hasIntPinchZoom &&
              (_getZoomForScale(_mapZoomStart, details.scale) - _mapZoomStart)
                      .abs() >=
                  options.pinchZoomThreshold) {
            if (options.debugMultiFingerGestureWinner) {
              debugPrint('Multi Finger Gesture winner: Pinch Zoom');
            }
            _yieldMultiFingerGestureWinner(MultiFingerGesture.pinchZoom, true);
          } else if (hasIntRotate &&
              currentRotation.abs() >= options.rotationThreshold) {
            if (options.debugMultiFingerGestureWinner) {
              debugPrint('Multi Finger Gesture winner: Rotate');
            }
            _yieldMultiFingerGestureWinner(MultiFingerGesture.rotate, true);
          } else if (hasIntPinchMove &&
              (_focalStartLocal - focalOffset).distance >=
                  options.pinchMoveThreshold) {
            if (options.debugMultiFingerGestureWinner) {
              debugPrint('Multi Finger Gesture winner: Pinch Move');
            }
            _yieldMultiFingerGestureWinner(MultiFingerGesture.pinchMove, true);
          }
        }

        if (!hasGestureRace || _gestureWinner != MultiFingerGesture.none) {
          final gestures = _getMultiFingerGestureFlags();

          final hasGesturePinchMove = MultiFingerGesture.hasFlag(
              gestures, MultiFingerGesture.pinchMove);
          final hasGesturePinchZoom = MultiFingerGesture.hasFlag(
              gestures, MultiFingerGesture.pinchZoom);
          final hasGestureRotate =
              MultiFingerGesture.hasFlag(gestures, MultiFingerGesture.rotate);

          final hasMove = hasIntPinchMove && hasGesturePinchMove;
          final hasZoom = hasIntPinchZoom && hasGesturePinchZoom;
          final hasRotate = hasIntRotate && hasGestureRotate;

          var mapMoved = false;
          var mapRotated = false;
          if (hasMove || hasZoom) {
            double newZoom;
            if (hasZoom) {
              newZoom = _getZoomForScale(
                  _mapZoomStart, details.scale + _scaleCorrector);

              if (!_pinchZoomStarted) {
                if (newZoom != _mapZoomStart) {
                  _pinchZoomStarted = true;

                  if (!_pinchMoveStarted) {
                    // emit MoveStart event only if pinchMove hasn't started
                    mapState.emitMapEvent(
                      MapEventMoveStart(
                        center: mapState.center,
                        zoom: mapState.zoom,
                        source: eventSource,
                      ),
                    );
                  }
                }
              }
            } else {
              newZoom = mapState.zoom;
            }

            LatLng newCenter;
            if (hasMove) {
              if (!_pinchMoveStarted && _lastFocalLocal != focalOffset) {
                _pinchMoveStarted = true;

                if (!_pinchZoomStarted) {
                  // emit MoveStart event only if pinchZoom hasn't started
                  mapState.emitMapEvent(
                    MapEventMoveStart(
                      center: mapState.center,
                      zoom: mapState.zoom,
                      source: eventSource,
                    ),
                  );
                }
              }

              if (_pinchMoveStarted) {
                final oldCenterPt = mapState.project(mapState.center, newZoom);
                final newFocalLatLong = _offsetToCrs(_focalStartLocal, newZoom);
                final newFocalPt = mapState.project(newFocalLatLong, newZoom);
                final oldFocalPt = mapState.project(_focalStartLatLng, newZoom);
                final zoomDifference = oldFocalPt - newFocalPt;
                final moveDifference =
                    _rotateOffset(_focalStartLocal - _lastFocalLocal);

                final newCenterPt = oldCenterPt +
                    zoomDifference +
                    _offsetToPoint(moveDifference);
                newCenter = mapState.unproject(newCenterPt, newZoom);
              } else {
                newCenter = mapState.center;
              }
            } else {
              newCenter = mapState.center;
            }

            if (_pinchZoomStarted || _pinchMoveStarted) {
              mapMoved = mapState.move(
                newCenter,
                newZoom,
                hasGesture: true,
                callOnMoveSink: false,
                source: eventSource,
              );
            }
          }

          if (hasRotate) {
            if (!_rotationStarted && currentRotation != 0.0) {
              _rotationStarted = true;
              mapState.emitMapEvent(
                MapEventRotateStart(
                  center: mapState.center,
                  zoom: mapState.zoom,
                  source: eventSource,
                ),
              );
            }

            if (_rotationStarted) {
              final rotationDiff = currentRotation - _lastRotation;
              mapRotated = mapState.rotate(
                mapState.rotation + rotationDiff,
                hasGesture: true,
                callOnMoveSink: false,
                source: eventSource,
              );
            }
          }

          if (mapMoved || mapRotated) {
            mapState.rebuildLayers();
          }
        }
      }
    }

    _lastRotation = currentRotation;
    _lastScale = details.scale;
    _lastFocalLocal = focalOffset;
  }

  void handleScaleEnd(ScaleEndDetails details) {
    _resetDoubleTapHold();

    if (!options.allowPanning) {
      return;
    }

    final eventSource =
        _dragMode ? MapEventSource.dragEnd : MapEventSource.multiFingerEnd;

    if (_rotationStarted) {
      _rotationStarted = false;
      mapState.emitMapEvent(
        MapEventRotateEnd(
          center: mapState.center,
          zoom: mapState.zoom,
          source: eventSource,
        ),
      );
    }

    if (_dragStarted || _pinchZoomStarted || _pinchMoveStarted) {
      _dragStarted = _pinchZoomStarted = _pinchMoveStarted = false;
      mapState.emitMapEvent(
        MapEventMoveEnd(
          center: mapState.center,
          zoom: mapState.zoom,
          source: eventSource,
        ),
      );
    }

    final hasFling = InteractiveFlag.hasFlag(
        options.interactiveFlags, InteractiveFlag.flingAnimation);

    final magnitude = details.velocity.pixelsPerSecond.distance;
    if (magnitude < _kMinFlingVelocity || !hasFling) {
      if (hasFling) {
        mapState.emitMapEvent(
          MapEventFlingAnimationNotStarted(
            center: mapState.center,
            zoom: mapState.zoom,
            source: eventSource,
          ),
        );
      }

      return;
    }

    final direction = details.velocity.pixelsPerSecond / magnitude;
    final distance = (Offset.zero &
            Size(mapState.originalSize!.x as double,
                mapState.originalSize!.y as double))
        .shortestSide;

    final flingOffset = _focalStartLocal - _lastFocalLocal;
    _flingAnimation = Tween<Offset>(
      begin: flingOffset,
      end: flingOffset - direction * distance,
    ).animate(_flingController);

    _flingController
      ..value = 0.0
      ..fling(
          velocity: magnitude / 1000.0,
          springDescription: SpringDescription.withDampingRatio(
            mass: 1,
            stiffness: 1000,
            ratio: 5,
          ));
  }

  void handleTap(TapPosition position) {
    closeFlingAnimationController(MapEventSource.tap);
    closeDoubleTapController(MapEventSource.tap);

    final latlng = _offsetToCrs(position.relative!);
    if (options.onTap != null) {
      // emit the event
      options.onTap!(position, latlng);
    }

    mapState.emitMapEvent(
      MapEventTap(
        tapPosition: latlng,
        center: mapState.center,
        zoom: mapState.zoom,
        source: MapEventSource.tap,
      ),
    );
  }

  void handleLongPress(TapPosition position) {
    _resetDoubleTapHold();

    closeFlingAnimationController(MapEventSource.longPress);
    closeDoubleTapController(MapEventSource.longPress);

    final latlng = _offsetToCrs(position.relative!);
    if (options.onLongPress != null) {
      // emit the event
      options.onLongPress!(position, latlng);
    }

    mapState.emitMapEvent(
      MapEventLongPress(
        tapPosition: latlng,
        center: mapState.center,
        zoom: mapState.zoom,
        source: MapEventSource.longPress,
      ),
    );
  }

  LatLng _offsetToCrs(Offset offset, [double? zoom]) {
    final focalStartPt =
        mapState.project(mapState.center, zoom ?? mapState.zoom);
    final point = (_offsetToPoint(offset) - (mapState.originalSize! / 2.0))
        .rotate(mapState.rotationRad);

    final newCenterPt = focalStartPt + point;
    return mapState.unproject(newCenterPt, zoom ?? mapState.zoom);
  }

  void handleDoubleTap(TapPosition tapPosition) {
    _resetDoubleTapHold();
    if (!options.allowPanning) {
      return;
    }

    closeFlingAnimationController(MapEventSource.doubleTap);
    closeDoubleTapController(MapEventSource.doubleTap);

    if (InteractiveFlag.hasFlag(
        options.interactiveFlags, InteractiveFlag.doubleTapZoom)) {
      final centerZoom = _getNewEventCenterZoomPosition(
          _offsetToPoint(tapPosition.relative!),
          _getZoomForScale(mapState.zoom, 2));
      _startDoubleTapAnimation(
          centerZoom[1] as double, centerZoom[0] as LatLng);
    }
  }

  // If we double click in the corner of a map, calculate the new
  // center of the whole map after a zoom, to retain that offset position
  // so that the same event LatLng is still under the cursor.

  List<dynamic> _getNewEventCenterZoomPosition(
      CustomPoint cursorPos, double newZoom) {
    // Calculate offset of mouse cursor from viewport center
    final viewCenter = mapState.originalSize! / 2;
    final offset = (cursorPos - viewCenter).rotate(mapState.rotationRad);
    // Match new center coordinate to mouse cursor position
    final scale = mapState.getZoomScale(newZoom, mapState.zoom);
    final newOffset = offset * (1.0 - 1.0 / scale);
    final mapCenter = mapState.project(mapState.center);
    final newCenter = mapState.unproject(mapCenter + newOffset);
    return <dynamic>[newCenter, newZoom];
  }

  void _startDoubleTapAnimation(double newZoom, LatLng newCenter) {
    _doubleTapZoomAnimation = Tween<double>(begin: mapState.zoom, end: newZoom)
        .chain(CurveTween(curve: Curves.linear))
        .animate(_doubleTapController);
    _doubleTapCenterAnimation =
        LatLngTween(begin: mapState.center, end: newCenter)
            .chain(CurveTween(curve: Curves.linear))
            .animate(_doubleTapController);
    _doubleTapController.forward(from: 0);
  }

  void _doubleTapZoomStatusListener(AnimationStatus status) {
    if (status == AnimationStatus.forward) {
      mapState.emitMapEvent(
        MapEventDoubleTapZoomStart(
            center: mapState.center,
            zoom: mapState.zoom,
            source: MapEventSource.doubleTapZoomAnimationController),
      );
      _startListeningForAnimationInterruptions();
    } else if (status == AnimationStatus.completed) {
      _stopListeningForAnimationInterruptions();
      mapState.emitMapEvent(
        MapEventDoubleTapZoomEnd(
            center: mapState.center,
            zoom: mapState.zoom,
            source: MapEventSource.doubleTapZoomAnimationController),
      );
    }
  }

  void _handleDoubleTapZoomAnimation() {
    mapState.move(
      _doubleTapCenterAnimation.value,
      _doubleTapZoomAnimation.value,
      hasGesture: true,
      source: MapEventSource.doubleTapZoomAnimationController,
    );
  }

  void handleOnTapUp(TapUpDetails details) {
    _doubleTapHoldMaxDelay?.cancel();

    if (++_tapUpCounter == 1) {
      _doubleTapHoldMaxDelay =
          Timer(const Duration(milliseconds: 350), _resetDoubleTapHold);
    }
  }

  void _handleDoubleTapHold(ScaleUpdateDetails details) {
    _doubleTapHoldMaxDelay?.cancel();

    final flags = options.interactiveFlags;
    if (InteractiveFlag.hasFlag(flags, InteractiveFlag.pinchZoom)) {
      final zoom = mapState.zoom;
      final focalOffset = details.localFocalPoint;
      final verticalOffset = (_focalStartLocal - focalOffset).dy;
      final newZoom = _mapZoomStart - verticalOffset / 360 * zoom;
      final min = options.minZoom ?? 0.0;
      final max = options.maxZoom ?? double.infinity;
      final actualZoom = math.max(min, math.min(max, newZoom));

      mapState.move(
        mapState.center,
        actualZoom,
        hasGesture: true,
        source: MapEventSource.doubleTapHold,
      );
    }
  }

  void _resetDoubleTapHold() {
    _doubleTapHoldMaxDelay?.cancel();
    _tapUpCounter = 0;
  }

  void _flingAnimationStatusListener(AnimationStatus status) {
    if (status == AnimationStatus.completed) {
      _flingAnimationStarted = false;
      _stopListeningForAnimationInterruptions();
      mapState.emitMapEvent(
        MapEventFlingAnimationEnd(
            center: mapState.center,
            zoom: mapState.zoom,
            source: MapEventSource.flingAnimationController),
      );
    }
  }

  void _handleFlingAnimation() {
    if (!_flingAnimationStarted) {
      _flingAnimationStarted = true;
      mapState.emitMapEvent(
        MapEventFlingAnimationStart(
            center: mapState.center,
            zoom: mapState.zoom,
            source: MapEventSource.flingAnimationController),
      );
      _startListeningForAnimationInterruptions();
    }

    final newCenterPoint = mapState.project(_mapCenterStart) +
        _offsetToPoint(_flingAnimation.value).rotate(mapState.rotationRad);
    final newCenter = mapState.unproject(newCenterPoint);

    mapState.move(
      newCenter,
      mapState.zoom,
      hasGesture: true,
      source: MapEventSource.flingAnimationController,
    );
  }

  void _startListeningForAnimationInterruptions() {
    if (_mapControllerAnimationInterruption != null) return;
    // cancel map animation controllers on map controller move events
    _mapControllerAnimationInterruption = mapController.mapEventStream
        .where((event) =>
            event.source == MapEventSource.mapController &&
            event is MapEventMove)
        .listen(_handleAnimationInterruptions);
  }

  void _stopListeningForAnimationInterruptions() {
    _mapControllerAnimationInterruption?.cancel();
    _mapControllerAnimationInterruption = null;
  }

  void _handleAnimationInterruptions(MapEvent event) {
    closeDoubleTapController(event.source);
    closeFlingAnimationController(event.source);
  }

  CustomPoint _offsetToPoint(Offset offset) {
    return CustomPoint(offset.dx, offset.dy);
  }

  double _getZoomForScale(double startZoom, double scale) {
    final resultZoom =
        scale == 1.0 ? startZoom : startZoom + math.log(scale) / math.ln2;
    return mapState.fitZoomToBounds(resultZoom);
  }

  Offset _rotateOffset(Offset offset) {
    final radians = mapState.rotationRad;
    if (radians != 0.0) {
      final cos = math.cos(radians);
      final sin = math.sin(radians);
      final nx = (cos * offset.dx) + (sin * offset.dy);
      final ny = (cos * offset.dy) - (sin * offset.dx);

      return Offset(nx, ny);
    }

    return offset;
  }

  @override
  void dispose() {
    _flingController.dispose();
    _doubleTapController.dispose();
    super.dispose();
  }
}
