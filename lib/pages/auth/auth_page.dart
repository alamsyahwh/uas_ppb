import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project_uas_ppb/bloc/login/login_bloc.dart';

import '../../common/components/buttons.dart';
import '../../common/constants/colors.dart';
import '../../common/constants/images.dart';
// import '../dosen/dosen_page.dart';
// import '../mahasiswa/mahasiswa_page.dart';
import 'widgets/login_bottom_sheet.dart';

class AuthPage extends StatefulWidget {
  const AuthPage({super.key});

  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              Images.logo,
              width: 115.0,
            ),
            const SizedBox(height: 8.0),
            const Text(
              "SIAKAD LPKIA",
              style: TextStyle(
                fontSize: 34,
                fontWeight: FontWeight.w800,
                color: Color.fromRGBO(41, 22, 111, 1),
              ),
            ),
            const SizedBox(height: 8.0),
            const Text(
              "KELOMPOK 4",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w700,
                color: ColorName.grey,
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 24.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Button.filled(
              onPressed: () {
                showModalBottomSheet(
                  context: context,
                  useSafeArea: true,
                  isScrollControlled: true,
                  builder: (BuildContext context) {
                    return BlocProvider(
                      create: (context) => LoginBloc(),
                      child: const LoginBottomSheet(),
                    );
                  },
                );
              },
              label: 'Login',
            ),
            const SizedBox(height: 32.0),
            const Text.rich(
              TextSpan(
                text: "Dengan memilih salah satu, Anda menyetujuinya ",
                children: [
                  TextSpan(
                    text: 'Ketentuan Layanan & Kebijakan Privasi',
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      color: ColorName.primary,
                    ),
                  ),
                ],
              ),
              style: TextStyle(
                fontSize: 12,
                color: ColorName.grey,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
