import 'package:flutter/material.dart';
import 'package:mo8tarib/constants/color_constants.dart';
import 'package:mo8tarib/constants/global.dart';
import 'package:multi_select_flutter/bottom_sheet/multi_select_bottom_sheet_field.dart';
import 'package:multi_select_flutter/chip_display/multi_select_chip_display.dart';
import 'package:multi_select_flutter/util/multi_select_list_type.dart';

class MultiSelect extends StatelessWidget {
  final List items;
  final String name;
  final Function onConfirm;
  final Function onTap;
  final List selectItems;

  const MultiSelect(
      {Key key,
      this.items,
      this.name,
      this.onConfirm,
      this.onTap,
      this.selectItems})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        MultiSelectBottomSheetField(
          initialChildSize: 0.4,
          listType: MultiSelectListType.CHIP,
          searchable: true,
          buttonText: Text(name),
          title: Text(name),
          items: items,
          selectedColor: ColorConstants.primaryColor,
          selectedItemsTextStyle: TextStyle(color: Colors.white),
          onConfirm: onConfirm
//              (values) {
//            _selectedAnimals2 = values;
//          }
          ,
          chipDisplay: MultiSelectChipDisplay(
              chipColor: ColorConstants.primaryColor,
              textStyle: TextStyle(color: Colors.white),
              onTap: onTap
//                (value) {
//              setState(() {
//                _selectedAnimals2.remove(value);
//              });
//            },
              ),
        ),
        selectItems == null || selectItems.isEmpty
            ? Container(
                padding: EdgeInsets.all(10),
                alignment: Alignment.centerLeft,
                child: Text(
                  "None selected",
                  style: TextStyle(color: Colors.black54),
                ))
            : Container(),
      ],
    );
  }
}
