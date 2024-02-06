import 'package:flutter/material.dart';

import '../../../common/components/row_text.dart';
import '../../../common/constants/colors.dart';
import '../models/course_grade_model.dart';

class CourseGradeTile extends StatelessWidget {
  final CourseGradeModel data;
  const CourseGradeTile({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        ListTile(
          contentPadding: const EdgeInsets.all(0),
          leading: ClipRRect(
            borderRadius: const BorderRadius.all(Radius.circular(50.0)),
            child: Image.network(
              'https://awsimages.detik.net.id/community/media/visual/2022/03/21/youtuber-dede-inoen-ngumpet-di-kolong-rel-kereta_169.jpeg?w=600&q=90',
              width: 40,
              height: 40,
              fit: BoxFit.cover,
            ),
          ),
          title: const Text(
            "User Kasep",
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w700,
            ),
          ),
          subtitle: const Text(
            "Mahasiswa",
            style: TextStyle(
              fontSize: 12,
            ),
          ),
        ),
        const SizedBox(height: 16.0),
        const Divider(),
        const SizedBox(height: 16.0),
        RowText(
          label: 'Absensi',
          value: '',
          valueColor: ColorName.primary,
          valueWidget: Container(
            padding:
                const EdgeInsets.symmetric(horizontal: 24.0, vertical: 4.0),
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(12.0)),
              color: ColorName.lightGreen,
            ),
            child: Text(
              data.attendance,
              style: const TextStyle(
                color: ColorName.green,
                fontSize: 12.0,
              ),
            ),
          ),
        ),
        const SizedBox(height: 14.0),
        RowText(
          label: data.course,
          value: data.grade.toString(),
        ),
        const SizedBox(height: 12.0),
        RowText(
          label: 'Keterangan',
          value: data.description,
        ),
        const SizedBox(height: 12.0),
      ],
    );
  }
}
