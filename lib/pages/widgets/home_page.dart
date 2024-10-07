import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:hydroponic/pages/common/colors.dart';
import 'package:hydroponic/pages/common/styles.dart';
import 'package:hydroponic/pages/component/custom_appbar.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  // List data untuk setiap item di dalam grid
  final List<Map<String, String>> gridItems = [
    {
      'title': 'Humidity',
      'description': '63.0%',
      'image': 'assets/images/humidity.png',
    },
    {
      'title': 'pH',
      'description': '7.4',
      'image': 'assets/images/pH.png',
    },
    {
      'title': 'TDS 1',
      'description': '300.0ppm',
      'image': 'assets/images/tds1.png',
    },
    {
      'title': 'TDS 2',
      'description': '100.0ppm',
      'image': 'assets/images/tds2.png',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(),
      body: SingleChildScrollView(
        // Membungkus dengan SingleChildScrollView untuk scrolling
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Health Overview',
              style: AppStyle.appTextStyles.title3!.copyWith(
                color: BaseColors.neutral950,
              ),
            ),
            Text(
              'Your daily health overview',
              style: AppStyle.appTextStyles.smallNormalReguler!.copyWith(
                color: BaseColors.neutral400,
              ),
            ),
            const SizedBox(height: 16),
            Stack(
              children: [
                Container(
                  width: double.infinity,
                  height: 150,
                  decoration: BoxDecoration(
                    color: BaseColors.success600,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 16.0, horizontal: 20.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'NORMAL',
                          style: AppStyle.appTextStyles.smallNormalReguler!
                              .copyWith(
                            color: BaseColors.neutral50,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          '26°C',
                          style: AppStyle.appTextStyles.title4!.copyWith(
                            color: BaseColors.neutral50,
                          ),
                        ),
                        Text(
                          'Temperature warm',
                          style: AppStyle.appTextStyles.smallNormalReguler!
                              .copyWith(
                            color: BaseColors.neutral50,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Positioned(
                  right: 0,
                  top: 20,
                  child: Image.asset(
                    'assets/images/Temperature.png',
                    width: 100,
                    height: 100,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            Container(
              height: 50,
              decoration: BoxDecoration(
                color: BaseColors.neutral200,
                borderRadius: BorderRadius.circular(16),
              ),
              child: Center(
                child: AnimatedTextKit(
                  animatedTexts: [
                    FadeAnimatedText(
                      'Last Updated: 22-08-2024 08:51:15',
                      textStyle:
                          AppStyle.appTextStyles.largeNormalBold!.copyWith(
                        color: BaseColors.neutral500,
                      ),
                      duration: const Duration(seconds: 2),
                    ),
                  ],
                  isRepeatingAnimation: true,
                  repeatForever: true,
                ),
              ),
            ),
            const SizedBox(height: 15),
            Container(
              padding: const EdgeInsets.all(
                  10), // Menambahkan padding untuk ruang di dalam kontainer
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  // Row pertama untuk gambar dan teks Pump
                  Row(
                    children: [
                      Image.asset(
                        'assets/images/pump.png',
                        width: 60,
                        height: 80,
                      ),
                      const SizedBox(
                          width: 20), // Jarak antara gambar dan teks Pump
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Image.asset(
                                'assets/images/waterpump.png',
                                width: 20,
                                height: 20,
                              ),
                              const SizedBox(
                                  width: 10), // Jarak antara ikon dan teks
                              Text(
                                'Water Pump',
                                style: AppStyle.appTextStyles.largeNoneMedium!
                                    .copyWith(
                                  color: BaseColors.neutral400,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(
                              height: 5), // Jarak antara teks Pump dan Status
                          Row(
                            children: [
                              Icon(
                                Icons
                                    .power, // Menggunakan ikon dari Flutter material
                                size: 20,
                                color: BaseColors.neutral900, // Warna ikon
                              ),
                              const SizedBox(
                                  width: 10), // Jarak antara ikon dan teks
                              Text(
                                'Status: ON',
                                style: AppStyle
                                    .appTextStyles.smallNormalReguler!
                                    .copyWith(
                                  color: BaseColors.neutral900,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            Container(
              padding: const EdgeInsets.only(
                  bottom: 20), // Tambahkan padding bawah untuk jarak ekstra
              child: GridView.builder(
                shrinkWrap: true,
                physics:
                    const NeverScrollableScrollPhysics(), // Mencegah scroll jika berada di dalam scroll view lainnya
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2, // Jumlah kolom menjadi 2
                  crossAxisSpacing: 20, // Jarak antar kolom
                  mainAxisSpacing: 25, // Jarak antar baris
                  mainAxisExtent: 120, // Tinggi setiap kotak grid
                ),
                itemCount: gridItems.length, // Total sesuai jumlah item
                itemBuilder: (context, index) {
                  final item = gridItems[index]; // Mendapatkan item dari list
                  return Container(
                    padding: EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: BaseColors.neutral100,
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          spreadRadius: 2,
                          blurRadius: 5,
                          offset:
                              const Offset(0, 3), // Mengatur posisi bayangan
                        ),
                      ],
                    ),
                    child: Stack(
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal:
                                  8.0), // Menambahkan padding untuk mengatur jarak
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                item[
                                    'title']!, // Menggunakan deskripsi dari data item
                                style: TextStyle(
                                  color: BaseColors.neutral600,
                                  fontSize: 14,
                                ),
                              ),
                              const SizedBox(height: 5),
                              Text(
                                item[
                                    'description']!, // Menggunakan judul dari data item
                                style: TextStyle(
                                  color: BaseColors.neutral900,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Positioned(
                          top: 14,
                          right: 14,
                          child: Image.asset(
                            item['image']!, // Menggunakan gambar dari data item
                            width: 30,
                            height: 30,
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
            const SizedBox(
                height:
                    30), // Memberikan jarak tambahan di bagian bawah tampilan
          ],
        ),
      ),
    );
  }
}
