// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';

import 'subinformasi/DokumenPendukung.dart';
import 'subinformasi/manualbook.dart';
import 'subinformasi/syaratdaftar.dart';
// import './form_pendaftaran.dart';

class InformasiPage extends StatefulWidget {
  const InformasiPage({super.key});

  @override
  _InformasiPageState createState() => _InformasiPageState();
}

class _InformasiPageState extends State<InformasiPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        physics: const AlwaysScrollableScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const SizedBox(height: 10),
            Container(
              width: double.infinity,
              height: 281,
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 13),
              decoration: ShapeDecoration(
                color: const Color(0xFFFFD600),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(0),
                ),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    width: 177,
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
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Informasi Pendaftaran Yudisium',
                        style: TextStyle(
                          fontSize: 30.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            buildInfoButton('Manual Book', const ManualBookContent()),
            buildInfoButton(
                'Dokumen Pendukung', const DokumenPendukungContent()),
            buildInfoButton(
                'Syarat Pendaftaran', const SyaratPendaftaranContent()),
            const SizedBox(height: 400),
          ],
        ),
      ),
    );
  }

  Widget buildInfoButton(String title, dynamic content) {
    return ElevatedButton(
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => InfoPage(title, content)),
        );
      },
      child: Container(
        padding: const EdgeInsets.all(8),
        child: Text(
          title,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}

class InfoPage extends StatelessWidget {
  final String title;
  final dynamic content;

  const InfoPage(this.title, this.content, {super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: SingleChildScrollView(
          child: content is Widget ? content : Text(content),
        ),
      ),
    );
  }
}
