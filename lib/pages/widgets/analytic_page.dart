import 'package:flutter/material.dart';
import 'package:hydroponic_app/pages/common/colors.dart';
import 'package:hydroponic_app/pages/common/styles.dart';

List<String> months = [
  'January',
  'February',
  'March',
  'April',
  'May',
  'June',
  'July',
  'August',
  'September',
  'October',
  'November',
  'December'
];

class AnalyticPage extends StatefulWidget {
  const AnalyticPage({super.key});

  @override
  State<AnalyticPage> createState() => _AnalyticPageState();
}

class _AnalyticPageState extends State<AnalyticPage> {
  String selectedMonth = 'July';
  final LayerLink _layerLink = LayerLink();

  OverlayEntry? _overlayEntry;

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
                  'Graphic History',
                  style: AppStyle.appTextStyles.title3!.copyWith(
                    color: BaseColors.neutral950,
                  ),
                ),
                Text(
                  'See melon health statistics',
                  style: AppStyle.appTextStyles.smallNormalReguler!.copyWith(
                    color: BaseColors.neutral400,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 30),
            Row(
              children: [
                Text(
                  'Step',
                  style: AppStyle.appTextStyles.largeNoneMedium!.copyWith(
                    color: BaseColors.neutral600,
                  ),
                ),
                const Spacer(),
                CompositedTransformTarget(
                  link: _layerLink,
                  child: GestureDetector(
                    onTap: () {
                      _toggleDropdown();
                    },
                    child: Container(
                      width: 150, // Set the width to match the dropdown items
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 8),
                      decoration: BoxDecoration(
                        color: BaseColors.success100,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            selectedMonth,
                            style: AppStyle.appTextStyles.largeNoneMedium!
                                .copyWith(
                              color: BaseColors.neutral600,
                            ),
                          ),
                          Icon(
                            Icons.arrow_drop_down,
                            color: BaseColors.neutral600,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            Container(
              width: double.infinity,
              height: 50,
              decoration: BoxDecoration(
                color: BaseColors.neutral200,
                borderRadius: BorderRadius.circular(16),
              ),
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 10.0, horizontal: 30),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Icon(Icons.circle,
                            color: BaseColors.success500, size: 10),
                        const SizedBox(width: 8),
                        const Text('Normal'),
                      ],
                    ),
                    Row(
                      children: [
                        Icon(Icons.circle,
                            color: BaseColors.danger500, size: 10),
                        const SizedBox(width: 8),
                        const Text('High'),
                      ],
                    ),
                    Row(
                      children: [
                        Icon(Icons.circle,
                            color: BaseColors.warning500, size: 10),
                        const SizedBox(width: 8),
                        const Text('Low'),
                      ],
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  void _toggleDropdown() {
    if (_overlayEntry == null) {
      _overlayEntry = _createOverlayEntry();
      Overlay.of(context).insert(_overlayEntry!);
    } else {
      _overlayEntry!.remove();
      _overlayEntry = null;
    }
  }

  OverlayEntry _createOverlayEntry() {
    return OverlayEntry(
      builder: (context) => Positioned(
        width: 200, // Ensure dropdown matches the width of the Container
        child: CompositedTransformFollower(
          link: _layerLink,
          showWhenUnlinked: false,
          offset: const Offset(0.0, 40), // Position below the selected item
          child: Material(
            elevation: 4.0,
            borderRadius: BorderRadius.circular(8),
            child: ConstrainedBox(
              constraints: const BoxConstraints(
                maxHeight:
                    200, // Set max height to make the dropdown scrollable
              ),
              child: ListView(
                padding: EdgeInsets.zero,
                shrinkWrap: true,
                children: months.map((month) {
                  return Container(
                    width: 200, // Match width with the selected item container
                    padding:
                        const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    child: GestureDetector(
                      onTap: () {
                        setState(() {
                          selectedMonth = month;
                        });
                        _toggleDropdown();
                      },
                      child: Text(
                        month,
                        style: AppStyle.appTextStyles.largeNoneMedium!.copyWith(
                          color: BaseColors.neutral600,
                        ),
                      ),
                    ),
                  );
                }).toList(),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
