//import 'package:shoppingmall/shoppingmall.dart' as shoppingmall;
import 'dart:io';

void main(List<String> arguments) {
  ShoppingMall shoppingmall = ShoppingMall();
  Ui ui = Ui();
  bool onOf = true;
  
  while(onOf){
    ui.showIndex();
    print("메뉴 번호를 입력해 주세요 !");
    String? input = stdin.readLineSync();
    if(input != null){
      int inputNum = int.parse(input);

      switch (inputNum) {
        case 1:
          shoppingmall.showProducts();
          break;
        case 2:
          shoppingmall.addToCart();
          break;
        case 3:
          shoppingmall.showTotal();
          break;
        case 4:
          print('프로그램을 종료합니다.');
          onOf = false;
          break;
        default:
          print('유효하지 않은 숫자입니다.');
      }
    }
    else{
      print('입력이 잘못되었습니다.');
    }
  }
}

class Ui{
  showIndex(){
    String line = '-';
    for(int i = 0; i <= 94; i++){
      line += '-';
    }
    print(line);
    print('[1] 상품 목록 보기 / [2] 장바구니에 담기 / [3] 장바구니에 담긴 상품의 총 가격 보기 / [4] 프로그램 종료');
    print(line);
  }
}

class ShoppingMall {
  List<Product> Products = [Product('shirt', 45000), Product('skirt', 30000), Product('outer', 35000), Product('pants', 38000), Product('socks', 5000)];
  // 윈도우 환경 오류로 품목을 한글에서 영문으로 변경
  Map<String, int> shoppingCart = {};
  
  showProducts(){ //1. 상품목록 출력 메서드
    for(int i = 0; i < Products.length; i++){
      String productName = Products[i].pName;
      int productPrice = Products[i].pPrice;
      print("$productName / $productPrice원");
    }
  }

  addToCart(){ //2. 상품을 장바구니에 담는 메서드
    print("상품 이름을 입력해 주세요 !");

    String? inputName = stdin.readLineSync();

    //입력받은 값이 null이거나 상품목록에 없을시
    if(inputName == null || !Products.any((product) => product.pName == inputName)){
      print("입력값이 올바르지 않아요 !");
      return;
    }

    print("상품 개수를 입력해 주세요 !");

    int inputNum;

    //숫자가 아니거나 0보다 크거나 작을시 오류 발생
    try{
      String? inputNumString = stdin.readLineSync();
      inputNum = int.parse(inputNumString!);
      if(inputNum <= 0){
        throw Exception();
      }
    }
    catch(e){
      print("입력값이 올바르지 않아요 !");
      return;
    }

    //getPrice : 장바구니에 입력될 가격. 리스트에서 동일한 pName를 검색하여 pPrice 호출
    int getPrice = Products.firstWhere((Product) => Product.pName == inputName).pPrice * inputNum;

    //장바구니에 동일한 상품이 담겨있는지 여부에 따라 다르게 처리
    if(shoppingCart.containsKey(inputName)){
      shoppingCart[inputName] = shoppingCart[inputName]! + getPrice;
    }
    else{
      shoppingCart[inputName] = getPrice;
    }
  }

  showTotal(){
    int sum;
    try{ //장바구니에 담지 않고 함수가 호출되었을 시 오류 발생
      sum = shoppingCart.values.reduce((a, b) => a + b);
    }
    catch(e){
      sum = 0;
    }
    print("장바구니에 $sum원 어치를 담으셨네요 !");

  }
}

class Product {
  String pName;
  int pPrice;

  Product(this.pName, this.pPrice);
}