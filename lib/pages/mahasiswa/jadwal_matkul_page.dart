import 'package:flutter/material.dart';
import 'package:project_uas_ppb/common/constants/images.dart';
import 'package:project_uas_ppb/common/extensions/date_time_ext.dart';
import 'package:project_uas_ppb/data/datasources/schedule_remote_datasource.dart';
import 'package:project_uas_ppb/data/models/response/schedule_response_model.dart';

import 'models/course_schedule_model.dart';
import 'widgets/course_schedule_tile.dart';
import 'widgets/course_with_image.dart';

class JadwalMatkulPage extends StatefulWidget {
  const JadwalMatkulPage({Key? key}) : super(key: key);

  @override
  State<JadwalMatkulPage> createState() => _JadwalMatkulPageState();
}

class _JadwalMatkulPageState extends State<JadwalMatkulPage> {
  late Future<List<ScheduleResponseModel>> _schedulesFuture;

  @override
  void initState() {
    super.initState();
    _schedulesFuture = ScheduleRemoteDatasource().getSchedules();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Kembali'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Padding(
              padding: EdgeInsets.all(24.0),
              child: Text(
                "Jadwal Mata Kuliah",
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 12.0, vertical: 20.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CourseWithImage(
                    name: 'Basis Data',
                    imagePath: Images.basisData,
                  ),
                  CourseWithImage(
                    name: 'Algoritma',
                    imagePath: Images.algoritma,
                  ),
                  CourseWithImage(
                    name: 'RPL',
                    imagePath: Images.rpl,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 12.0),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12.0),
              child: Text(
                DateTime.now().toFormattedDateWithDay(),
                style: const TextStyle(
                  fontSize: 12,
                ),
              ),
            ),
            const SizedBox(height: 18.0),
            Expanded(
              child: FutureBuilder<List<ScheduleResponseModel>>(
                future: _schedulesFuture,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  } else if (snapshot.hasError || snapshot.data == null) {
                    return const Center(
                      child: Text('Failed to load schedules'),
                    );
                  } else {
                    List<ScheduleResponseModel> data = snapshot.data!;

                    return ListView.builder(
                      itemCount: data.length,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 12.0, vertical: 8.0),
                          child: CourseScheduleTile(
                            data: CourseScheduleModel(
                              dateStart: DateTime.now(),
                              longTimeTeaching: 90,
                              course: data[index].course,
                              lecturer: data[index].lecturer,
                              description: data[index].description,
                              startTime: data[index].startTime,
                              endTime: data[index].endTime,
                            ),
                          ),
                        );
                      },
                    );
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
