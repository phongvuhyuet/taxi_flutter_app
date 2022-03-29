import 'dart:async';

import 'package:flutter/material.dart';
import 'package:taxi_flutter_app/src/model/place_item_res.dart';
import 'package:taxi_flutter_app/src/model/step_res.dart';
import 'package:taxi_flutter_app/src/model/trip_info_res.dart';
import 'package:taxi_flutter_app/src/repository/place_service.dart';
import 'package:taxi_flutter_app/src/resources/widgets/car_pickup.dart';
import 'package:taxi_flutter_app/src/resources/widgets/home_menu.dart';
import 'package:taxi_flutter_app/src/resources/widgets/ride_picker.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:google_maps_flutter/google_maps_flutter.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var _scaffoldKey = new GlobalKey<ScaffoldState>();
  final Map<String, Marker> _markers = <String, Marker>{};
  final Set<Marker> _listMarkers = new Set();
  final Set<Polyline> _polyline = new Set();
  Completer<GoogleMapController> _controller = Completer();
  var _tripDistance = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      body: Container(
        constraints: BoxConstraints.expand(),
        color: Colors.white,
        child: Stack(
          children: <Widget>[
            GoogleMap(
              zoomGesturesEnabled: true,
              initialCameraPosition: CameraPosition(
                target: LatLng(21.030653, 105.847130),
                zoom: 14.4746,
              ),
              polylines: _polyline,
              markers: _listMarkers,
              onMapCreated: (GoogleMapController controller) {
                _controller.complete(controller);
              },
            ),
            Positioned(
              left: 0,
              top: 0,
              right: 0,
              child: Column(
                mainAxisSize: MainAxisSize.max,
                children: <Widget>[
                  AppBar(
                    backgroundColor: Colors.transparent,
                    elevation: 0.0,
                    title: Text(
                      "Taxi App",
                      style: TextStyle(color: Colors.black),
                    ),
                    leading: TextButton(
                        onPressed: () {
                          print("click menu");
                          _scaffoldKey.currentState?.openDrawer();
                        },
                        child: Image.asset("ic_menu.png")),
                    actions: <Widget>[Image.asset("ic_notify.png")],
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 20, left: 20, right: 20),
                    child: RidePicker(onPlaceSelected),
                  ),
                ],
              ),
            ),
            Positioned(
              left: 20,
              right: 20,
              bottom: 40,
              height: 248,
              child: CarPickup(_tripDistance),
            )
          ],
        ),
      ),
      drawer: Drawer(
        child: HomeMenu(),
      ),
    );
  }

  void onPlaceSelected(PlaceItemRes place, bool fromAddress) {
    var mkId = fromAddress ? "from_address" : "to_address";
    // TODO: old marker remain + move camera wrong bugs
    _addMarker(mkId, place);
    _moveCamera();
    _checkDrawPolyline();
  }

  void _addMarker(String mkId, PlaceItemRes place) async {
    // remove old
    _markers.remove(mkId);

    Marker newMarker = Marker(
        markerId: MarkerId(mkId),
        position: LatLng(place.lat, place.lng),
        infoWindow: InfoWindow(title: place.name, snippet: place.address));
    setState(() {
      _markers[mkId] = newMarker;

      _listMarkers.clear();
      for (var value in _markers.values) {
        _listMarkers.add(value);
      }
    });
  }

  void _moveCamera() async {
    final GoogleMapController controller = await _controller.future;
    if (_markers.values.length > 1) {
      var fromLatLng = _markers["from_address"]?.position;
      var toLatLng = _markers["to_address"]?.position;

      var sLat, sLng, nLat, nLng;
      if (fromLatLng!.latitude <= toLatLng!.latitude) {
        sLat = fromLatLng.latitude;
        nLat = toLatLng.latitude;
      } else {
        sLat = toLatLng.latitude;
        nLat = fromLatLng.latitude;
      }

      if (fromLatLng.longitude <= toLatLng.longitude) {
        sLng = fromLatLng.longitude;
        nLng = toLatLng.longitude;
      } else {
        sLng = toLatLng.longitude;
        nLng = fromLatLng.longitude;
      }

      LatLngBounds bounds = LatLngBounds(
          northeast: LatLng(nLat, nLng), southwest: LatLng(sLat, sLng));
      var cameraUpdate = CameraUpdate.newLatLngBounds(bounds, 5.0);
      controller.moveCamera(cameraUpdate);
    } else {
      controller.animateCamera(
          CameraUpdate.newLatLng(_markers.values.elementAt(0).position));
    }
  }

  void _checkDrawPolyline() {
    if (_markers.length > 1) {
      var from = _markers["from_address"]?.position;
      var to = _markers["to_address"]?.position;
      PlaceService.getStep(
              from!.latitude, from.longitude, to!.latitude, to.longitude)
          .then((vl) {
        TripInfoRes infoRes = vl;

        _tripDistance = infoRes.distance;
        setState(() {});
        List<StepsRes> rs = infoRes.steps;
        List<LatLng> paths = [];
        for (var t in rs) {
          paths
              .add(LatLng(t.startLocation.latitude, t.startLocation.longitude));
          paths.add(LatLng(t.endLocation.latitude, t.endLocation.longitude));
        }

        setState(() {
          _polyline.clear();
          _polyline.add(Polyline(
            polylineId: PolylineId("line"),
            visible: true,
            //latlng is List<LatLng>
            points: paths,
            color: Colors.blue,
          ));
        });
      });
    }
  }
}
