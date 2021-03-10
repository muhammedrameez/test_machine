import 'dart:io';
import 'dart:async';
import 'dart:convert';

import 'package:test_machine_app/bloc/common_bloc.dart';
import 'package:test_machine_app/model/main_screen_data_model.dart';

class HomeScreenDetailsProvider {
  HttpClient client1 = new HttpClient();

  Future<HomeScreenDetailsModel> fetchHomeScreenDetails(url) async {
    try {
      commonBloc.updateIsLoading(true);

      client1.badCertificateCallback =
          ((X509Certificate cert, String host, int port) => true);

      HttpClientRequest request = await client1.getUrl(Uri.parse(url));
      request.headers.set('content-type', 'application/json');

      HttpClientResponse response = await request.close();

      var result = new StringBuffer();
      await for (var contents in response.transform(Utf8Decoder())) {
        result.write(contents);
      }
      print(url);

      final Map parsed = jsonDecode(result.toString());

      HomeScreenDetailsModel homeScreenDetailsModel =
          HomeScreenDetailsModel.fromJson(parsed);
      commonBloc.updateIsLoading(false);
      return homeScreenDetailsModel;
    } catch (e) {
      commonBloc.updateIsLoading(false);
    }
  }
}
