import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project_uas_ppb/bloc/logout/logout_bloc.dart';
import 'package:project_uas_ppb/data/datasources/auth_local_datasource.dart';
import 'package:project_uas_ppb/pages/auth/auth_page.dart';
import 'package:project_uas_ppb/pages/mahasiswa/jadwal_matkul_page.dart';

import '../../common/components/menu_card.dart';
import '../../common/components/search_input.dart';
import '../../common/constants/colors.dart';
import '../../common/constants/images.dart';
import 'absensi_page.dart';
import 'khs_page.dart';
import 'nilaimk_page.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  @override
  Widget build(BuildContext context) {
    final searchController = TextEditingController();

    return ListView(
      padding: const EdgeInsets.all(20.0),
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              "Perkuliahan",
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.w700,
                color: ColorName.primary,
              ),
            ),
            Row(
              children: [
                IconButton(
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) {
                      return const AbsensiPage();
                    }));
                  },
                  icon: const Icon(
                    Icons.qr_code_scanner,
                    color: ColorName.primary,
                  ),
                ),
                IconButton(
                  onPressed: () {},
                  icon: const Icon(
                    Icons.notifications,
                    color: ColorName.primary,
                  ),
                ),
                const SizedBox(height: 30.0),
                Center(
                  child: BlocProvider(
                    create: (context) => LogoutBloc(),
                    child: BlocConsumer<LogoutBloc, LogoutState>(
                      listener: (context, state) {
                        state.maybeWhen(
                            orElse: () {},
                            loaded: () {
                              AuthLocalDatasource().removeAuthData();
                              Navigator.pushReplacement(context,
                                  MaterialPageRoute(builder: (context) {
                                return const AuthPage();
                              }));
                            },
                            error: () {
                              ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                      content: Text('Logout Error')));
                            });
                      },
                      builder: (context, state) {
                        return state.maybeWhen(orElse: () {
                          return ElevatedButton(
                            onPressed: () {
                              context
                                  .read<LogoutBloc>()
                                  .add(const LogoutEvent.logout());
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: ColorName.white,
                            ),
                            child: const Padding(
                              padding: EdgeInsets.symmetric(horizontal: 8.0),
                              child: Text('Logout'),
                            ),
                          );
                        }, loaded: () {
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        });
                      },
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
        const SizedBox(height: 10.0),
        SearchInput(
          controller: searchController,
        ),
        const SizedBox(height: 40.0),
        MenuCard(
          label: 'Kartu Hasil\nStudi',
          backgroundColor: const Color(0xff686BFF),
          onPressed: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) {
              return const KhsPage();
            }));
          },
          imagePath: Images.khs,
        ),
        const SizedBox(height: 40.0),
        MenuCard(
          label: 'Nilai\nMata Kuliah',
          backgroundColor: const Color.fromARGB(255, 35, 149, 255),
          onPressed: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) {
              return const NilaiMkPage();
            }));
          },
          imagePath: Images.nMatkul,
        ),
        const SizedBox(height: 40.0),
        MenuCard(
          label: 'Jadwal\nMata Kuliah',
          backgroundColor: const Color.fromARGB(255, 19, 219, 193),
          onPressed: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) {
              return const JadwalMatkulPage();
            }));
          },
          imagePath: Images.jadwal,
        ),
      ],
    );
  }
}
