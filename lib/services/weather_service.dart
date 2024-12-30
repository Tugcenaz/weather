import 'package:dio/dio.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';

import '../models/weather_model.dart';

class WeatherService {
  Future<String> _getLocation() async {
    //konum servisi açık mı değil mi
    final bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Konum servisi aktif değil');
    }
    //kullanıcının konum izni verip vermediğini kontrol ettik
    LocationPermission permission = await Geolocator.checkPermission();
    //konum izni yok
    if (permission == LocationPermission.denied) {
      //konum izni istedik
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error("Konum izni vermelisiniz");
      }
    }

    //Kullanıcının pozisyonunu aldık
    Position position = await Geolocator.getCurrentPosition(
        locationSettings: const LocationSettings(
            accuracy: LocationAccuracy.high)); //kesin konumunu veriyor
//kullanıcının pozisyonundan yerleşim alanını bulduk
    List<Placemark> placemarks =
        await placemarkFromCoordinates(position.latitude, position.longitude);
    print(placemarks);
    //yerleşim alanından sadece şehri aldık
    final String? cityName = placemarks[0].administrativeArea;
    if (cityName == null) Future.error("Bir sorun oluştu");
    return cityName!;
  }

  Future<List<WeatherModel>> getWeatherData() async {
    final String city = await _getLocation();
    final String url =
        'https://api.collectapi.com/weather/getWeather?data.lang=tr&data.city=$city';
    const Map<String, dynamic> headers = {
      "authorization": "apikey 3kuuHz3xGf77pJseglJjTt:5F1zIrLiN0ni8Br8VXw03X",
      "content-type": "application/json"
    };

    final Dio dio = Dio();
    final response = await dio.get(url, options: Options(headers: headers));
    if (response.statusCode != 200) {
      return Future.error("Bir sorun oluştu");
    }
    final List dataList = response.data["result"];

    final List<WeatherModel> weatherList =
        dataList.map((toElement) => WeatherModel.fromJson(toElement)).toList();
    return weatherList;
  }
}
