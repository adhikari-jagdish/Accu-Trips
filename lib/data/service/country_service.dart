import 'package:accu_trips/data/service/dio_service.dart';
import 'package:dio/dio.dart';

class CountryService {
  final DioService _dio = DioService();

  Future<Response> getCountries({int page = 1, int limit = 50}) => _dio.dio.get('/getAllCountries', queryParameters: {'page': page, 'limit': limit});

  Future<Response> createCountry(Map<String, dynamic> data) => _dio.dio.post('/addCountry', data: data);

  Future<Response> updateCountry(String id, Map<String, dynamic> data) => _dio.dio.put('/updateCountry/$id', data: data);

  Future<Response> deleteCountry(String id) => _dio.dio.delete('/deleteCountry/$id');
}
