import 'package:flutter/material.dart';
import 'package:hydroponic/pages/common/colors.dart';
import 'package:hydroponic/pages/common/styles.dart';

class PredictPage extends StatefulWidget {
  const PredictPage({super.key});

  @override
  State<PredictPage> createState() => _PredictPageState();
}

class _PredictPageState extends State<PredictPage> {
  bool isUploadActive = true; // Menyimpan status aktif untuk Upload dan History

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
          ],
        ),
      ),
    );
  }
}
