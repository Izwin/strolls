import 'package:date_field/date_field.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:strolls/features/home/presentation/widgets/glass_container.dart';

class GradientDropDown extends StatelessWidget {
  GradientDropDown(
      {required this.label,
      required this.onChanged,
      this.item,
      this.items = const [],
      Key? key})
      : super(key: key);
  String label;
  String? item;
  List<String> items;
  Function(String) onChanged;

  @override
  Widget build(BuildContext context) {
    return GlassContainer(
      height: 60,
      gradient: LinearGradient(
        begin: const Alignment(0.00, -1.00),
        end: const Alignment(0, 1),
        colors: [
          Colors.black.withOpacity(0.5),
          const Color(0xFF050005).withOpacity(0.5)
        ],
      ),
      child: Center(
        child: DropdownSearch(
          items: items,
          onChanged: (city) {
            onChanged.call(city!);
          },
          selectedItem: item,
          popupProps: PopupProps.menu(
              showSelectedItems: true,
              showSearchBox: true,
              searchDelay: Duration.zero,
              fit: FlexFit.loose,
              itemBuilder: (context, String string, v) {
                return Center(
                  child: Text(
                    string,
                    style: const TextStyle(
                        fontSize: 26,
                        fontStyle: FontStyle.italic,
                        color: Colors.black),
                  ),
                );
              },
              constraints: const BoxConstraints(maxHeight: 200),
              menuProps: MenuProps(
                  backgroundColor: const Color(0xFFE3E3E3),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20))),
              disabledItemFn: (String s) => false,
              searchFieldProps: TextFieldProps(
                  padding: const EdgeInsets.all(20),
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: const Color(0xFFC5C5C5),
                    floatingLabelStyle:
                        const TextStyle(fontSize: 16, height: 1),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                        borderSide: BorderSide.none),
                    hintText: label,
                    hintStyle: const TextStyle(
                        color: Color(0xFF8A8A8A),
                        fontSize: 14,
                        height: 1,
                        fontWeight: FontWeight.w400),
                    contentPadding: const EdgeInsets.symmetric(
                        vertical: 10.0, horizontal: 35),
                  ))),
          dropdownButtonProps: DropdownButtonProps(
              icon: Visibility(
            visible: false,
            child: Container(),
          )),
          dropdownDecoratorProps: DropDownDecoratorProps(
            baseStyle: TextStyle(color: Colors.white, fontSize: 16),
            textAlignVertical: TextAlignVertical.center,
            dropdownSearchDecoration: InputDecoration(
              hintStyle: TextStyle(color: Colors.white.withOpacity(0.4),fontSize: 16),
              hintText: label,
              border: InputBorder.none,
              prefixIcon: null,
              icon: null,
              suffixIcon: null,
              contentPadding:
                  const EdgeInsets.symmetric(vertical: 0.0, horizontal: 35),
            ),
          ),
        ),
      ),
    );
  }
}
