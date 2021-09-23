
import 'package:flutter/material.dart';
import 'package:multi_vendor_customer/Constants/colors.dart';

typedef void BoolCallBack(bool value);
typedef void StringCallBack(String value);
enum SortKeys { NtoO, OtoN, spLtoH, spHtoL }

class TopButtons extends StatefulWidget {
  final BoolCallBack? onChanged;
  final StringCallBack? onClick;

  TopButtons({this.onChanged, this.onClick});

  @override
  _TopButtonsState createState() => _TopButtonsState();
}

class _TopButtonsState extends State<TopButtons> {
  bool isGrid = true;
  SortKeys _selection = SortKeys.NtoO;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.3),
            spreadRadius: 1,
            blurRadius: 2,
            offset: Offset(0, 1), // changes position of shadow
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        child: Row(
          children: [
            Expanded(
                flex: 1,
                child: TextButton.icon(
                    onPressed: () {
                      if (widget.onChanged != null) {
                        setState(() {
                          isGrid = !isGrid;
                        });
                        widget.onChanged!(isGrid);
                      }
                    },
                    icon: Icon(isGrid ? Icons.grid_view : Icons.list,
                        size: 20, color: Colors.grey.shade700),
                    label: Text(
                      isGrid ? "GridView" : "ListView",
                      style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 12,
                          color: Colors.grey.shade700),
                    ))),
            Container(
              color: Colors.grey.shade400,
              height: 25,
              width: 1,
            ),
            Expanded(
                flex: 1,
                child: TextButton.icon(
                    onPressed: () {
                      showModalBottomSheet(
                          context: context,
                          isScrollControlled: true,
                          backgroundColor: Colors.transparent,
                          builder: (context) {
                            return Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(
                                      right: 15.0, bottom: 15.0),
                                  child: SizedBox(
                                    child: FloatingActionButton(
                                        onPressed: () {
                                          Navigator.of(context).pop();
                                        },
                                        child: Icon(Icons.close, size: 16),
                                        backgroundColor: Colors.white),
                                    width: 24,
                                    height: 24,
                                  ),
                                ),
                                Container(
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.only(
                                        topRight: Radius.circular(10.0),
                                        topLeft: Radius.circular(10.0)),
                                  ),
                                  child: Column(
                                    children: [
                                      ListTile(
                                        title: const Text('New to Old'),
                                        leading: Radio<SortKeys>(
                                          value: SortKeys.NtoO,
                                          groupValue: _selection,
                                          activeColor: appPrimaryMaterialColor,

                                          onChanged: (SortKeys? value) {
                                            setState(() {
                                              _selection = value!;
                                              Navigator.pop(context);
                                            });
                                            widget.onClick!(value.toString());
                                          },
                                        ),
                                      ),
                                      ListTile(
                                        title: const Text('Old to New'),
                                        leading: Radio<SortKeys>(
                                          value: SortKeys.OtoN,
                                          groupValue: _selection,
                                          activeColor: appPrimaryMaterialColor,

                                          onChanged: (SortKeys? value) {
                                            setState(() {
                                              _selection = value!;
                                              Navigator.pop(context);
                                            });
                                            widget.onClick!(value.toString());
                                          },
                                        ),
                                      ),
                                      ListTile(
                                        title: const Text('Price: High to Low'),
                                        leading: Radio<SortKeys>(
                                          value: SortKeys.spHtoL,
                                          groupValue: _selection,
                                          activeColor: appPrimaryMaterialColor,

                                          onChanged: (SortKeys? value) {
                                            setState(() {
                                              _selection = value!;
                                              Navigator.pop(context);
                                            });
                                            widget.onClick!(value.toString());
                                          },
                                        ),
                                      ),
                                      ListTile(
                                        title: const Text('Price: Low to High'),
                                        leading: Radio<SortKeys>(
                                          value: SortKeys.spLtoH,
                                          groupValue: _selection,
                                          onChanged: (SortKeys? value) {
                                            setState(() {
                                              _selection = value!;
                                              Navigator.pop(context);
                                            });
                                            widget.onClick!(value.toString());
                                          },
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            );
                          });
                    },
                    icon: Icon(Icons.arrow_downward,
                        size: 18, color: Colors.grey.shade700),
                    label: Text(
                      "Sort",
                      style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 12,
                          color: Colors.grey.shade700),
                    )))
          ],
        ),
      ),
    );
  }
}
