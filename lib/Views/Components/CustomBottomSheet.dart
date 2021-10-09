// import 'package:flutter/material.dart';
// import 'package:multi_vendor_customer/Views/ProductDetail.dart';
//
// class CustomBottomSheet extends StatefulWidget {
//   String productId;
//
//   CustomBottomSheet(this.productId);
//   @override
//   _CustomBottomSheetState createState() => _CustomBottomSheetState();
// }
//
// class _CustomBottomSheetState extends State<CustomBottomSheet> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Column(
//         crossAxisAlignment: CrossAxisAlignment.end,
//         mainAxisAlignment: MainAxisAlignment.end,
//         children: [
//           Padding(
//             padding: const EdgeInsets.only(right: 15.0, bottom: 15.0),
//             child: SizedBox(
//               child: FloatingActionButton(
//                   onPressed: () {
//                     Navigator.of(context).pop.call();
//                   },
//                   child: Icon(Icons.close, size: 16),
//                   backgroundColor: Colors.white),
//               width: 24,
//               height: 24,
//             ),
//           ),
//           Container(
//             decoration: BoxDecoration(
//               color: Colors.white,
//               borderRadius: BorderRadius.only(
//                   topRight: Radius.circular(10.0),
//                   topLeft: Radius.circular(10.0)),
//             ),
//             child: ProductDescription(widget.productId),
//           ),
//         ],
//       ),
//     );
//   }
// }
