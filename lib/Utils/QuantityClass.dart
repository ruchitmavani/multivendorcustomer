import 'package:flutter/material.dart';

class Quantity with ChangeNotifier{
  int quantity=0;

  void increment(){
    this.quantity++;
    notifyListeners();
  }

  void decrement(){
    if(quantity>=1){
      this.quantity--;
      notifyListeners();
    }
  }
}

