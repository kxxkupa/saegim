// 프로젝트 명 : 새김
// 파일명 : weather_service.dart
// 파일 경로 : /lib/common/service/
// 분류 : 날씨 서비스

import 'dart:convert';
import 'package:http/http.dart' as http;

class WeatherService {
  // 서비스 키
  final String serviceKey = '8d747bcfdb5dbd66132398c6d5ff2cc83fc3028db6887b76cd0bd31dac1cbbe0';
  final String baseUrl = 'https://apis.data.go.kr/1360000/VilageFcstInfoService_2.0/getUltraSrtNcst';

  Map<String, String> getBaseTimeAndDate() {
    final now = DateTime.now();

    // 현재 시간을 30분 미만일 경우 한 시간 전으로 계산
    final calculatedTime = now.minute < 30
        ? now.subtract(const Duration(hours: 1))
        : now;

    // 날짜 형식 (yyyyMMdd)
    final year = calculatedTime.year.toString();
    final month = calculatedTime.month.toString().padLeft(2, '0');
    final day = calculatedTime.day.toString().padLeft(2, '0');
    final baseDate = '$year$month$day';

    // 시간 형식 (HH00)
    final hour = calculatedTime.hour.toString().padLeft(2, '0');
    final baseTime = '${hour}00';

    return {'base_date': baseDate, 'base_time': baseTime};
  }

  Future<Map<String, dynamic>> fetchWeatherData() async {
    final timeDate = getBaseTimeAndDate();
    final baseDate = timeDate['base_date'];
    final baseTime = timeDate['base_time'];

    // API 요청에 필요한 URI 생성 (base_date & base_time은 현재 시간 기준으로 설정, 위치는 고정)
    final uri = Uri.parse(
      '$baseUrl?serviceKey=$serviceKey&pageNo=1&numOfRows=10&dataType=JSON&base_date=$baseDate&base_time=$baseTime&nx=67&ny=100'
    );

    // 위에서 생성한 uri에 Http Get 요청 보내기
    final response = await http.get(uri);

    // 성공
    if (response.statusCode == 200) {
      // JSON 문자열을 Map으로 변환
      final Map<String, dynamic> jsonResponse = json.decode(response.body);

      // items 배열 전체 가져오기
      final items = jsonResponse['response']['body']['items']['item'] as List;
      
      // 필요한 데이터 값을 담을 Map 생성
      // T1H (기온), REH (습도)
      Map<String, dynamic> weatherData = {};

      // items 배열을 순회하며 필요한 데이터를 찾기
      for (var item in items) {
        if (item['category'] == 'T1H') {
          weatherData['T1H'] = item['obsrValue'];
        }
        
        if (item['category'] == 'REH') {
          weatherData['REH'] = item['obsrValue'];
        }
      }

      return weatherData;
    } else { 
      throw Exception('날씨 데이터를 불러오지 못했습니다. statusCode : ${response.statusCode}');
    }
  }
}