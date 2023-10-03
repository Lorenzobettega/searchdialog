import 'package:flutter/material.dart';
import 'package:simple_search_dropdown/simple_search_dropdown.dart';

class MultipleSearchDropDown extends StatefulWidget {
  const MultipleSearchDropDown({
    super.key,
    required this.listItems,
    required this.addMode,
    this.action,
    this.animationDuration,
    this.backgroundColor,
    this.border,
    this.createHint,
    this.createHintStyle,
    required this.deleteMode,
    this.dialogActionIcon,
    this.dialogActionWidget,
    this.dialogBackgroundColor,
    this.dialogHeight = 300,
    this.dialogListviewWidgetBuilder,
    this.dialogSearchBarBorder,
    this.dialogSearchBarColor,
    this.dialogSearchBarElevation = 2,
    this.dropdownDisableActionIcon,
    this.dropdownEnableActionIcon,
    this.elevation = 1,
    this.hint,
    this.hintSearchBar,
    this.hintStyle,
    this.insideIconSize = 18,
    this.miniBoxIconColor,
    required this.onAddItem,
    this.onDeleteItem,
    this.padding,
    this.confirmDelete = false,
    this.confirmDeleteFunction,
    this.selectedDialogColor,
    this.selectedDialogBoxColor,
    this.selectedInsideBoxTextStyle,
    required this.selectedItems,
    this.selectedItemsBoxTextStyle,
    this.seletedItemsBoxColor,
    this.selectedItemHoverColor,
    this.separatorHeight,
    this.sortSelecteds = true,
    this.unselectedInsideBoxTextStyle,
    this.unselectedItemHoverColor,
    required this.updateSelectedItems,
    this.widgetBuilder,
    this.dropdownwidth = 300,
    this.dropdownHeight = 50,
    this.outsideIconColor,
    this.outsideIconSize = 20,
  }) : assert(confirmDelete && confirmDeleteFunction != null || !confirmDelete,
            'confirmDelete can only be true if confirmDeleteFunction != null ');

  final Widget? action;
  final bool addMode;
  final Duration? animationDuration;
  final Color? backgroundColor;
  final String? createHint;
  final TextStyle? createHintStyle;
  final OutlinedBorder? border;
  final bool deleteMode;
  final Icon? dialogActionIcon;
  final Widget? dialogActionWidget;
  final Color? dialogBackgroundColor;
  final double dialogHeight;
  final Widget? dialogListviewWidgetBuilder;
  final OutlinedBorder? dialogSearchBarBorder;
  final Color? dialogSearchBarColor;
  final double dialogSearchBarElevation;
  final IconData? dropdownDisableActionIcon;
  final IconData? dropdownEnableActionIcon;
  final double elevation;
  final String? hint;
  final String? hintSearchBar;
  final TextStyle? hintStyle;
  final double insideIconSize;
  final Color? miniBoxIconColor;
  final Function(ValueItem) onAddItem;
  final Function(ValueItem)? onDeleteItem;
  final EdgeInsets? padding;
  final bool confirmDelete;
  final Future<bool> Function()? confirmDeleteFunction;
  final Color? selectedDialogBoxColor;
  final Color? selectedDialogColor;
  final TextStyle? selectedInsideBoxTextStyle;
  final List<ValueItem> selectedItems;
  final TextStyle? selectedItemsBoxTextStyle;
  final Color? seletedItemsBoxColor;
  final Color? selectedItemHoverColor;
  final double? separatorHeight;
  final bool sortSelecteds;
  final TextStyle? unselectedInsideBoxTextStyle;
  final Color? unselectedItemHoverColor;
  final Function(List<ValueItem>) updateSelectedItems;
  final List<ValueItem> listItems;
  final Widget? widgetBuilder;
  final double dropdownHeight;
  final double dropdownwidth;
  final double outsideIconSize;
  final Color? outsideIconColor;

  @override
  State<MultipleSearchDropDown> createState() => MultipleSearchDropDownState();
}

class MultipleSearchDropDownState extends State<MultipleSearchDropDown> {
  late double altura = 0;
  late bool aberto = false;
  OverlayEntry? overlayEntry;
  final GlobalKey overlayKey = GlobalKey();

  void onItemSelected(ValueItem val) {
    setState(() {
      if (widget.selectedItems.contains(val)) {
        widget.selectedItems.remove(val);
      } else {
        widget.selectedItems.add(val);
      }
      widget.updateSelectedItems(widget.selectedItems);
    });
  }

  void clearSelection() {
    setState(() {
      widget.selectedItems.clear();
    });
  }

  void handleAddItem(ValueItem item, BuildContext context) {
    if (widget.addMode) {
      widget.onAddItem(item);
      onItemSelected(item);
      setState(() {});
    }
  }

  void handleDeleteItem(ValueItem item,BuildContext context) async {
    if (widget.deleteMode) {
      if (widget.confirmDelete) {
        hideOverlay();
        final result = await widget.confirmDeleteFunction!();
        if (result) {
          widget.onDeleteItem!(item);
        }
        // ignore: use_build_context_synchronously
        _showOverlay(context);
      } else {
        setState(() {
          widget.onDeleteItem!(item);
          hideOverlay();
          _showOverlay(context);
        });
      }
    }
  }

