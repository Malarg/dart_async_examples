import 'dart:async';

class StreamTester {
  ///пример single-subscription стрима
  void runStreamSimpleExample() {
    print('Simple stream example started');
    final stream = Stream.fromIterable([1, 2, 3, 4, 5]);
    stream.listen((number) {
      print('Number: $number');
    });
    print('Simple stream example started');
  }

  ///пример single-subscription стрима с использованием await
  void runStreamAwaitedSimpleExample() async {
    print('Simple stream example with await started');
    final stream = Stream.fromIterable([1, 2, 3, 4, 5]);
    await for (final number in stream) {
      print('Number: $number');
    }
    print('Simple stream example with await started');
  }

  ///пример broadcast стрима
  void runBroadcastStreamExample() {
    print('Broadcast stream example started');
    final streamController = StreamController.broadcast();
    streamController.stream.listen((number) {
      print('Listener 1: $number');
    });
    streamController.stream.listen((number) {
      print('Listener 2: $number');
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
    final subscribtion = streamController.stream.listen((number) {
      print('Listener: $number');
    });
    subscribtion.onDone(() {
      subscribtion.cancel();
      print('Done');
    });
    subscribtion.onError((error) {
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
