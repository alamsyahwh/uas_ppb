import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project_uas_ppb/bloc/khs/khs_bloc.dart';
import 'package:project_uas_ppb/data/models/response/auth_response_model.dart';
import 'package:project_uas_ppb/pages/mahasiswa/widgets/get_initials.dart';

import '../../common/components/row_text.dart';
import '../../common/constants/colors.dart';
import '../../data/datasources/auth_local_datasource.dart';

class KhsPage extends StatefulWidget {
  const KhsPage({Key? key}) : super(key: key);

  @override
  State<KhsPage> createState() => _KhsPageState();
}

double ipk = 0;

class _KhsPageState extends State<KhsPage> {
  late Future<User?> _userFuture;

  @override
  void initState() {
    super.initState();
    _userFuture = AuthLocalDatasource().getUser();
    context.read<KhsBloc>().add(const KhsEvent.getKhs());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Kembali"),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          children: [
            const Text(
              "KHS Mahasiswa",
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.w700,
                color: ColorName.primary,
              ),
            ),
            const SizedBox(height: 16.0),
            FutureBuilder<User?>(
              future: _userFuture,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (snapshot.hasError) {
                  return Center(
                    child: Text('Error: ${snapshot.error}'),
                  );
                } else if (!snapshot.hasData || snapshot.data == null) {
                  return const SizedBox(); // Handle jika data tidak tersedia
                } else {
                  User user = snapshot.data!;
                  return buildUserProfile(user);
                }
              },
            ),
            const SizedBox(height: 16.0),
            const Divider(),
            const SizedBox(height: 16.0),
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: RowText(
                label: 'Mata Kuliah :',
                value: 'Nilai :',
                labelColor: ColorName.primary,
                valueColor: ColorName.primary,
              ),
            ),
            const SizedBox(height: 14.0),
            Expanded(
              child: BlocBuilder<KhsBloc, KhsState>(
                builder: (context, state) {
                  return state.maybeWhen(
                    orElse: () {
                      return const SizedBox();
                    },
                    loading: () {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    },
                    loaded: (data) {
                      int total = 0;
                      data.forEach((element) {
                        total += int.parse(element.nilai);
                      });
                      ipk = total / data.length;
                      return Column(
                        children: [
                          Expanded(
                            child: ListView.builder(
                              padding: const EdgeInsets.all(20),
                              shrinkWrap: true,
                              itemCount: data.length,
                              itemBuilder: (context, index) {
                                return Padding(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 6),
                                  child: RowText(
                                    label: data[index].subject.title,
                                    value: data[index].grade.toString(),
                                  ),
                                );
                              },
                            ),
                          ),
                        ],
                      );
                    },
                  );
                },
              ),
            ),
            const SizedBox(height: 20.0),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: RowText(
                label: 'IPK Semester :',
                value: ipk.toStringAsFixed(2),
                labelColor: ColorName.primary,
                valueColor: ColorName.primary,
              ),
            ),
            SizedBox(height: MediaQuery.of(context).size.height / 3),
          ],
        ),
      ),
    );
  }

  ListTile buildUserProfile(User user) {
    return ListTile(
      contentPadding: const EdgeInsets.all(0),
      leading: ClipRRect(
        borderRadius: const BorderRadius.all(Radius.circular(50.0)),
        child: Container(
          width: 72.0,
          height: 72.0,
          color: Colors.blue, // Warna latar belakang avatar
          alignment: Alignment.center,
          child: Text(
            getInitials(user.name),
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 24.0,
            ),
          ),
        ),
      ),
      title: Text(
        user.name,
        style: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w700,
        ),
      ),
      subtitle: Text(
        user.roles,
        style: const TextStyle(
          fontSize: 12,
        ),
      ),
    );
  }
}
