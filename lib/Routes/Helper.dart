import 'dart:html';

String helper(String screen){
  print(window.location.pathname);
  return "${window.location.pathname}/$screen";
}