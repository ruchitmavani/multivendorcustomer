import 'package:flutter/material.dart';

// ignore: must_be_immutable
class TextInputWidget extends StatelessWidget {
  String? hintText;
  String? lable;
  TextInputType? keyboardType;
  FormFieldValidator<String>? validator;
  int? maxLength;
  FocusNode? focusNode;
  Widget? hideShowText;
  TextCapitalization? textCapitalization = TextCapitalization.none;
  ValueChanged<String>? onChanged;
  ValueChanged<String>? onFieldSubmitted;
  TextEditingController? controller;
  TextInputAction? textInputAction;
  bool? isPassword;
  Widget? icon;
  int? maxLines;
  int? minLines;

  TextInputWidget({
    this.keyboardType,
    this.hintText,
    this.maxLength,
    this.lable,
    this.focusNode,
    this.controller,
    this.isPassword = false,
    this.validator,
    this.textCapitalization,
    this.onFieldSubmitted,
    this.textInputAction,
    this.onChanged,
    this.hideShowText,
    this.maxLines,
    this.minLines,
    this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 10.0),
      child: SizedBox(
        width: MediaQuery.of(context).size.width-30,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 4.0, bottom: 4.0),
              child: Text(lable ?? ""),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 2.0),
              child: TextFormField(
                autofocus: false,
                controller: controller,
                textCapitalization: textCapitalization ?? TextCapitalization.none,
                keyboardType: keyboardType,
                style: TextStyle(fontSize: 14),
                maxLength: maxLength,
                maxLines: maxLines,
                minLines: minLines,
                focusNode: focusNode,
                onChanged: onChanged,
                validator: validator,
                textInputAction: textInputAction,
                obscureText: isPassword!,
                onFieldSubmitted: onFieldSubmitted,
                decoration: InputDecoration(
                  fillColor: Colors.grey[200],
                  filled: true,
                  hintText: "${hintText ?? ""}",
                  hintStyle: TextStyle(fontSize: 13, color: Colors.grey),
                  floatingLabelBehavior: FloatingLabelBehavior.never,
                  contentPadding:
                      EdgeInsets.only(left: 20, right: 8, top: 4, bottom: 4),
                  counterText: "",
                  errorStyle:
                      TextStyle(color: Colors.red, fontWeight: FontWeight.bold),
                  suffix: hideShowText,
                  prefixIcon: icon,
                  errorBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
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
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
