import 'dart:async';
import 'package:taxi_flutter_app/src/model/place_item_res.dart';
import 'package:taxi_flutter_app/src/model/step_res.dart';
import 'package:taxi_flutter_app/src/model/trip_info_res.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class PlaceService {
  static Future<List<PlaceItemRes>> searchPlace(String keyword) async {
    String proxyurl = "https://cors-anywhere.herokuapp.com/";

    String url =
        "https://maps.googleapis.com/maps/api/place/textsearch/json?key=" +
            "AIzaSyBgyn1BcpdOp1dr2Gi8KgLHVnqzF_Z8Qbc" +
            "&language=vi&region=VN&query=" +
            Uri.encodeQueryComponent(keyword);

    var res = await http.get(Uri.parse(proxyurl + url));
    if (res.statusCode == 200) {
      print(res.body);
      return PlaceItemRes.fromJson(json.decode(res.body));
    } else {
      return [];
    }
  }

  static Future<dynamic> getStep(
      double lat, double lng, double tolat, double tolng) async {
    String str_origin = "origin=" + lat.toString() + "," + lng.toString();
    // Destination of route
    String str_dest =
        "destination=" + tolat.toString() + "," + tolng.toString();
    // Sensor enabled
    String sensor = "sensor=false";
    String mode = "mode=driving";
    // Building the parameters to the web service
    String parameters = str_origin + "&" + str_dest + "&" + sensor + "&" + mode;
    // Output format
    String output = "json";
    const proxyurl = "https://cors-anywhere.herokuapp.com/";

    // Building the url to the web service
    String url = "https://maps.googleapis.com/maps/api/directions/" +
        output +
        "?" +
        parameters +
        "&key=" +
        "AIzaSyBgyn1BcpdOp1dr2Gi8KgLHVnqzF_Z8Qbc";

    final JsonDecoder _decoder = new JsonDecoder();
    print(url);
    return http.get(Uri.parse(proxyurl + url)).then((http.Response response) {
      String res = response.body;
      int statusCode = response.statusCode;
//      print("API Response: " + res);
      if (statusCode < 200 || statusCode > 400 || json == null) {
        res = "{\"status\":" +
            statusCode.toString() +
            ",\"message\":\"error\",\"response\":" +
            res +
            "}";
        throw new Exception(res);
      }

      TripInfoRes tripInfoRes;
      try {
        var json = _decoder.convert(res);
        int distance = json["routes"][0]["legs"][0]["distance"]["value"];
        List<StepsRes> steps =
            _parseSteps(json["routes"][0]["legs"][0]["steps"]);

        tripInfoRes = new TripInfoRes(distance, steps);
      } catch (e) {
        throw new Exception(res);
      }

      return tripInfoRes;
    });
  }

  static List<StepsRes> _parseSteps(final responseBody) {
    var list = responseBody
        .map<StepsRes>((json) => new StepsRes.fromJson(json))
        .toList();

    return list;
  }
}
