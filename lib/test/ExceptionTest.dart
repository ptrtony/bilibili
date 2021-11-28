import 'dart:async';

class ExceptionTest {
  void _makeCrash() async {
    //使用try-catch捕获同步异常
    try {
      throw StateError("this is a dart exception...");
    } catch (e) {
      print(e);
    }

    //使用catchError捕获异步异常
    Future.delayed(Duration(seconds: 1))
        .then((value) => throw StateError("this is first a dart exception..."))
        .catchError((e) => print(e));

    try {
      await Future.delayed(Duration(seconds: 1))
          .then((value) => throw StateError("this is second a dart exception"))
          .catchError((e) => print(e));
    } catch (e) {
      print(e);
    }

    //同步异常
    runZonedGuarded(() {
      throw StateError("runZonedGuarded:This is a dart exception.");
    }, (e, s) => print(e));

    //异步异常
    runZonedGuarded(() {
      Future.delayed(Duration(seconds: 1)).then((value) => throw StateError(
          "runZonedGuarded:This is first exception in future"));
    }, (e, s) => print(e));
  }
}
