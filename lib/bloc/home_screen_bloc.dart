import 'package:rxdart/rxdart.dart';
import 'package:test_machine_app/model/main_screen_data_model.dart';
import 'package:test_machine_app/resources/repository/repository.dart';

class HomeScreenBloc {
  final _repository = Repository();
  final _homeScreenFetcher = PublishSubject<HomeScreenDetailsModel>();
  Observable<HomeScreenDetailsModel> get homeScreenDetails =>
      _homeScreenFetcher.stream;

  Future<HomeScreenDetailsModel> fetchhomeScreenDetails(url) async {
    HomeScreenDetailsModel homeScreenDetailsList =
        await _repository.getHomescreenDetails(url);
    _homeScreenFetcher.sink.add(homeScreenDetailsList);
    return homeScreenDetailsList;
  }

  void dispose() {
    _homeScreenFetcher.close();
  }
}

final homeScreenBloc = HomeScreenBloc();
