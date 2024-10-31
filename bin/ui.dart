class Ui{
  showIndex(){
    String line = '-';
    for(int i = 0; i <= 100; i++){
      line += '-';
    }
    print(line);
    print('[1] 상품 목록 보기 / [2] 장바구니에 담기 / [3] 장바구니에 담긴 상품의 총 가격 보기 / [4] 프로그램 종료');
    print(line);
  }
}