  void _showOverlay(
    BuildContext context,
  ) {
    final RenderBox overlay =
        Overlay.of(context).context.findRenderObject() as RenderBox;
    final RenderBox widgetPosition =
        overlayKey.currentContext!.findRenderObject() as RenderBox;
    final Offset offset =
        widgetPosition.localToGlobal(Offset.zero, ancestor: overlay);

    overlayEntry = OverlayEntry(
      builder: (context) => Stack(
        children: [
          Positioned.fill(
            child: GestureDetector(
              onTap: hideOverlay,
              child: Container(
                color: Colors.transparent,
              ),
            ),
          ),
          Positioned(
            top: offset.dy + widgetPosition.size.height,
            left: offset.dx - 4,
            child: Material(
              color: Colors.transparent,
              child: ContentMultiple(
                addMode: widget.addMode,
                animationDuration: widget.animationDuration,
                backgroundColor: widget.backgroundColor,
                border: widget.border,
                createHint: widget.createHint,
                createHintStyle: widget.createHintStyle,
                deleteMode: widget.deleteMode,
                dialogActionIcon: widget.dialogActionIcon,
                dialogActionWidget: widget.dialogActionWidget,
                dialogBackgroundColor: widget.dialogBackgroundColor,
                dialogHeight: widget.dialogHeight,
                dialogListviewWidgetBuilder: widget.dialogListviewWidgetBuilder,
                dialogSearchBarBorder: widget.dialogSearchBarBorder,
                dialogSearchBarColor: widget.dialogSearchBarColor,
                dialogSearchBarElevation: widget.dialogSearchBarElevation,
                elevation: widget.elevation,
                hintSearchBar: widget.hintSearchBar,
                hintStyle: widget.hintStyle,
                listItens: widget.listItems,
                onAddItem: (val) => handleAddItem(val, context),
                onDeleteItem: (val) => handleDeleteItem(val, context),
                onItemSelected: (val) => onItemSelected(val),
                padding: widget.padding,
                selectedDialogBoxColor: widget.selectedDialogBoxColor,
                selectedInsideBoxTextStyle: widget.selectedInsideBoxTextStyle,
                selectedItemHoverColor: widget.selectedItemHoverColor,
                selectedItens: widget.selectedItems,
                separatorHeight: widget.separatorHeight,
                sortSelecteds: widget.sortSelecteds,
                unselectedInsideBoxTextStyle:
                    widget.unselectedInsideBoxTextStyle,
                unselectedItemHoverColor: widget.unselectedItemHoverColor,
                width: widget.dropdownwidth,
                minHeight: widget.dropdownHeight,
              ),
            ),
          ),
        ],
      ),
    );

    Overlay.of(context).insert(overlayEntry!);
    setState(() {
      aberto = !aberto;
    });
  }

  void hideOverlay() {
    overlayEntry?.remove();
    overlayEntry = null;
    setState(() {
      aberto = !aberto;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: widget.dropdownHeight,
      width: widget.dropdownwidth,
      child: InkWell(
        key: overlayKey,
        onTap: () {
          if (overlayEntry == null) {
            _showOverlay(context);
          } else {
            hideOverlay();
          }
        },
        child: Stack(
          children: [
            Container(
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.all(Radius.circular(10)),
                color: widget.backgroundColor ?? Colors.white,
                border: Border.all(style: BorderStyle.none),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey
                        .withOpacity(widget.elevation != 0 ? 0.5 : 0),
                    spreadRadius: 0.5,
                    blurRadius: widget.elevation,
                    offset: Offset(0, 0.5 * widget.elevation),
                  ),
                ],
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Row(
                  children: [
                    Expanded(
                      child: widget.selectedItems.isNotEmpty
                          ? ScrollConfiguration(
                              behavior: MyCustomScrollBehavior(),
                              child: ListView.separated(
                                scrollDirection: Axis.horizontal,
                                separatorBuilder: (context, index) =>
                                    const SizedBox(width: 5),
                                itemCount: widget.selectedItems.length,
                                itemBuilder: (context, index) {
                                  return Padding(
                                    padding:
                                        const EdgeInsets.symmetric(vertical: 5),
                                    child: Card(
                                      color: widget.seletedItemsBoxColor ??
                                          Colors.grey.shade300,
                                      elevation: widget.elevation,
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 8),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            Text(
                                                widget
                                                    .selectedItems[index].label,
                                                style: widget
                                                    .selectedInsideBoxTextStyle),
                                            InkWell(
                                              onTap: () => onItemSelected(
                                                  widget.selectedItems[index]),
                                              child: Icon(
                                                Icons.close,
                                                size: widget.insideIconSize,
                                                color: widget.miniBoxIconColor,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  );
                                },
                              ),
                            )
                          : Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  widget.hint ?? 'Selecione',
                                  textAlign: TextAlign.start,
                                  style: widget.hintStyle,
                                ),
                              ],
                            ),
                    ),
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const SizedBox(width: 5),
                        widget.action ??
                            InkWell(
                              onTap: () {
                                setState(() {
                                  widget.selectedItems.clear();
                                  widget.updateSelectedItems(
                                      widget.selectedItems);
                                });
                              },
                              child: Icon(
                                widget.selectedItems.isNotEmpty
                                    ? Icons.clear
                                    : aberto
                                        ? widget.dropdownEnableActionIcon ??
                                            Icons.arrow_drop_up
                                        : widget.dropdownDisableActionIcon ??
                                            Icons.arrow_drop_down,
                                size: widget.outsideIconSize,
                                color: widget.outsideIconColor,
                              ),
                            ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
