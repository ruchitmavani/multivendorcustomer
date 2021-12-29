import 'package:flutter/material.dart';
import 'package:multi_vendor_customer/Utils/Providers/ColorProvider.dart';
import 'package:provider/provider.dart';

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
            spreadRadius: 0.5,
            blurRadius: 2,
            offset: Offset(0, 0.5), // changes position of shadow
          ),
        ],
      ),
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
                        fontSize: 13,
                        color: Colors.grey.shade700),
                  ))),
          Container(
            color: Colors.grey.shade400,
            height: 20,
            width: 1,
          ),
          Expanded(
            flex: 1,
            child: TextButton.icon(
              onPressed: () {
                showModalBottomSheet(
                    context: context,
                    backgroundColor: Colors.transparent,
                    builder: (context) {
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(
                              right: 15.0,
                              bottom: 15.0,
                            ),
                            child: SizedBox(
                              child: FloatingActionButton(
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                                child: Icon(
                                  Icons.close,
                                  size: 16,
                                  color: Colors.white,
                                ),
                              ),
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
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Padding(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 10),
                                  child: SizedBox(
                                    height: 20,
                                    child: InkWell(
                                      onTap: () {
                                        setState(() {
                                          _selection = SortKeys.NtoO;
                                          Navigator.pop(context);
                                        });
                                        widget
                                            .onClick!(SortKeys.NtoO.toString());
                                      },
                                      child: ListTile(
                                        title: Text(
                                          'New to Old',
                                          style: TextStyle(
                                            fontSize: 12,
                                            color: Colors.grey[700],
                                          ),
                                        ),
                                        leading: Radio<SortKeys>(
                                          value: SortKeys.NtoO,
                                          groupValue: _selection,
                                          splashRadius: 10,
                                          activeColor:
                                              Provider.of<CustomColor>(context)
                                                  .appPrimaryMaterialColor,
                                          onChanged: (SortKeys? value) {
                                            setState(() {
                                              _selection = value!;
                                              Navigator.pop(context);
                                            });
                                            widget.onClick!(value.toString());
                                          },
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 10),
                                  child: SizedBox(
                                    height: 20,
                                    child: InkWell(
                                      onTap: () {
                                        setState(() {
                                          _selection = SortKeys.OtoN;
                                          Navigator.pop(context);
                                        });
                                        widget
                                            .onClick!(SortKeys.OtoN.toString());
                                      },
                                      child: ListTile(
                                        minVerticalPadding: 2,
                                        title: Text(
                                          'Old to New',
                                          style: TextStyle(
                                            fontSize: 12,
                                            color: Colors.grey[700],
                                          ),
                                        ),
                                        leading: Radio<SortKeys>(
                                          splashRadius: 10,
                                          value: SortKeys.OtoN,
                                          groupValue: _selection,
                                          activeColor:
                                              Provider.of<CustomColor>(context)
                                                  .appPrimaryMaterialColor,
                                          onChanged: (SortKeys? value) {
                                            setState(() {
                                              _selection = value!;
                                              Navigator.pop(context);
                                            });
                                            widget.onClick!(value.toString());
                                          },
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 10),
                                  child: SizedBox(
                                    height: 20,
                                    child: InkWell(
                                      onTap: () {
                                        setState(() {
                                          _selection = SortKeys.spHtoL;
                                          Navigator.pop(context);
                                        });
                                        widget.onClick!(
                                            SortKeys.spHtoL.toString());
                                      },
                                      child: ListTile(
                                        minVerticalPadding: 2,
                                        title: Text(
                                          'Price: High to Low',
                                          style: TextStyle(
                                            fontSize: 12,
                                            color: Colors.grey[700],
                                          ),
                                        ),
                                        leading: Radio<SortKeys>(
                                          splashRadius: 10,
                                          value: SortKeys.spHtoL,
                                          groupValue: _selection,
                                          activeColor:
                                              Provider.of<CustomColor>(context)
                                                  .appPrimaryMaterialColor,
                                          onChanged: (SortKeys? value) {
                                            setState(() {
                                              _selection = value!;
                                              Navigator.pop(context);
                                            });
                                            widget.onClick!(value.toString());
                                          },
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      top: 10, bottom: 30),
                                  child: SizedBox(
                                    height: 20,
                                    child: InkWell(
                                      onTap: () {
                                        setState(() {
                                          _selection = SortKeys.spLtoH;
                                          Navigator.pop(context);
                                        });
                                        widget.onClick!(
                                            SortKeys.spLtoH.toString());
                                      },
                                      child: ListTile(
                                        minVerticalPadding: 2,
                                        title: Text(
                                          'Price: Low to High',
                                          style: TextStyle(
                                            fontSize: 12,
                                            color: Colors.grey[700],
                                          ),
                                        ),
                                        leading: Radio<SortKeys>(
                                          splashRadius: 10,
                                          value: SortKeys.spLtoH,
                                          groupValue: _selection,
                                          activeColor:
                                              Provider.of<CustomColor>(context)
                                                  .appPrimaryMaterialColor,
                                          onChanged: (SortKeys? value) {
                                            setState(() {
                                              _selection = value!;
                                              Navigator.pop(context);
                                            });
                                            widget.onClick!(value.toString());
                                          },
                                        ),
                                      ),
                                    ),
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
              ),
            ),
          )
        ],
      ),
    );
  }
}
