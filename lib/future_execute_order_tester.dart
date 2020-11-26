import 'dart:async';

///Класс для демонстрации примеров выполнения Future
class FutureExecuteOrderTester {
  ///Демонстрирует выполнение future
  runSimpleFutureExample({
    String question = 'В чем смысл жизни и всего такого?',
  }) {
    print('Start of future example');
    Future(() {
      print('Вопрос: $question');
      if (question.length > 10) { 
        return 42;
      } else {
        throw Exception('Вы задали недостаточно сложный вопрос.');
      }
    }).then((result) {
      print('Ответ: $result');
    }).catchError((error) {
      print('Ошибка. $error');
    });
    print('Finish of future example');
  }

  ///Демонстрирует выполнение future с использованием await
  runFutureWithAwaitExample({
    String question = 'В чем смысл жизни и всего такого?',
  }) async {
    print('Start of future example');
    try {
      final result = await _getAnswerForQuestion(
        'В чем смысл жизни и всего такого?',
      );
      print('Ответ: $result');
    } catch (error) {
      print('Ошибка. $error');
    }
    print('Finish of future example');
  }

  Future<int> _getAnswerForQuestion(String question) => Future(() {
        print('Вопрос: $question');
        if (question.length > 10) {
          return 42;
        } else {
          throw Exception('Вы задали недостаточно сложный вопрос.');
        }
      });

  ///Пример демонстрирует очередность выполнения нескольких Future в одном асинхронном методе
  runAwaitingMultipleFutures() async {
    print('start awaiting multiple futures example');
    var fstFutureResult =
        await Future.delayed(Duration(seconds: 2)).then((value) {
      print('first future awaited');
      return 5;
    });
    var sndFutureResult =
        await Future.delayed(Duration(seconds: 1)).then((value) {
      print('second future awaited');
      return 2;
    });
    print('futures result sum: ${fstFutureResult + sndFutureResult}');
    print('finish awaiting multiple futures example');
  }
}
