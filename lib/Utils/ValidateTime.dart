bool checkTimeBetween(DateTime date1,DateTime date2){
  DateTime now=DateTime.now();

  if(date1.isAfter(now)&&date2.isBefore(date2)){
    return true;
  }else{
  return false;}
}