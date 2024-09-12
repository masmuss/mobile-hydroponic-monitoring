import 'package:flutter/material.dart';
import 'package:hydroponic/pages/common/colors.dart';
import 'package:hydroponic/pages/common/styles.dart';

class ControlPage extends StatefulWidget {
  final ScrollController scrollController;

  const ControlPage({super.key, required this.scrollController});

  @override
  State<ControlPage> createState() => _ControlPageState();
}

class _ControlPageState extends State<ControlPage> {
  // List untuk menyimpan status dari setiap switch
  List<bool> switchStates = [false, false, false, false];

  // Variabel untuk melacak mode saat ini (Manual atau Automatic)
  bool isManualMode = true;

  // Simulasi data dari backend untuk mode Automatic
  List<bool> backendData = [
    false,
    true,
    false,
    true
  ]; // Contoh data dari backend

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      controller: widget.scrollController,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 40.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Controller',
                  style: AppStyle.appTextStyles.title3!.copyWith(
                    color: BaseColors.neutral950,
                  ),
                ),
                Text(
                  'Control melon',
                  style: AppStyle.appTextStyles.regulerNormalRegular!.copyWith(
                    color: BaseColors.neutral500,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 15),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  isManualMode ? 'Manual' : 'Automatic',
                  style: AppStyle.appTextStyles.largeNoneMedium!.copyWith(
                    color: BaseColors.neutral950,
                  ),
                ),
                Row(
                  children: [
                    Text(
                      'Swap',
                      style:
                          AppStyle.appTextStyles.largeNormalRegular!.copyWith(
                        color: BaseColors.neutral600,
                      ),
                    ),
                    const SizedBox(width: 8), // Jarak antara teks dan ikon
                    IconButton(
                      onPressed: () {
                        // Toggle mode antara Manual dan Automatic
                        setState(() {
                          isManualMode = !isManualMode;
                        });
                      },
                      icon: ImageIcon(
                        const AssetImage('assets/images/icons/swap_icon.png'),
                        color: BaseColors.neutral950,
                        size: 35,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 30),
            // Daftar controller
            buildControllerCard(
              'PH UP',
              'Detected 35 F',
              'assets/images/icons/pH_icon.png', // Ikon default untuk mode Manual
              switchStates[0], // Gunakan status switch dari list
              0,
            ),
            const SizedBox(height: 15),
            buildControllerCard(
              'PH DOWN',
              'Detected 35 F',
              'assets/images/icons/pH_icon1.png',
              switchStates[1],
              1,
            ),
            const SizedBox(height: 15),
            buildControllerCard(
              'NUTRISI A',
              'Detected 35 F',
              'assets/images/icons/pH_icon.png',
              switchStates[2],
              2,
            ),
            const SizedBox(height: 15),
            buildControllerCard(
              'NUTRISI B',
              'Detected 35 F',
              'assets/images/icons/pH_icon1.png',
              switchStates[3],
              3,
            ),
          ],
        ),
      ),
    );
  }

  // Fungsi untuk membangun kartu kontrol dengan switch
  Widget buildControllerCard(String title, String subtitle, String imagePath,
      bool switchState, int index) {
    bool currentState = isManualMode
        ? switchState
        : backendData[index]; // Gunakan data backend di mode Automatic

    // Ganti ikon untuk mode Automatic
    String finalImagePath =
        isManualMode ? imagePath : 'assets/images/icons/pH_icon2.png';

    return Stack(
      children: [
        Container(
          width: double.infinity,
          height: 90,
          decoration: BoxDecoration(
            color: isManualMode
                ? (currentState ? Colors.transparent : BaseColors.success500)
                : (currentState
                    ? BaseColors.neutral500
                    : BaseColors.neutral300),
            borderRadius: BorderRadius.circular(16),
          ),
          child: Padding(
            padding:
                const EdgeInsets.symmetric(vertical: 16.0, horizontal: 20.0),
            child: Row(
              children: [
                Image.asset(
                  finalImagePath, // Ikon yang diubah berdasarkan mode
                  width: 45,
                ),
                const SizedBox(width: 10),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      title,
                      style:
                          AppStyle.appTextStyles.smallNormalReguler!.copyWith(
                        color: isManualMode
                            ? (currentState
                                ? BaseColors.neutral900
                                : BaseColors.neutral50)
                            : (currentState
                                ? BaseColors.neutral50
                                : BaseColors.neutral900),
                      ),
                    ),
                    Text(
                      subtitle,
                      style:
                          AppStyle.appTextStyles.smallNormalReguler!.copyWith(
                        color: isManualMode
                            ? (currentState
                                ? BaseColors.neutral900
                                : BaseColors.neutral50)
                            : (currentState
                                ? BaseColors.neutral50
                                : BaseColors.neutral900),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
        Positioned(
          right: 10,
          top: 0,
          bottom: 0,
          child: Switch(
            value: currentState,
            onChanged: isManualMode
                ? (value) {
                    setState(() {
                      switchStates[index] = value;
                    });
                  }
                : null, // Nonaktifkan switch di mode Automatic
            activeTrackColor: BaseColors.success400,
            activeColor: BaseColors.neutral100,
          ),
        ),
      ],
    );
  }
}
