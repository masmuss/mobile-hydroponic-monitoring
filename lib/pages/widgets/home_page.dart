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
  int tappedIndex = -1;
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
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
              ],
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
            )
          ],
        ),
      ),
    );
  }
}
