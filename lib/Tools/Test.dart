import 'dart:async';
Timer? timer;
repetition(){

  if (timer == null){
    timer = Timer.periodic(Duration(seconds: 5), (t) {
      print("test ${t.tick}");
    });
  }
}
Future<void> main() async {
  repetition();


}