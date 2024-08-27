import 'package:flutter/material.dart';
import 'package:hydroponic/pages/common/colors.dart';
import 'package:hydroponic/pages/common/styles.dart';

class ControlPage extends StatefulWidget {
  const ControlPage({super.key});

  @override
  State<ControlPage> createState() => _ControlPageState();
}

class _ControlPageState extends State<ControlPage> {
  bool isSwitched = false;

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
                Row(
                  children: [
                    Text(
                      'Controllers',
                      style: AppStyle.appTextStyles.title3!.copyWith(
                        color: BaseColors.neutral950,
                      ),
                    ),
                    const Spacer(),
                    IconButton(
                      onPressed: () {},
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
            Stack(
              children: [
                Container(
                  width: double.infinity,
                  height: 90,
                  decoration: BoxDecoration(
                    color: BaseColors.success600,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 16.0, horizontal: 20.0),
                    child: Row(
                      children: [
                        Image.asset(
                          'assets/images/icons/pH_icon.png',
                          width: 45,
                        ),
                        const SizedBox(width: 10),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'PH DOWN',
                              style: AppStyle.appTextStyles.smallNormalReguler!
                                  .copyWith(
                                color: BaseColors.neutral50,
                              ),
                            ),
                            Text(
                              'Detected 35 F',
                              style: AppStyle.appTextStyles.smallNormalReguler!
                                  .copyWith(
                                color: BaseColors.neutral50,
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
                    value: isSwitched,
                    onChanged: (value) {
                      setState(() {
                        isSwitched = value;
                      });
                    },
                    activeTrackColor: BaseColors.success400,
                    activeColor: BaseColors.neutral100,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 15),
            Stack(
              children: [
                Container(
                  width: double.infinity,
                  height: 90,
                  decoration: BoxDecoration(
                    color: BaseColors.neutral200,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 16.0, horizontal: 20.0),
                    child: Row(
                      children: [
                        Image.asset(
                          'assets/images/icons/pH_icon1.png',
                          width: 45,
                        ),
                        const SizedBox(width: 10),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'NUTRISI A',
                              style: AppStyle.appTextStyles.smallNormalReguler!
                                  .copyWith(
                                color: BaseColors.neutral900,
                              ),
                            ),
                            Text(
                              'Detected 35 F',
                              style: AppStyle.appTextStyles.smallNormalReguler!
                                  .copyWith(
                                color: BaseColors.neutral900,
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
                    value: isSwitched,
                    onChanged: (value) {
                      setState(() {
                        isSwitched = value;
                        print(isSwitched);
                      });
                    },
                    activeTrackColor: BaseColors.success400,
                    activeColor: BaseColors.neutral100,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
