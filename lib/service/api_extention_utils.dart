import 'dart:async';
import 'dart:developer';
import 'package:get/get.dart';

extension Retry<T> on Future<Response<T>> Function() {
  Future<Response<T>> withRetries({int count = 3}) async {
    while (true) {
      try {
        final future = this();
        return await future;
      }
      on Exception catch (e) {
        if (count > 0) {
          count--;
          log("retry error : ${toString()} :: retry count : $count",
              name: "api_util_ext", error: e);
        } else {
          rethrow;
        }
      }
    }
  }
}
