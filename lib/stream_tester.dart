import 'dart:async';

class StreamTester {
  void runStreamSimpleExample() {
    print('Simple stream example started');
    final stream = Stream.fromIterable([1, 2, 3, 4, 5]);
    stream.listen((number) {
      print('listener 1: $number');
    });
    stream.listen((number) {
      print('listener 2: $number');
    });
    print('Simple stream example finished');
  }

  void runStreamAwaitedSimpleExample() async {
    print('Simple stream example with await started');
    final stream = Stream.fromIterable([1, 2, 3, 4, 5]);
    await for (final number in stream) {
      print('Number: $number');
    }
    print('Simple stream example with await finished');
  }

  ///пример broadcast стрима
  void runBroadcastStreamExample() {
    print('Broadcast stream example started');
    final streamController = StreamController.broadcast();
    streamController.stream.listen((number) {
      print('Listener 1: $number');
    });
    StreamSubscription sub2;
    sub2 = streamController.stream.listen((number) {
      print('Listener 2: $number');
      if (number == 3) {
        sub2.cancel();
      }
    });
    streamController.sink.add(1);
    streamController.sink.add(2);
    streamController.sink.add(3);
    streamController.sink.add(4);
    streamController.sink.add(5);
    streamController.close();
    print('Broadcast stream example finished');
  }

  ///пример StreamController
  void runStreamControllerExample() {
    print('Broadcast stream example started');
    final streamController = StreamController.broadcast();
    streamController.onListen = () {
      print('onListen invoked');
    };
    streamController.onCancel = () {
      print('onCancel invoked');
    };
    streamController.stream.listen((number) {
      print('Listener: $number');
    });
    streamController.sink.add(1);
    streamController.sink.add(2);
    streamController.sink.add(3);
    streamController.sink.add(4);
    streamController.sink.add(5);
    streamController.close();
    print('Broadcast stream example finished');
  }

  ///пример для демонстрации возможностей StreamSubscription
  void runStreamSubscriptionExample() {
    print('StreamSubscription example started');
    final streamController = StreamController.broadcast();
    streamController.onListen = () {
      print('onListen invoked');
    };
    streamController.onCancel = () {
      print('onCancel invoked');
    };
    final subscription = streamController.stream.listen((number) {
      print('Listener: $number');
    });
    subscription.onDone(() {
      subscription.cancel();
      print('Done');
    });
    subscription.onError((error) {
      print('Error: $error');
    });
    streamController.sink.add(1);
    streamController.sink.add(2);
    streamController.sink.add(3);
    streamController.sink.add(4);
    streamController.sink.add(5);
    streamController.close();
    print('StreamSubscription example finished');
  }

  void runStreamIteratorExample() async {
    print('StreamIteratorExample started');
    var stream = Stream.fromIterable([1, 2, 3]);
    var iterator = StreamIterator(stream);
    bool moveResult;
    do {
      moveResult = await iterator.moveNext();
      print('number: ${iterator.current}');
    } while (moveResult);
    print('StreamIteratorExample finished');
  }

  void runStreamTransformerExample() async {
    print('StreamTransformer example started');
    StreamTransformer doubleTransformer =
        new StreamTransformer.fromHandlers(handleData: (data, EventSink sink) {
      sink.add(data * 2);
    });

    StreamController controller = StreamController();
    controller.stream.transform(doubleTransformer).listen((data) {
      print('data: $data');
    });

    controller.add(1);
    controller.add(2);
    controller.add(3);
    print('StreamTransformer example finished');
  }
}
