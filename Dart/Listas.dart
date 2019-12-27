void main(){
  List<int> num = [1,2,3,4,5];
  print(num);
  num.add(6);
  print(num);

//   Tamaño fijo
  List num2 = List(10);
  print(num2);
//   num2.add(2);
//   print(num2);
  num2[0] = 10;
  print(num2);

}
