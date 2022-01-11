import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:multi_vendor_customer/Utils/Providers/ColorProvider.dart';
import 'package:provider/provider.dart';

class DiscountTag extends StatelessWidget {
  final double mrp;
  final double selling;

  DiscountTag({Key? key, required this.mrp, required this.selling})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return mrp > selling
        ? MeasureSize(
      onChange: (size) {
        print(size);
      },
          child: Container(
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: Provider.of<CustomColor>(context).appPrimaryMaterialColor,
                borderRadius: BorderRadius.circular(4),
              ),
              child: Padding(
                padding:
                    const EdgeInsets.only(top: 2, right: 3, left: 3, bottom: 2),
                child: Text(
                  "${100 - (selling / mrp * 100).round()}% off",
                  style: TextStyle(
                      fontFamily: 'Poppins', fontSize: 11, color: Colors.white),
                ),
              ),
            ),
        )
        : SizedBox(height: 20,);
  }
}

typedef void OnWidgetSizeChange(Size size);

class MeasureSizeRenderObject extends RenderProxyBox {
  Size? oldSize;
  final OnWidgetSizeChange onChange;

  MeasureSizeRenderObject(this.onChange);

  @override
  void performLayout() {
    super.performLayout();

    Size newSize = child!.size;
    if (oldSize == newSize) return;

    oldSize = newSize;
    WidgetsBinding.instance!.addPostFrameCallback((_) {
      onChange(newSize);
    });
  }
}

class MeasureSize extends SingleChildRenderObjectWidget {
  final OnWidgetSizeChange onChange;

  const MeasureSize({
    Key? key,
    required this.onChange,
    required Widget child,
  }) : super(key: key, child: child);

  @override
  RenderObject createRenderObject(BuildContext context) {
    return MeasureSizeRenderObject(onChange);
  }
}