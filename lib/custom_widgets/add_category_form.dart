import 'package:flex_color_picker/flex_color_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_iconpicker/flutter_iconpicker.dart';
import 'package:provider/provider.dart';
import 'package:task_management_app/model/task_category_model.dart';
import 'package:task_management_app/provider/task_provider.dart';

import '../theme/colors.dart';

class AddCategoryForm extends StatefulWidget {
  const AddCategoryForm({Key? key}) : super(key: key);

  @override
  State<AddCategoryForm> createState() => _AddCategoryFormState();
}

class _AddCategoryFormState extends State<AddCategoryForm> {
  Color _dialogPickerColor = Colors.blue;
  Icon? _icon = const Icon(Icons.work);
  late TextEditingController txtCategoryCtrl;
  late TaskProvider taskProvider;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    txtCategoryCtrl = TextEditingController();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    txtCategoryCtrl.dispose();
    super.dispose();
  }

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    taskProvider = Provider.of<TaskProvider>(context, listen: false);
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 8.0),
        child: Column(
          children: [
            const Text(
              'Add New Category',
              style: TextStyle(
                fontSize: 22,
                color: Colors.black,
              ),
            ),
            const SizedBox(
              height: 8,
            ),
            TextField(
              controller: txtCategoryCtrl,
              decoration: const InputDecoration(
                filled: true,
                contentPadding: EdgeInsets.zero,
                label: Text(
                  'Category',
                ),
              ),
            ),
            const SizedBox(
              height: 8,
            ),
            ListTile(
              title: const Text('Select Color'),
              contentPadding: EdgeInsets.zero,
              trailing: ColorIndicator(
                  width: 44,
                  height: 44,
                  borderRadius: 4,
                  color: _dialogPickerColor,
                  onSelectFocus: false,
                  onSelect: () async {
                    // Store current color before we open the dialog.
                    final Color colorBeforeDialog = _dialogPickerColor;
                    // Wait for the picker to close, if dialog was dismissed,
                    // then restore the color we had before it was opened.
                    if (!(await colorPickerDialog())) {
                      setState(() {
                        _dialogPickerColor = colorBeforeDialog;
                      });
                    }
                  }),
            ),
            ListTile(
              contentPadding: EdgeInsets.zero,
              title: const Text('Choose Icon'),
              trailing: Container(
                padding: EdgeInsets.zero,
                height: 44,
                width: 44,
                decoration: BoxDecoration(
                    borderRadius: const BorderRadius.all(Radius.circular(4)),
                    color: _dialogPickerColor.withOpacity(0.2)),
                child: IconButton(
                  onPressed: _pickIcon,
                  padding: EdgeInsets.zero,
                  icon: _icon!,
                  color: Colors.black54,
                  iconSize: 44,
                ),
              ),
            ),
            const Spacer(),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.all(14),
                  backgroundColor: Colors.black,
                ),
                onPressed: () async {
                  final tcModel = TaskCategoryModel(
                    categoryTitle: txtCategoryCtrl.text,
                    color: _dialogPickerColor.value,
                    iconCodePoint: _icon!.icon!.codePoint,
                    iconFontFamily: _icon!.icon!.fontFamily,
                    iconFontPackage: _icon!.icon!.fontPackage,
                    hasTextDirectionMatched: _icon!.icon!.matchTextDirection,
                  );
                  await taskProvider.insertTaskCategory(tcModel);
                  if (mounted) Navigator.pop(context);

                  taskProvider.getAllTaskCategoryList();
                },
                child: const Text(
                  'ADD',
                  style: TextStyle(
                    fontSize: 20,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<bool> colorPickerDialog() async {
    return ColorPicker(
      // Use the dialogPickerColor as start color.
      color: _dialogPickerColor,
      enableShadesSelection: false,
      // Update the dialogPickerColor using the callback.
      onColorChanged: (Color color) =>
          setState(() => _dialogPickerColor = color),
      width: 40,
      height: 40,
      borderRadius: 4,
      spacing: 5,
      runSpacing: 5,
      wheelDiameter: 155,
      heading: Text(
        'Select color',
        style: Theme.of(context).textTheme.titleSmall,
      ),
      subheading: Text(
        'Select color shade',
        style: Theme.of(context).textTheme.titleSmall,
      ),
      wheelSubheading: Text(
        'Selected color and its shades',
        style: Theme.of(context).textTheme.titleSmall,
      ),
      showMaterialName: false,
      showColorName: false,
      showColorCode: false,
      copyPasteBehavior: const ColorPickerCopyPasteBehavior(
        longPressMenu: false,
      ),
      materialNameTextStyle: Theme.of(context).textTheme.bodySmall,
      colorNameTextStyle: Theme.of(context).textTheme.bodySmall,
      colorCodeTextStyle: Theme.of(context).textTheme.bodySmall,
      pickersEnabled: const <ColorPickerType, bool>{
        ColorPickerType.both: true,
        ColorPickerType.primary: false,
        ColorPickerType.accent: false,
        ColorPickerType.bw: false,
        ColorPickerType.custom: false,
        ColorPickerType.wheel: false,
      },
      customColorSwatchesAndNames: colorsNameMap,
    ).showPickerDialog(
      context,
      // New in version 3.0.0 custom transitions support.
      transitionBuilder: (BuildContext context, Animation<double> a1,
          Animation<double> a2, Widget widget) {
        final double curvedValue =
            Curves.easeInOutBack.transform(a1.value) - 1.0;
        return Transform(
          transform: Matrix4.translationValues(0.0, curvedValue * 200, 0.0),
          child: Opacity(
            opacity: a1.value,
            child: widget,
          ),
        );
      },
      transitionDuration: const Duration(milliseconds: 400),
      constraints:
          const BoxConstraints(minHeight: 460, minWidth: 300, maxWidth: 320),
    );
  }

  _pickIcon() async {
    IconData? icon = await FlutterIconPicker.showIconPicker(
      context,
      iconPackModes: [IconPack.cupertino, IconPack.material],
    );

    _icon = Icon(icon);
    setState(() {});

    debugPrint('Picked Icon:  $icon');
  }
}
