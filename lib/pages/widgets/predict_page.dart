import 'dart:io';

import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:hydroponic/pages/common/colors.dart';
import 'package:hydroponic/pages/common/styles.dart';
import 'package:image_picker/image_picker.dart';

class PredictPage extends StatefulWidget {
  const PredictPage({super.key});

  @override
  State<PredictPage> createState() => _PredictPageState();
}

class _PredictPageState extends State<PredictPage> {
  bool isUploadActive = true; // Menyimpan status aktif untuk Upload dan History
  final ImagePicker _picker = ImagePicker();
  XFile? _imageFile; // Menyimpan gambar yang dipilih

  Future<void> _pickImage() async {
    // Memanggil kamera untuk mengambil gambar
    try {
      final XFile? pickedFile = await _picker.pickImage(
        source: ImageSource.camera, // Buka kamera
        maxWidth: 1800,
        maxHeight: 1800,
      );
      if (pickedFile != null) {
        setState(() {
          _imageFile = pickedFile; // Simpan gambar yang diambil
        });
      }
    } catch (e) {
      print('Gagal mengambil gambar: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 40.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Predict',
                  style: AppStyle.appTextStyles.title3!.copyWith(
                    color: BaseColors.neutral950,
                  ),
                ),
                Text(
                  'Prediction melon health',
                  style: AppStyle.appTextStyles.smallNormalReguler!.copyWith(
                    color: BaseColors.neutral400,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            Container(
              width: double.infinity,
              height: 50,
              decoration: BoxDecoration(
                color: BaseColors.neutral100, // Warna dasar gelap di belakang
                borderRadius: const BorderRadius.all(Radius.circular(12)),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        setState(() {
                          isUploadActive = true; // Aktifkan Upload
                        });
                      },
                      child: Container(
                        margin: const EdgeInsets.all(
                            4.0), // Margin untuk memberi jarak di sekitar box
                        decoration: BoxDecoration(
                          color: isUploadActive
                              ? Colors.white // Warna putih saat aktif
                              : BaseColors
                              .neutral100, // Warna gelap saat tidak aktif
                          borderRadius:
                          const BorderRadius.all(Radius.circular(10)),
                        ),
                        child: Center(
                          child: Text(
                            'Upload',
                            style: AppStyle.appTextStyles.largeNoneMedium!
                                .copyWith(
                              color: isUploadActive
                                  ? BaseColors
                                  .neutral950 // Teks hitam saat aktif
                                  : BaseColors
                                  .neutral400, // Teks lebih terang saat tidak aktif
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        setState(() {
                          isUploadActive = false; // Aktifkan History
                        });
                      },
                      child: Container(
                        margin: const EdgeInsets.all(
                            4.0), // Margin untuk memberi jarak di sekitar box
                        decoration: BoxDecoration(
                          color: !isUploadActive
                              ? Colors.white // Warna putih saat aktif
                              : BaseColors
                              .neutral100, // Warna gelap saat tidak aktif
                          borderRadius:
                          const BorderRadius.all(Radius.circular(10)),
                        ),
                        child: Center(
                          child: Text(
                            'History',
                            style: AppStyle.appTextStyles.largeNoneMedium!
                                .copyWith(
                              color: !isUploadActive
                                  ? BaseColors
                                  .neutral950 // Teks hitam saat aktif
                                  : BaseColors
                                  .neutral400, // Teks lebih terang saat tidak aktif
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Media Upload',
                  style: AppStyle.appTextStyles.largeNoneMedium!.copyWith(
                    color: BaseColors.neutral900,
                  ),
                ),
                Text(
                  'Upload image to predict melon health',
                  style: AppStyle.appTextStyles.smallNormalReguler!.copyWith(
                    color: BaseColors.neutral400,
                  ),
                ),
                const SizedBox(height: 10),
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(5),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      DottedBorder(
                        color: BaseColors.success500,
                        strokeWidth: 2,
                        borderType: BorderType.RRect,
                        radius: const Radius.circular(12),
                        dashPattern: const [8, 4],
                        child: Container(
                          width: double.infinity,
                          height: 180,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              // Bagian untuk icon gambar
                              if (_imageFile == null)
                                Image.asset(
                                  'assets/images/icons/upload_icon.png',
                                  width: 50,
                                  height: 50,
                                )
                              else
                                Image.file(
                                  File(_imageFile!.path),
                                  width: 50,
                                  height: 50,
                                ),
                              const SizedBox(
                                  height: 10), // Spasi antara icon dan tombol

                              // Tombol Upload Image dengan border hijau
                              GestureDetector(
                                onTap:
                                _pickImage, // Memanggil fungsi untuk membuka kamera
                                child: Container(
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                        color: BaseColors
                                            .success500), // Border hijau
                                    borderRadius: BorderRadius.circular(
                                        8), // Sudut border melengkung
                                  ),
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 16, vertical: 8),
                                  child: Text(
                                    'Upload Image',
                                    style: TextStyle(
                                      color: BaseColors
                                          .success500, // Warna teks hijau
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(
                                  height:
                                  10), // Spasi antara tombol dan teks info

                              // Teks deskripsi ukuran maksimal file
                              const Text(
                                'Max 10 MB files are allowed',
                                style: TextStyle(
                                  fontSize: 12,
                                  color: Colors.grey, // Warna teks abu-abu
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(
                          height: 10), // Jarak antara box dengan teks di bawah
                      const Text(
                        'Only support .jpg, .jpeg, and .png files',
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.grey, // Warna teks abu-abu
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 50),
                Container(
                  width: double.infinity,
                  padding:
                  const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      // Tombol Predict dengan border hijau
                      GestureDetector(
                        onTap: () {
                          // Fungsi untuk memprediksi gambar
                          print('Predict');
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            color: BaseColors.success500, // Warna hijau
                            borderRadius: BorderRadius.circular(
                                8), // Sudut border melengkung
                          ),
                          padding: const EdgeInsets.symmetric(
                              horizontal: 16, vertical: 8),
                          child: const Text(
                            'Predict',
                            style: TextStyle(
                              color: Colors.white, // Warna teks putih
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
