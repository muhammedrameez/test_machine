import 'package:test_machine_app/model/main_screen_data_model.dart';
import 'package:test_machine_app/resources/provider/main_screen_data.dart';

class Repository {
  final homeScreenDetailsProvider = HomeScreenDetailsProvider();

  Future<HomeScreenDetailsModel> getHomescreenDetails(url) =>
      homeScreenDetailsProvider.fetchHomeScreenDetails(url);
}
