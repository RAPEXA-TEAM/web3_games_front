import 'package:custom_pop_up_menu/custom_pop_up_menu.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../core/gen/assets.gen.dart';

class CustomPopupMenuButton extends StatefulWidget {
  Widget content;
  Widget? icon;
  double? width;
  double? height;
  bool? removeShadow;
  List<PopupMenuItemModel> actions;

  CustomPopupMenuButton(
      {required this.actions,
      this.icon,
      this.width,
      this.height,
      required this.content,
      Key? key})
      : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _CustomPopupMenuButtonState();
  }
}

class _CustomPopupMenuButtonState extends State<CustomPopupMenuButton>
    with SingleTickerProviderStateMixin {
  CustomPopupMenuController controller = CustomPopupMenuController();

  @override
  Widget build(BuildContext context) {
    return widget.removeShadow != null && widget.removeShadow == true ? buildBody() : Container(
        height: widget.height ?? 40,
        width: widget.width,
        decoration: BoxDecoration(
          color: Theme.of(context).canvasColor,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.3),
              blurRadius: 3,
              offset: const Offset(0, 1),
            ),
          ],
          borderRadius: BorderRadius.circular(99),
          border: Border.all(color: Colors.black12),
        ),
        child: buildBody(),
    );
  }
  Widget buildBody(){
    return FittedBox(
      child: CustomPopupMenu(
        menuOnChange: (show) {
          setState(() {});
        },
        controller: controller,
        child: FittedBox(
          fit: BoxFit.scaleDown,
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: Row(
              children: [
                RotatedBox(
                  quarterTurns: controller.menuIsShowing ? 90 : 0,
                  child: SvgPicture.asset(
                    Assets.images.icPopupMenu.path,
                    height: 20,
                    width: 20,
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                Center(
                  child: widget.content,
                ),
                if (widget.icon != null) Padding(padding: EdgeInsets.only(right: 5, left: 5) ,child: widget.icon!)
              ],
            ),
          ),
        ),
        menuBuilder: () => Directionality(
          textDirection: TextDirection.rtl,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(5),
            child: Container(
              decoration: BoxDecoration(
                color: Theme.of(context).canvasColor,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.7),
                    blurRadius: 6,
                    offset: const Offset(0, 1),
                  ),
                ],
                borderRadius: BorderRadius.circular(5),
                border: Border.all(color: Colors.black12),
              ),
              child: Padding(
                padding: EdgeInsets.all(10),
                child: Column(
                  children: widget.actions
                      .map(
                        (item) => InkWell(
                      onTap: () {
                        item.onTap?.call();
                        controller.hideMenu();
                      },
                      child: SizedBox(
                        width: 150,
                        child: Padding(
                          padding: EdgeInsets.all(8),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Container(
                                margin: EdgeInsets.only(top: 2),
                                child: Text(
                                  item.title,
                                  style: TextStyle(
                                      color: Theme.of(context)
                                          .textTheme
                                          .bodyText1
                                          ?.color,
                                      fontSize: 12),
                                ),
                              ),
                              if (item.icon != null)
                                Icon(
                                  item.icon,
                                  size: 20,
                                  color: Theme.of(context).iconTheme.color,
                                ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ).toList(),
                ),
              ),
            ),
          ),
        ),
        pressType: PressType.singleClick,
        barrierColor: Colors.transparent,
      ),
    );
  }
}

class PopupMenuItemModel {
  String title;
  IconData? icon;
  Function()? onTap;

  PopupMenuItemModel({required this.title, this.icon, this.onTap});
}
