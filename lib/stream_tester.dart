import 'dart:async';

class StreamTester {
  ///пример single-subscription стрима
  void runSingleSubscriptionStreamExample() {
    print('single-subscription stream example started');
    try {
      final stream = Stream.fromIterable([1, 2, 3, 4, 5]);
      stream.listen((number) {
        print('Listener 1. number: $number');
      });
      stream.listen((number) {
        print('Listener 2. number: $number');
      });
    } catch (e) {
      print('error: $e');
    }
    print('single-subscription stream example finished');
  }

  ///пример для демонстрации возможностей StreamSubscription
  void runStreamSubscriptionExample() {
    print('StreamSubscription example started');
    final stream = Stream.fromIterable([1, 2, 3, 4, 5]);
    StreamSubscription subscription;

    subscription = stream.listen((number) {
      print('Listener 1. number: $number');
      if (number == 3) {
        subscription.cancel();
      }
    });

    subscription.onDone(() {
      print('stream is done');
    });
    subscription.onError((e) {
      print('Stream error');
    });

    print('StreamSubscription example finished');
  }

  ///Пример, показывающий работу StreamController
  void runStreamControllerExample() async {
    print('StreamController example started');
    final streamController = StreamController.broadcast();
    streamController.stream.listen((number) {
      print('number: $number');
    });
    streamController.stream.listen((number) {
      print('number: $number'.toUpperCase());
    });
    streamController.add(1);
    streamController.add(3);
    streamController.add(5);
    streamController.addError(Exception('dangerous exception'));
    streamController.close();
    print('StreamController example finished');
  }

  Future<void> runMultiStreamControllerExample() async {
    print('MultiStreamController example started');
    Stream.multi((controller) {
      controller.sink.add(1);
      controller.sink.add(2);
      controller.sink.add(4);
      controller.addSync(3);
      controller.onListen = () {
        print('listen');
      };
    }, isBroadcast: true);
    print('MultiStreamController example finished');
  }

  void runStreamIteratorExample() async {
    print('StreamIterator example started');
    var stream = Stream.fromIterable([1, 2, 3]);
    var iterator = StreamIterator(stream);
    do {
      await iterator.moveNext();
      print('number: ${iterator.current}');
    } while (iterator.current != null);
    print('StreamIterator example finished');
  }

  void runStreamTransformerExample() async {
    print('StreamTransformer example started');
    StreamTransformer doubleTransformer =
        new StreamTransformer.fromHandlers(handleData: (data, EventSink sink) {
      sink.add(data * 2);
    });

    StreamController controller = new StreamController();
    controller.stream.transform(doubleTransformer).listen((data) {
      print('data: $data');
    });

    controller.add(1);
    controller.add(2);
    controller.add(3);
    print('StreamTransformer example finished');
  }
}
