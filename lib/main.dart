import 'package:dart_async_examples/completer_tester.dart';
import 'package:dart_async_examples/future_execute_order_tester.dart';
import 'package:dart_async_examples/stream_tester.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'dart:async examples',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(title: 'dart:async examples'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final _futureExecuteOrderTester = FutureExecuteOrderTester();
  final _completerTester = CompleterTester();
  final _streamTester = StreamTester();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: SingleChildScrollView(
                  child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              TextButton(
                onPressed: _futureExecuteOrderTester.runSimpleFutureExample,
                child: Text('Future method example'),
              ),
              TextButton(
                onPressed:
                    _futureExecuteOrderTester.runFutureWithAwaitExample,
                child: Text('Future async method example'),
              ),
              TextButton(
                onPressed: _futureExecuteOrderTester.runAwaitingMultipleFutures,
                child: Text('Multiple futures method example'),
              ),
              TextButton(
                onPressed: _completerTester.runCompleterInitTest,
                child: Text('Run completer example'),
              ),
              TextButton(
                onPressed: _streamTester.runStreamSimpleExample,
                child: Text('Run simple stream example'),
              ),
              TextButton(
                onPressed: _streamTester.runStreamAwaitedSimpleExample,
                child: Text('Run simple stream with await example'),
              ),
              TextButton(
                onPressed: _streamTester.runBroadcastStreamExample,
                child: Text('Run broadcast stream example'),
              ),
              TextButton(
                onPressed: _streamTester.runStreamSubscriptionExample,
                child: Text('Run stream subscription example'),
              ),
              TextButton(
                onPressed: _streamTester.runStreamControllerExample,
                child: Text('Run stream controller example'),
              ),
              TextButton(
                onPressed: _streamTester.runStreamIteratorExample,
                child: Text('Run stream iterator example'),
              ),
              TextButton(
                onPressed: _streamTester.runStreamTransformerExample,
                child: Text('Run stream transformer example'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
