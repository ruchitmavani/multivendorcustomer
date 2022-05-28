import 'package:flutter/material.dart';
import 'package:multi_vendor_customer/Constants/textStyles.dart';
import 'package:multi_vendor_customer/Utils/Providers/ColorProvider.dart';
import 'package:provider/provider.dart';

failedDialog(BuildContext context, Map<dynamic, dynamic>? value) {
  showDialog<String>(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext context) => WillPopScope(
      onWillPop: () => Future.value(false),
      child: Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        child: CustomDialog(
          value: value,
        ),
      ),
    ),
  );
}

class CustomDialog extends StatefulWidget {
  const CustomDialog({Key? key, required this.value}) : super(key: key);

  final Map<dynamic, dynamic>? value;

  @override
  State<CustomDialog> createState() => _CustomDialogState();
}

class _CustomDialogState extends State<CustomDialog> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            "Unable to complete transaction due to interruption,\nif money debited from your account please contact admin.",
            textAlign: TextAlign.center,
          ),
          Padding(
            padding: const EdgeInsets.only(top: 8.0),
            child: Text(
              "+91 99623 10666",
              style: FontsTheme.digitStyle(
                fontSize: 14,
                color:
                    context.watch<ThemeColorProvider>().appPrimaryMaterialColor,
              ),
            ),
          ),
          if (widget.value != null)
            Column(
              mainAxisSize: MainAxisSize.min,
              children: List.generate(
                widget.value!.keys.length,
                (index) => Padding(
                  padding: const EdgeInsets.only(top: 7),
                  child: RichText(
                    text: TextSpan(
                        text: "${widget.value!.keys.elementAt(index)} :",
                        style: FontsTheme.valueStyle(
                          color: Colors.grey.withOpacity(
                            0.8,
                          ),
                        ),
                        children: [
                          TextSpan(
                            text: " ${widget.value!.values.elementAt(index)}",
                            style: FontsTheme.boldTextStyle(),
                          ),
                        ]),
                  ),
                ),
              ),
            ),
          Padding(
            padding: const EdgeInsets.only(top: 15),
            child: InkWell(
              onTap: () {
                if (Navigator.canPop(context)) {
                  Navigator.pop(context);
                }
              },
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                decoration: BoxDecoration(
                  color: context
                      .watch<ThemeColorProvider>()
                      .appPrimaryMaterialColor,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Text(
                  "Okay got it",
                  style: FontsTheme.boldTextStyle(
                    color: Colors.white,
                    size: 13,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
