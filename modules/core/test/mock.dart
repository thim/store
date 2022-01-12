library simple_mock;

import 'package:flutter_test/flutter_test.dart';

final List<Symbol> register = [];
Map<Symbol, Function> calls = {};
final List<dynamic> capturedArgs = [];

String _getName(Function f) => RegExp(r"\'[A-z]+\'").firstMatch(f.toString())?.group(0)?.replaceAll("'", "") ?? "";

String _getNameFromInvocation(Invocation i) =>
    RegExp(r'\"[A-z]+\"').firstMatch(i.memberName.toString())?.group(0)?.replaceAll('"', "") ?? "";

bool verify(Function f, int number) {
  return number == register.where((element) => element == Symbol(_getName(f))).length;
}

void check<T>(bool Function(T) exp) {
  final T param = capturedArgs.firstWhere((element) => element is T);
  expect(exp(param), true);
}

void mock<T>(Function f, T Function() result) {
  calls[Symbol(_getName(f))] = result;
}

void clearMock() {
  register.clear();
  calls.clear();
  capturedArgs.clear();
}

class Mock {
  @override
  dynamic noSuchMethod(Invocation invocation) {
    register.add(invocation.memberName);
    capturedArgs.addAll(invocation.positionalArguments);
    capturedArgs.addAll(invocation.namedArguments.values);

    if (calls.containsKey(invocation.memberName)) {
      return calls[invocation.memberName]!.call();
    }
    throw Exception("$runtimeType.${_getNameFromInvocation(invocation)}() - Method not mocked");
  }
}
