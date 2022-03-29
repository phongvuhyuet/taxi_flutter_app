import 'package:taxi_flutter_app/src/model/car_item.dart';

class CarUtils {
  static List<CarItem> cars = [];

  static List<CarItem> getCarList() {
    if (cars.length != 0) {
      return cars;
    }

    print(cars);
    cars = [];
    cars!.add(CarItem("SEDAN", "ic_pickup_sedan.png", 1.5));
    cars!.add(CarItem("SUV", "ic_pickup_suv.png", 2));
    cars!.add(CarItem("VAN", "ic_pickup_van.png", 2.5));
    cars!.add(CarItem("AUDI", "ic_pickup_hatchback.png", 3));

    return cars;
  }
}
