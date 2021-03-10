import 'dart:async';

class CommonBloc {
  bool isLoading = false;

  final loadingController = StreamController<bool>.broadcast();

  Stream get getIsLoading => loadingController.stream;

  void updateIsLoading(bool loading) {
    isLoading = loading;
    loadingController.sink.add(isLoading);
  }

  dispose() async {
    loadingController.close();
  }
}

final commonBloc = CommonBloc();
