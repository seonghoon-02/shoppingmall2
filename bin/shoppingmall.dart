import 'dart:io';

class ShoppingMall {
  bool onOf = true;
  List<Product> products = [Product('shirt', 45000), Product('skirt', 30000), Product('outer', 35000), Product('pants', 38000), Product('socks', 5000)];
  // 윈도우 환경 오류로 품목을 한글에서 영문으로 변경
  Map<String, int> shoppingCart = {};
  
  showProducts(){ //1. 상품목록 출력 메서드
    for(int i = 0; i < products.length; i++){
      String productName = products[i].pName;
      int productPrice = products[i].pPrice;
      print("$productName / $productPrice원");
    }
  }

  addToCart(){ //2. 상품을 장바구니에 담는 메서드
    print("상품 이름을 입력해 주세요 !");

    String? inputName = stdin.readLineSync();

    //입력받은 값이 null이거나 상품목록에 없을시
    if(inputName == null || !products.any((product) => product.pName == inputName)){
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
        print("0개보다 많은 개수의 상품만 담을 수 있어요 !");
        return;
      }
    }
    catch(e){
      print("입력값이 올바르지 않아요 !");
      return;
    }

    //getPrice : 장바구니에 입력될 가격. 리스트에서 동일한 pName를 검색하여 pPrice 호출
    int getPrice = products.firstWhere((Product) => Product.pName == inputName).pPrice * inputNum;

    //장바구니에 동일한 상품이 담겨있는지 여부에 따라 다르게 처리
    if(shoppingCart.containsKey(inputName)){
      shoppingCart[inputName] = shoppingCart[inputName]! + getPrice;
    }
    else{
      shoppingCart[inputName] = getPrice;
    }

    print("장바구니에 상품이 담겼어요 !");
  }

  showCart(){
    if(shoppingCart.isEmpty){
      print('장바구니에 담긴 상품이 없습니다.');
    }
    else{
      for(String cName in shoppingCart.keys){
        int? cPrice = shoppingCart[cName];
        print('$cName : $cPrice원');
      }
      String totalName = shoppingCart.keys.join(', ');
      int totalPrice = shoppingCart.values.reduce((a, b) => a + b);
      print('장바구니에 $totalName 상품이 담겨있네요. 총 $totalPrice원 입니다!');
    }
  }

  shopClose(){ //종료 재확인
    print('정말 종료하시겠습니까?( [5] : 종료 )');
    String? close = stdin.readLineSync();
    if(close != '5'){
      print('종료하지 않습니다.');
    }
    else{
      print('이용해 주셔서 감사합니다.');
      onOf = false;
    }
  }

  resetCart(){ //장바구니 비우기
    if(shoppingCart.isEmpty){
      print('이미 장바구니가 비어있습니다.');
    }
    else{
      print('장바구니를 초기화 합니다.');
      shoppingCart = {};
    }
  }
}

//상품 정보 저장 양식
class Product {
  String pName;
  int pPrice;

  Product(this.pName, this.pPrice);
}