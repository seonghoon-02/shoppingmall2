import 'dart:io';
import 'Ui.dart';
import 'shoppingmall.dart';

void main(List<String> arguments) {
  ShoppingMall shoppingmall = ShoppingMall();
  Ui ui = Ui();
  
  while(shoppingmall.onOf){
    ui.showIndex();
    print("메뉴 번호를 입력해 주세요 !");
    try{
      String? input = stdin.readLineSync();
      int inputNum = int.parse(input!); //유효하지 않은 값 입력시 catch문 실행

      switch (inputNum) {
        case 1:
          shoppingmall.showProducts();
          break;
        case 2:
          shoppingmall.addToCart();
          break;
        case 3:
          shoppingmall.showCart();
          break;
        case 4:
          shoppingmall.shopClose();
          break;
        case 6:
          shoppingmall.resetCart();
          break;
        default:
          print('지원하지 않는 기능입니다 ! 다시 시도해주세요 ..');
      } 
    }
    catch(e){
      print('지원하지 않는 기능입니다 ! 다시 시도해주세요 ..');
    }
  }
}