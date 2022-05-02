// extension DoubleRoundOff on double{
//   double roundOff(){
//     return this.ceilToDouble();
//   }
// }

extension DoubleRoundOff on double {
  double roundOff() => double.parse(toStringAsFixed(2));
}