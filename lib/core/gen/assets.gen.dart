/// GENERATED CODE - DO NOT MODIFY BY HAND
/// *****************************************************
///  FlutterGen
/// *****************************************************

// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: directives_ordering,unnecessary_import

import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter/services.dart';

class $AssetsFontsGen {
  const $AssetsFontsGen();

  /// File path: assets/fonts/anjoman_bold.ttf
  String get anjomanBold => 'assets/fonts/anjoman_bold.ttf';

  /// File path: assets/fonts/anjoman_regular.ttf
  String get anjomanRegular => 'assets/fonts/anjoman_regular.ttf';

  /// File path: assets/fonts/ubuntu_mono_regular.ttf
  String get ubuntuMonoRegular => 'assets/fonts/ubuntu_mono_regular.ttf';
}

class $AssetsImagesGen {
  const $AssetsImagesGen();

  /// File path: assets/images/ic_bot.png
  AssetGenImage get icBot => const AssetGenImage('assets/images/ic_bot.png');

  /// File path: assets/images/ic_deposit_ether.png
  AssetGenImage get icDepositEther =>
      const AssetGenImage('assets/images/ic_deposit_ether.png');

  /// File path: assets/images/ic_five.png
  AssetGenImage get icFive => const AssetGenImage('assets/images/ic_five.png');

  /// File path: assets/images/ic_metamask.png
  AssetGenImage get icMetamask =>
      const AssetGenImage('assets/images/ic_metamask.png');

  /// File path: assets/images/ic_multi_player.png
  AssetGenImage get icMultiPlayer =>
      const AssetGenImage('assets/images/ic_multi_player.png');

  /// File path: assets/images/ic_player.png
  AssetGenImage get icPlayer =>
      const AssetGenImage('assets/images/ic_player.png');

  /// File path: assets/images/ic_popup_menu.svg
  SvgGenImage get icPopupMenu =>
      const SvgGenImage('assets/images/ic_popup_menu.svg');

  /// File path: assets/images/ic_rock_paper.jpg
  AssetGenImage get icRockPaper =>
      const AssetGenImage('assets/images/ic_rock_paper.jpg');

  /// File path: assets/images/ic_splash_background.png
  AssetGenImage get icSplashBackground =>
      const AssetGenImage('assets/images/ic_splash_background.png');

  /// File path: assets/images/ic_splash_logo.png
  AssetGenImage get icSplashLogo =>
      const AssetGenImage('assets/images/ic_splash_logo.png');

  /// File path: assets/images/ic_start_rock_paper.png
  AssetGenImage get icStartRockPaper =>
      const AssetGenImage('assets/images/ic_start_rock_paper.png');

  /// File path: assets/images/ic_three.png
  AssetGenImage get icThree =>
      const AssetGenImage('assets/images/ic_three.png');

  /// File path: assets/images/ic_walletconnect.png
  AssetGenImage get icWalletconnect =>
      const AssetGenImage('assets/images/ic_walletconnect.png');

  /// File path: assets/images/main.png
  AssetGenImage get main => const AssetGenImage('assets/images/main.png');

  /// File path: assets/images/paper.png
  AssetGenImage get paper => const AssetGenImage('assets/images/paper.png');

  /// File path: assets/images/rock.png
  AssetGenImage get rock => const AssetGenImage('assets/images/rock.png');

  /// File path: assets/images/rock_paper_banner.jpg
  AssetGenImage get rockPaperBanner =>
      const AssetGenImage('assets/images/rock_paper_banner.jpg');

  /// File path: assets/images/scissors.png
  AssetGenImage get scissors =>
      const AssetGenImage('assets/images/scissors.png');
}

class $AssetsLanguagesGen {
  const $AssetsLanguagesGen();

  /// File path: assets/languages/en.json
  String get en => 'assets/languages/en.json';

  /// File path: assets/languages/fa.json
  String get fa => 'assets/languages/fa.json';
}

class Assets {
  Assets._();

  static const $AssetsFontsGen fonts = $AssetsFontsGen();
  static const $AssetsImagesGen images = $AssetsImagesGen();
  static const $AssetsLanguagesGen languages = $AssetsLanguagesGen();
}

class AssetGenImage {
  const AssetGenImage(this._assetName);

  final String _assetName;

  Image image({
    Key? key,
    AssetBundle? bundle,
    ImageFrameBuilder? frameBuilder,
    ImageErrorWidgetBuilder? errorBuilder,
    String? semanticLabel,
    bool excludeFromSemantics = false,
    double? scale,
    double? width,
    double? height,
    Color? color,
    Animation<double>? opacity,
    BlendMode? colorBlendMode,
    BoxFit? fit,
    AlignmentGeometry alignment = Alignment.center,
    ImageRepeat repeat = ImageRepeat.noRepeat,
    Rect? centerSlice,
    bool matchTextDirection = false,
    bool gaplessPlayback = false,
    bool isAntiAlias = false,
    String? package,
    FilterQuality filterQuality = FilterQuality.low,
    int? cacheWidth,
    int? cacheHeight,
  }) {
    return Image.asset(
      _assetName,
      key: key,
      bundle: bundle,
      frameBuilder: frameBuilder,
      errorBuilder: errorBuilder,
      semanticLabel: semanticLabel,
      excludeFromSemantics: excludeFromSemantics,
      scale: scale,
      width: width,
      height: height,
      color: color,
      opacity: opacity,
      colorBlendMode: colorBlendMode,
      fit: fit,
      alignment: alignment,
      repeat: repeat,
      centerSlice: centerSlice,
      matchTextDirection: matchTextDirection,
      gaplessPlayback: gaplessPlayback,
      isAntiAlias: isAntiAlias,
      package: package,
      filterQuality: filterQuality,
      cacheWidth: cacheWidth,
      cacheHeight: cacheHeight,
    );
  }

  String get path => _assetName;

  String get keyName => _assetName;
}

class SvgGenImage {
  const SvgGenImage(this._assetName);

  final String _assetName;

  SvgPicture svg({
    Key? key,
    bool matchTextDirection = false,
    AssetBundle? bundle,
    String? package,
    double? width,
    double? height,
    BoxFit fit = BoxFit.contain,
    AlignmentGeometry alignment = Alignment.center,
    bool allowDrawingOutsideViewBox = false,
    WidgetBuilder? placeholderBuilder,
    Color? color,
    BlendMode colorBlendMode = BlendMode.srcIn,
    String? semanticsLabel,
    bool excludeFromSemantics = false,
    Clip clipBehavior = Clip.hardEdge,
    bool cacheColorFilter = false,
    SvgTheme? theme,
  }) {
    return SvgPicture.asset(
      _assetName,
      key: key,
      matchTextDirection: matchTextDirection,
      bundle: bundle,
      package: package,
      width: width,
      height: height,
      fit: fit,
      alignment: alignment,
      allowDrawingOutsideViewBox: allowDrawingOutsideViewBox,
      placeholderBuilder: placeholderBuilder,
      color: color,
      colorBlendMode: colorBlendMode,
      semanticsLabel: semanticsLabel,
      excludeFromSemantics: excludeFromSemantics,
      clipBehavior: clipBehavior,
      cacheColorFilter: cacheColorFilter,
      theme: theme,
    );
  }

  String get path => _assetName;
}
