import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:habit_tracker/core/API/api.dart';
import 'package:habit_tracker/data/Habits/DataSources/remoteServerDataSource.dart';
import 'package:mocktail/mocktail.dart';

import 'helpers/mock_dio.dart';

void main() {
  //Setup and Arrange the Data ->Given :
  late RemoteServerDataSource dataSource;
  late MockDio mockDio;
  setUp(() {
    mockDio = MockDio();
    dataSource = RemoteServerDataSource(dio: mockDio);
  });
  group('Remote Data Server Source', () {
    group('The Get Method', () {
      test('should return Habits when Dio returns 200', () async {
        // Arrange: Script the puppet
        when(() => mockDio.get('habits')).thenAnswer(
          (_) async => Response(
            data: [
              {'id': 1, 'name': 'Exercise'},
            ], // Your "Fake" JSON
            statusCode: 200,
            requestOptions: RequestOptions(path: 'habits'),
          ),
        );

        // Act
        final result = await dataSource.getHabits();

        // Assert
        expect(result.first.habitName, 'Exercise');
      });

      test(
        'Given : 404 when its given 404 as a status code then it returns a list of Exception',
        () async{
          //Arrange :
          when(() => mockDio.get('habits')).thenAnswer(
            (_) async => Response(
              data: 'Not Found',
              statusCode: 404,
              requestOptions: RequestOptions(path: 'habits'),
            ),
          );
          // Act & Assert
          // We expect your 'throw DioException' logic to trigger!
          expect(() => dataSource.getHabits(), throwsA(isA<DioException>()));
        },
      );
    });
  });
}
