// 프로젝트 명 : 새김
// 파일명 : tab_list_schedule.dart
// 파일 경로 : /lib/common/widgets/
// 분류 : 시작 화면 - 탭 목록 (일정)

import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:saegim/schedule/schedule_list.dart';
import 'package:saegim/common/const/public_style.dart';
import 'package:saegim/common/service/schedule_service.dart';
import 'package:saegim/database/saegim_database.dart';

class TabListSchedule extends StatelessWidget {
  const TabListSchedule({super.key});

  @override
  Widget build(BuildContext context) {
    DateTime selectedDate = DateTime(
      DateTime.now().year,
      DateTime.now().month,
      DateTime.now().day,
    );

    return StreamBuilder<List<ScheduleData>>(
      stream: GetIt.I<ScheduleService>().watchSchedules(selectedDate),
      builder: (context, snapshot) {
        
        // 1. 오류 발생 시 오류 메시지 표시
        if (snapshot.hasError) {
          return Center(child: Text('오류가 발생했습니다: ${snapshot.error}'));
        }

        final schedules = snapshot.data ?? [];
                  
        return Stack(
          children: [
            Column(
              children: [
                // 2. 데이터 유무에 따라 다른 위젯 표시
                Expanded(
                  child: schedules.isEmpty
                      ? Center(
                          child: Text(
                            '등록된 일정이 없습니다.',
                            style: textSize16.copyWith(fontWeight: FontWeight.w500),
                          ),
                        )
                      : Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: ListView.builder(
                            physics: schedules.length > 1 ? const BouncingScrollPhysics() : const NeverScrollableScrollPhysics(),
                            itemCount: schedules.length,
                            itemBuilder: (context, index) {
                              final schedule = schedules[index];
    
                              return _buildScheduleSection(schedule);
                            },
                          ),
                        ),
                ),
              ],
            ),
          ],
        );
      }
    );
  }

  // 일정 목록
  Widget _buildScheduleSection(ScheduleData schedule) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 5.0),
      child: ScheduleList(
        schedule: schedule,
      ),
    );
  }
}