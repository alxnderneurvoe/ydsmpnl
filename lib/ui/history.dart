// ignore_for_file: library_private_types_in_public_api, avoid_print, unrelated_type_equality_checks

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class HistoryPage extends StatefulWidget {
  const HistoryPage({super.key});

  @override
  _HistoryPageState createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  late User _user;
  late Map<String, dynamic> _userData;

  @override
  void initState() {
    super.initState();
    _getUserData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(
            width: double.infinity,
            height: 281,
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 13),
            color: const Color(0xFFFFD600),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  width: double.infinity,
                  height: 172,
                  child: Center(
                    child: Image.asset(
                      'assets/pnl.png',
                      width: 177,
                      height: 172,
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                const Text(
                  'Riwayat',
                  style: TextStyle(
                    fontSize: 32.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
          Container(
            width: 400,
            padding: const EdgeInsets.symmetric(
              horizontal: 20,
              vertical: 13,
            ),
            decoration: ShapeDecoration(
              color: const Color(0xFFEDEDD9),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            child: Column(
              children: [
                Text(
                  '${_userData['Gelombang']}',
                  style: const TextStyle(
                    fontSize: 24.0,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
                const Divider(),
                const SizedBox(height: 8.0),
                Row(
                  children: [
                    const SizedBox(width: 110, child: Text('Tanggal Daftar')),
                    _userData['tglinput'] != null
                        ? Text(DateFormat(': EEEE, dd - MM - yyyy')
                            .format(_userData['tglinput'].toDate()))
                        : const Text('No date available'),
                  ],
                ),
                Row(
                  children: [
                    const SizedBox(width: 110, child: Text('Jam Daftar')),
                    _userData['tglinput'] != null
                        ? Text(DateFormat(': HH:mm:ss')
                            .format(_userData['tglinput'].toDate()))
                        : const Text('No date available'),
                  ],
                ),
                const SizedBox(height: 8.0),
                const Divider(),
                const SizedBox(height: 8.0),
                Container(
                    child: _userData != true
                        ? const Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text('Status :'),
                              Text(
                                ' SUDAH TERDAFTAR',
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                            ],
                          )
                        : const Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text('Status :'),
                              Text(
                                ' BELUM TERDAFTAR',
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                            ],
                          )),
                const SizedBox(height: 8.0),
              ],
            ),
          ),
          const SizedBox(height: 20),
          Container(
            width: 400,
            padding: const EdgeInsets.symmetric(
              horizontal: 20,
              vertical: 13,
            ),
            decoration: ShapeDecoration(
              color: const Color(0xFFEDEDD9),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            child: Column(
              children: [
                const Text('DATA PENDAFTARAN',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    )),
                const Divider(),
                const SizedBox(height: 8),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(width: 110, child: Text('Judul TGA')),
                    const Text(': '),
                    Expanded(
                      child: Text(
                        '${_userData['Judul TGA']}',
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    const SizedBox(width: 110, child: Text('Dospem 1')),
                    Text(': ${_userData['Dosen Pembimbing 1']}')
                  ],
                ),
                Row(
                  children: [
                    const SizedBox(width: 110, child: Text('Dospem 2')),
                    Text(': ${_userData['Dosen Pembimbing 2']}')
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _getUserData() async {
    try {
      _user = _auth.currentUser!;

      DocumentSnapshot<Map<String, dynamic>> userData = await _firestore
          .collection('Pengguna')
          .doc(_user.uid)
          .collection('Pendaftaran')
          .doc('Data Input')
          .get();

      setState(() {
        _userData = userData.data() ?? {};
      });
    } catch (e) {
      print('Failed to get user data: $e');
    }
  }
}
