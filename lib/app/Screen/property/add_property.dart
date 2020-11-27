import 'package:flutter/material.dart';
import 'package:mo8tarib/app/Screen/property/add_propert_model.dart';
import 'package:mo8tarib/app/Screen/property/add_property_bloc.dart';
import 'package:mo8tarib/app/Screen/property/date_picker.dart';
import 'package:mo8tarib/app/Screen/property/multi_select.dart';
import 'package:mo8tarib/app/common_widgets/allHomeComponent/imageFlatWidget.dart';
import 'package:mo8tarib/app/common_widgets/custom_drob_down.dart';
import 'package:mo8tarib/app/common_widgets/resuable_edit_user.dart';
import 'package:mo8tarib/global.dart';
import 'package:provider/provider.dart';

class AddProperty extends StatefulWidget {
  AddProperty({@required this.bloc});
  final AddPropertyBloc bloc;

  static Widget create() {
    return Provider<AddPropertyBloc>(
      create: (_) => AddPropertyBloc(),
      child: Consumer<AddPropertyBloc>(
          builder: (context, bloc, _) => AddProperty(bloc: bloc)),
      dispose: (context, bloc) => bloc.dispose(),
    );
  }

  @override
  _AddPropertyState createState() => _AddPropertyState();
}

class _AddPropertyState extends State<AddProperty> {
  TextEditingController descriptionController;
  TextEditingController sizeController;
  TextEditingController addressController;

  @override
  void initState() {
    descriptionController = TextEditingController();
    sizeController = TextEditingController();
    addressController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    descriptionController.dispose();
    sizeController.dispose();
    addressController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<AddPropertyModel>(
        stream: widget.bloc.modelStream,
        initialData: AddPropertyModel(),
        builder: (context, snapshot) {
          final AddPropertyModel model = snapshot.data;

          return Stack(
            children: [
              _buildChildren(model),
              Align(
                alignment: Alignment.bottomCenter,
                child: Row(
                  children: [
                    Expanded(
                        child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: _addButton(model),
                    )),
                  ],
                ),
              ),
            ],
          );
        });
  }

  Widget _buildChildren(AddPropertyModel model) {
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            CustomDropDown(
              nameText: "Type",
              value: model.typeValue,
              getValue: widget.bloc.updateTypeValue,
              arrItems: ['Any', 'House', 'room'],
            ),
            SizedBox(height: 10),
            CustomDropDown(
                nameText: "Category",
                value: model.categoryValue,
                getValue: widget.bloc.updateCategoryValue,
                arrItems: [
                  'Any',
                  'General',
                  'Go and Back',
                  'Student',
                  'Summer'
                ]),
            SizedBox(height: 10),
            CustomDropDown(
              nameText: "Gender",
              value: model.genderValue,
              getValue: widget.bloc.updateGenderValue,
              arrItems: ['Any', 'Men', 'Women'],
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text("Price daily",
                            style: TextStyle(
                                fontSize: 24, fontFamily: 'VarelaRound')),
                        Text(model.price.toString() + " \$ ",
                            style: TextStyle(
                                fontSize: 20, fontFamily: 'VarelaRound')),
                      ],
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Slider(
                      activeColor: foregroundColor,
                      inactiveColor: Colors.black.withOpacity(0.3),
                      value: model.price.toDouble(),
                      min: 0,
                      max: 5000,
                      onChanged: widget.bloc.updatePrice,
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 10),
            ReusableEditUser(
                controller: descriptionController,
                hint: 'description',
                textFieldName: "description",
                getText: widget.bloc.updateDescription),
            SizedBox(height: 10),
            ReusableEditUser(
                controller: sizeController,
                hint: 'size',
                textFieldName: "size",
                getText: widget.bloc.updateSize),
            Row(
              children: <Widget>[
                Expanded(
                  child: ReusableEditUser(
                    controller: addressController,
                    hint: 'Address',
                    textFieldName: 'Address',
                    getText: widget.bloc.updateAddress,
                  ),
                ),
                IconButton(
                    icon: Icon(
                      Icons.location_on,
                      color: foregroundColor,
                    ),
                    onPressed: () async {
                      await widget.bloc.getCurrentLocation();
                      addressController.text = model.address;
                    })
              ],
            ),
            SizedBox(height: 10),
            MultiSelect(
              name: 'Services',
              items: widget.bloc.items,
              selectItems: model.services,
              onConfirm: widget.bloc.updateSelectedList,
              onTap: widget.bloc.removeFromSelectedList,
            ),
            SizedBox(height: 10),
            DatePicker(
              bloc: widget.bloc,
              model: model,
            ),
            Theme(
              data: ThemeData(
                splashColor: Colors.transparent,
                highlightColor: Colors.transparent,
              ),
              child: FlatButton(
                onPressed: () {
                  widget.bloc.openFileExplorer();
                },
                child: Text(
                  'Add Picters',
                  // localization.translate("Change profile photo"),
                  style: TextStyle(color: foregroundColor),
                ),
                color: Colors.white,
              ),
            ),
            SizedBox(height: 10),
            model.imagesUrl != null
                ? Container(
                    child: SizedBox(
                      height: 150,
                      child: ListView.builder(
                        shrinkWrap: true,
                        scrollDirection: Axis.horizontal,
                        physics: ClampingScrollPhysics(),
                        itemCount: model.imagesUrl.length,
                        itemBuilder: (context, index) => imageFlatWidget(
                          image: NetworkImage(model.imagesUrl[index]),
                        ),
                      ),
                    ),
                  )
                : SizedBox(height: 25, child: Container()),
          ],
        ),
      ),
    );
  }

  Widget _addButton(AddPropertyModel model) {
    return RaisedButton(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      color: foregroundColor,
      elevation: 10,
      child: !model.isLoading
          ? Text(
              'add',
              style: TextStyle(fontFamily: 'VarelaRound', color: Colors.white),
            )
          : CircularProgressIndicator(
              backgroundColor: Colors.white,
              strokeWidth: 2,
            ),
      onPressed: () async {
        await widget.bloc.addProperty(context, model);
        print(model.typeValue);
        print(model.categoryValue);
        print(model.genderValue);
        print(model.description);
        print(model.size);
        print(model.address);
        print(model.position);
        print(model.startDate);
        print(model.endDate);
        print(model.services);
      },
    );
  }
}
