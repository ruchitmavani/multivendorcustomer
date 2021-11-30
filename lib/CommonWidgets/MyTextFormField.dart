import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

// ignore: must_be_immutable
class MyTextFormField extends StatelessWidget {
  late String? hintText;
  late String? lable;
  late TextInputType? keyboardType;
  late int? maxLength;
  late FocusNode? focusNode;
  late EdgeInsetsGeometry? contentPadding;
  late Widget? visibility;
  late TextCapitalization? textCapitalization = TextCapitalization.none;
  late FormFieldValidator<String>? validator;
  late ValueChanged<String>? onChanged;
  late ValueChanged<String>? onFieldSubmitted;
  late TextEditingController? controller;
  late TextInputAction? textInputAction;
  late bool isPassword = false;
  late bool readOnly = false;
  late bool isenableInteractiveSelection = false;
  late bool isenable = true;
  late Widget? icon;
  late int? maxLines;
  late int? minLines;
  late bool? filled=true;
  late bool autofocus=false;
  late List<TextInputFormatter>? inputFormatters;

  MyTextFormField(
      {this.hintText,
      this.lable,
        this.filled,
      this.keyboardType,
      this.maxLength,
      this.focusNode,
      this.visibility,
      this.textCapitalization,
      this.validator,
      this.onChanged,
      this.onFieldSubmitted,
      this.controller,
      this.textInputAction,
      this.isPassword = false,
      this.readOnly = false,
      this.isenableInteractiveSelection = false,
      this.icon,
      this.maxLines,
      this.minLines,
      this.contentPadding,
        this.autofocus=false,
      this.isenable = true,this.inputFormatters});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 4.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (lable != null)
            Padding(
              padding: const EdgeInsets.only(
                  top: 4.0, bottom: 4.0, left: 4, right: 4),
              child: Text(
                "$lable",
                style: TextStyle(
                    color: Colors.black54,
                    fontSize: 13,
                    fontWeight: FontWeight.w600),
              ),
            ),
          Padding(
            padding: const EdgeInsets.only(top: 2.0),
            child: TextFormField(
              autofocus: autofocus,
              enabled: isenable,
              enableInteractiveSelection: isenableInteractiveSelection,
              readOnly: readOnly,
              controller: controller,
              textCapitalization: textCapitalization ?? TextCapitalization.none,
              keyboardType: keyboardType,
              style: TextStyle(fontSize: 14),
              maxLength: maxLength,
              maxLines: maxLines ?? 1,
              minLines: minLines,
              focusNode: focusNode,
              onChanged: onChanged,
              validator: validator,
              textInputAction: textInputAction,
              obscureText: isPassword,
              onFieldSubmitted: onFieldSubmitted,
              inputFormatters: inputFormatters,
              decoration: InputDecoration(
                  fillColor: Colors.grey.shade200,
                  focusColor: Colors.green,
                  filled: filled??true,
                  hintText: "${hintText ?? ""}",
                  hintStyle: TextStyle(
                      fontSize: 12,
                      color: Colors.grey.shade400),
                  floatingLabelBehavior: FloatingLabelBehavior.never,
                  contentPadding: contentPadding == null
                      ? EdgeInsets.only(left: 15, right: 8, top: 4, bottom: 4)
                      : contentPadding,
                  counterText: "",
                  errorStyle:
                      TextStyle(color: Colors.red, fontWeight: FontWeight.bold),
                  prefixIcon: icon,
                  suffixIcon: visibility,
                  errorBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(7),
                    borderSide: BorderSide(
                      width: 1.5,
                      color: Colors.red,
                      style: BorderStyle.solid,
                    ),
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide(
                      width: 0,
                      style: BorderStyle.none,
                    ),
                  )),
            ),
          )
        ],
      ),
    );
  }
}
