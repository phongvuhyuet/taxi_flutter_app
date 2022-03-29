import 'dart:async';

import 'package:taxi_flutter_app/src/utils/car_utils.dart';
import 'package:taxi_flutter_app/src/model/car_item.dart';

class CarPickupBloc {
  var _pickupController = new StreamController();
  var carList = CarUtils.getCarList();
  get stream => _pickupController.stream;

  var currentSelected = 0;

  void selectItem(int index) {
    currentSelected = index;
    _pickupController.sink.add(currentSelected);
  }

  bool isSelected(int index) {
    return index == currentSelected;
  }

  CarItem getCurrentCar() {
    if (carList!.length > 0) return carList!.elementAt(currentSelected);
    return new CarItem("no", "adsf", 0);
  }

  void dispose() {
    _pickupController.close();
  }
}
