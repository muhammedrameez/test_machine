import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:test_machine_app/bloc/common_bloc.dart';
import 'package:test_machine_app/bloc/home_screen_bloc.dart';
import 'package:test_machine_app/model/main_screen_data_model.dart';
import 'package:test_machine_app/util/color_theme.dart';
import 'package:test_machine_app/widget/loading_widget.dart';
import 'package:test_machine_app/widget/no_data_widget.dart';

class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  ScrollController _scrollController = new ScrollController();
  final _formKey = GlobalKey<FormState>();
  int selectedIndex = 0, pageIndex = 1;
  int previousIndex = -1;
  String mode;
  var data;
  HomeScreenDetailsModel homeScreenDetailsModel = HomeScreenDetailsModel();

  @override
  void initState() {
    homeScreenBloc
        .fetchhomeScreenDetails("https://swapi.dev/api/species/?page=1");
    super.initState();
    commonBloc.updateIsLoading(false);

    _scrollController
      ..addListener(() {
        if (_scrollController.position.maxScrollExtent ==
            _scrollController.position.pixels) {
          if (homeScreenDetailsModel.next != null) {
            commonBloc.updateIsLoading(true);
            homeScreenBloc.fetchhomeScreenDetails(homeScreenDetailsModel.next);
          }
        } else if (_scrollController.position.minScrollExtent ==
            _scrollController.position.pixels) {
          if (homeScreenDetailsModel.previous != null) {
            commonBloc.updateIsLoading(true);
            homeScreenBloc
                .fetchhomeScreenDetails(homeScreenDetailsModel.previous);
          }
        }
      });
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
        appBar: AppBar(
          leading: Icon(Icons.menu),
          title: Text('Test App'),
          actions: [],
          backgroundColor: Colors.grey,
        ),
        backgroundColor: Colors.white,
        body: Container(
          child: Builder(
            builder: (context) => SingleChildScrollView(
              child: Stack(
                children: <Widget>[
                  RefreshIndicator(
                    onRefresh: () async {
                      commonBloc.updateIsLoading(true);
                      homeScreenBloc.fetchhomeScreenDetails(
                          "https://swapi.dev/api/species/?page=1");
                    },
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      padding: EdgeInsetsDirectional.only(
                        start: MediaQuery.of(context).size.width * 0.01,
                        end: MediaQuery.of(context).size.width * 0.01,
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Container(
                              height: size.height * .8,
                              child: StreamBuilder(
                                stream: homeScreenBloc.homeScreenDetails,
                                builder: (BuildContext context,
                                    AsyncSnapshot<HomeScreenDetailsModel>
                                        snapshot) {
                                  if (snapshot.hasData == true) {
                                    homeScreenDetailsModel = snapshot.data;
                                    if (snapshot.data.results.length > 0) {
                                      return ListView.builder(
                                        // physics:
                                        //     const AlwaysScrollableScrollPhysics(),
                                        controller: _scrollController,
                                        itemCount: snapshot.data.results.length,
                                        itemBuilder:
                                            (BuildContext context, int index) {
                                          final Results _card =
                                              snapshot.data.results[index];

                                          return Container(
                                              // child: Text("hbdsjbdsj"),
                                              child: Card(
                                                  child: new Column(children: <
                                                      Widget>[
                                            Padding(
                                                padding:
                                                    new EdgeInsets.all(7.0),
                                                child: Column(
                                                  children: <Widget>[
                                                    Padding(
                                                      padding:
                                                          new EdgeInsets.all(
                                                              7.0),
                                                      child: Text(
                                                        _card.name,
                                                        style: new TextStyle(
                                                            fontSize: 18.0),
                                                      ),
                                                    ),
                                                    Padding(
                                                      padding:
                                                          new EdgeInsets.all(
                                                              7.0),
                                                      child: new Text(
                                                          _card.classification,
                                                          style: new TextStyle(
                                                              fontSize: 18.0)),
                                                    ),
                                                    Padding(
                                                      padding:
                                                          new EdgeInsets.all(
                                                              7.0),
                                                      child: new Text(
                                                          _card.designation,
                                                          style: new TextStyle(
                                                              fontSize: 18.0)),
                                                    )
                                                  ],
                                                ))
                                          ])));
                                        },
                                      );
                                    } else {
                                      return Center(
                                          child: noDataWidget(context, size,
                                              "No Data Found", ""));
                                    }
                                  } else {
                                    return Container();
                                  }
                                },
                              ))
                        ],
                      ),
                    ),
                  ),
                  StreamBuilder(
                      stream: commonBloc.getIsLoading,
                      initialData: commonBloc.isLoading,
                      builder: (context, snapshot) {
                        return Positioned(
                          child: commonBloc.isLoading == true
                              ? loadingWidget(context, "", Colors.grey)
                              : Container(),
                        );
                      }),
                ],
              ),
            ),
          ),
        ));
  }
}
