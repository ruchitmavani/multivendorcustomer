import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:multi_vendor_customer/Utils/Providers/ColorProvider.dart';
import 'package:provider/provider.dart';

class MyTextFormField extends StatefulWidget {
  AutovalidateMode? autoValidateMode;
  bool autofocus;
  late String? hintText;
  late String? lable;
  late TextInputType? keyboardType;
  late int? maxLength;
  late FocusNode? focusNode;
  late EdgeInsetsGeometry? contentPadding;
  late Widget? visibility;
  late TextCapitalization? textCapitalization = TextCapitalization.sentences;
  late FormFieldValidator<String>? validator;
  late ValueChanged<String>? onChanged;
  late ValueChanged<String>? onFieldSubmitted;
  late TextEditingController? controller;
  late TextInputAction? textInputAction;
  late bool isPassword = false;
  late bool readOnly = false;
  bool? isenableInteractiveSelection;
  late bool isenable = true;
  late Widget? icon;
  late int? maxLines;
  late int? minLines;
  List<TextInputFormatter>? inputFormatters;

  MyTextFormField(
      {this.hintText,
      this.lable,
      this.keyboardType,
      this.maxLength,
      this.autoValidateMode,
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
      this.isenableInteractiveSelection,
      this.icon,
      this.maxLines,
      this.minLines,
      this.contentPadding,
      this.inputFormatters,
      this.isenable = true,
      this.autofocus = false});

  @override
  _MyTextFormFieldState createState() => _MyTextFormFieldState();
}

class _MyTextFormFieldState extends State<MyTextFormField> {
  Color color = Colors.grey.shade200;

  @override
  void initState() {
    super.initState();
    if (widget.focusNode != null) {
      widget.focusNode!.addListener(() {
        if (widget.focusNode!.hasFocus) {
          setState(() {
            color = Colors.white;
          });
        } else {
          setState(() {
            color = Colors.grey.shade200;
          });
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 4.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (widget.lable != null)
            Padding(
              padding: const EdgeInsets.only(left: 4, right: 4),
              child: Text(
                "${widget.lable}",
                style: TextStyle(
                    fontFamily: "Poppins",
                    color: Color(0xFF929292),
                    fontSize: 12,
                    fontWeight: FontWeight.w500),
              ),
            ),
          Padding(
            padding: const EdgeInsets.only(top: 2.0),
            child: TextFormField(
              autovalidateMode: widget.autoValidateMode,
              autofocus: widget.autofocus,
              enabled: widget.isenable,
              enableInteractiveSelection:
                  widget.isenableInteractiveSelection ?? true,
              readOnly: widget.readOnly,
              controller: widget.controller,
              textCapitalization:
                  widget.textCapitalization ?? TextCapitalization.sentences,
              keyboardType: widget.keyboardType,
              style: TextStyle(fontSize: 12),
              maxLength: widget.maxLength,
              maxLines: widget.maxLines ?? 1,
              minLines: widget.minLines,
              focusNode: widget.focusNode,
              onChanged: widget.onChanged,
              validator: widget.validator,
              textInputAction: widget.textInputAction,
              obscureText: widget.isPassword,
              onFieldSubmitted: widget.onFieldSubmitted,
              inputFormatters: widget.inputFormatters,
              decoration: InputDecoration(
                filled: true,
                hintText: "${widget.hintText ?? ""}",
                hintStyle: TextStyle(fontSize: 12, color: Colors.grey.shade400),
                floatingLabelBehavior: FloatingLabelBehavior.never,
                contentPadding: widget.contentPadding == null
                    ? EdgeInsets.only(left: 15, right: 8, top: 4, bottom: 4)
                    : widget.contentPadding,
                counterText: "",
                errorStyle: TextStyle(
                    color: Colors.red.shade500,
                    fontWeight: FontWeight.w500,
                    fontSize: 12),
                prefixIcon: widget.icon,
                suffixIcon: widget.visibility,
                errorMaxLines: 2,
                errorBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide(
                    width: 1,
                    color: Colors.red,
                    style: BorderStyle.solid,
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                      color: Provider.of<CustomColor>(context)
                          .appPrimaryMaterialColor,
                      width: 0.7),
                  borderRadius: BorderRadius.circular(8.0),
                ),
                disabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide(
                    width: 0,
                    style: BorderStyle.none,
                  ),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide(
                    width: 0,
                    style: BorderStyle.none,
                  ),
                ),
                focusedErrorBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide(
                    width: 1,
                    color: Colors.red,
                    style: BorderStyle.solid,
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
