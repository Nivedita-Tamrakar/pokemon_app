import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class DioClient {
  Dio _dio = Dio();
  DioClient();
  Future<Response> get(String url) async {
        try{
            return await _dio.get(url);
        }
        catch(e){
              throw Exception(e);
        }
  }
}

final dioProvider = Provider<DioClient>((ref)=> DioClient());