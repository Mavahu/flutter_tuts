import 'dart:convert' as convert;

import 'package:flutter/material.dart';
import 'package:weather_app/utils/utils.dart' as util;
import 'package:http/http.dart' as http;

import 'change_city.dart';

class Weather extends StatefulWidget {
  @override
  _WeatherState createState() => _WeatherState();
}

class _WeatherState extends State<Weather> {
  String _city = "Hamburg";

  Future _goToNextScreen(BuildContext context) async {
    Map results = await Navigator.of(context).push(
        MaterialPageRoute(builder: (BuildContext context) => ChangeCity()));
    if (results != null && results.containsKey("info")) {
      _city = results["info"];
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Weather"),
        backgroundColor: Colors.redAccent,
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.menu),
            onPressed: () {
              _goToNextScreen(context);
            },
          ),
        ],
      ),
      body: Stack(
        children: <Widget>[
          Center(
            child: Image.asset(
              "assets/rain_screen.jpg",
              width: 490.0,
              height: 1200.0,
              fit: BoxFit.fill,
            ),
          ),
          Container(
            alignment: Alignment.topRight,
            margin: const EdgeInsets.fromLTRB(0.0, 14.5, 25.5, 0),
            child: Text(
              _city,
              style: TextStyle(
                color: Colors.white,
                fontSize: 22.9,
                fontStyle: FontStyle.italic,
              ),
            ),
          ),
          /*Container(
            alignment: Alignment.center,
            child: new Image.asset("assets/rain.png"),
          ),*/
          updateTempWidget(_city),
        ],
      ),
    );
  }

  Future<Map> getWeather(String appId, String city) async {
    String apiUrl =
        "http://api.openweathermap.org/data/2.5/weather?q=$city&appid=${appId}&units=metric";
    print(apiUrl);
    http.Response response = await http.get(apiUrl);

    return convert.jsonDecode(response.body);
  }

  Widget updateTempWidget(String city) {
    return new FutureBuilder(
        future: getWeather(util.appId, city == null ? util.defaultCity : city),
        builder: (BuildContext context, AsyncSnapshot<Map> snapshot) {
          if (snapshot.hasData) {
            Map content = snapshot.data;
            return Container(
              margin: const EdgeInsets.fromLTRB(30.0, 360.0, 0.0, 0.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  ListTile(
                    title: Text(
                      "${content["main"]["temp"].toString()}°C",
                      style: _getTextStyle(),
                    ),
                    subtitle: ListTile(
                        title: Text(
                      "Humidity: ${content["main"]["humidity"].toString()}\n"
                      "Min: ${content["main"]["temp_min"].toString()}°C\n"
                      "Max :${content["main"]["temp_max"].toString()}°C",
                      style: _extraData(),
                    )),
                  )
                ],
              ),
            );
          } else
            return Container();
        });
  }

  TextStyle _getTextStyle() {
    return TextStyle(
      color: Colors.white,
      fontStyle: FontStyle.normal,
      fontWeight: FontWeight.w500,
      fontSize: 49.9,
    );
  }

  TextStyle _extraData() {
    return TextStyle(
      color: Colors.white70,
      fontStyle: FontStyle.normal,
      fontSize: 17.0,
    );
  }
}
