import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:hydroponic/models/configs.dart';
import 'package:hydroponic/models/relays.dart';
import 'package:hydroponic/pages/common/colors.dart';
import 'package:hydroponic/pages/common/styles.dart';
import 'package:hydroponic/services/device_service.dart';

class ControlPage extends StatefulWidget {
  final int deviceId;
  final ScrollController scrollController;

  const ControlPage({
    super.key,
    required this.deviceId,
    required this.scrollController,
  });

  @override
  State<ControlPage> createState() => _ControlPageState();
}

class _ControlPageState extends State<ControlPage> {
  final DeviceService _deviceService = DeviceService();
  bool isManualMode = true;

  /// Fungsi untuk mengubah status relay di Firebase
  Future<void> _toggleRelay(String relayKey, bool value) async {
    try {
      await _deviceService.updateRelayConfig(widget.deviceId, relayKey, value);
    } catch (error) {
      if (kDebugMode) {
        print('Error updating relay config: $error');
      }
    }
  }

  /// Mengubah mode antara Manual & Auto
  void _swapMode() {
    setState(() {
      isManualMode = !isManualMode;
      _deviceService.switchAutoMode(
          widget.deviceId, isManualMode ? 'manual' : 'auto');
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      controller: widget.scrollController,
      child: StreamBuilder<Configs>(
        stream: _deviceService.getDeviceConfigStream(widget.deviceId),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(
                child: Text('Error loading relay states: ${snapshot.error}'));
          } else if (!snapshot.hasData) {
            return const Center(child: Text('No relay states available'));
          }

          final config = snapshot.data!;
          final relays = Relays.fromJson(config.relays);

          return Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 24.0, vertical: 40.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                HeaderSection(
                  isManualMode: isManualMode,
                  onSwapMode: _swapMode,
                ),
                const SizedBox(height: 30),
                ControllerCard(
                  title: 'AERATOR',
                  subtitle: 'To keep the water oxygenated',
                  icon: Icons.bubble_chart_rounded,
                  switchState: isManualMode ? manual.aerator : auto.aerator,
                  relayPath: 'aerator',
                  isManualMode: isManualMode,
                  onToggle: _toggleRelay,
                ),
                const SizedBox(height: 15),
                ControllerCard(
                  title: 'A NUTRIENT',
                  subtitle: 'Composition of AB Mix Nutrient',
                  icon: Icons.science,
                  switchState: isManualMode ? manual.nutrientA : auto.nutrientA,
                  relayPath: 'nutrient_a',
                  isManualMode: isManualMode,
                  onToggle: _toggleRelay,
                ),
                const SizedBox(height: 15),
                ControllerCard(
                  title: 'B NUTRIENT',
                  subtitle: 'Composition of AB Mix Nutrient',
                  icon: Icons.science,
                  switchState: isManualMode ? manual.nutrientB : auto.nutrientB,
                  relayPath: 'nutrient_b',
                  isManualMode: isManualMode,
                  onToggle: _toggleRelay,
                ),
                const SizedBox(height: 15),
                ControllerCard(
                  title: 'PH BUFFER',
                  subtitle: 'Adjust the pH level',
                  icon: Icons.settings,
                  switchState: isManualMode ? manual.phBuffer : auto.phBuffer,
                  relayPath: 'ph_buffer',
                  isManualMode: isManualMode,
                  onToggle: _toggleRelay,
                ),
                const SizedBox(height: 15),
                ControllerCard(
                  title: 'Water PUMP',
                  subtitle: 'Composition of Water',
                  icon: Icons.water,
                  switchState: isManualMode ? manual.water : auto.water,
                  relayPath: 'water',
                  isManualMode: isManualMode,
                  onToggle: _toggleRelay,
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

class HeaderSection extends StatelessWidget {
  final bool isManualMode;
  final VoidCallback onSwapMode;

  const HeaderSection({
    super.key,
    required this.isManualMode,
    required this.onSwapMode,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
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
                  style: AppStyle.appTextStyles.largeNormalRegular!.copyWith(
                    color: BaseColors.neutral600,
                  ),
                ),
                IconButton(
                  onPressed: onSwapMode,
                  icon: Icon(
                    Icons.swap_horiz,
                    color: BaseColors.neutral950,
                    size: 24,
                  ),
                ),
              ],
            ),
          ],
        ),
      ],
    );
  }
}

class ControllerCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final IconData icon;
  final bool switchState;
  final String relayPath;
  final bool isManualMode;
  final Function(String, bool) onToggle;

  const ControllerCard({
    super.key,
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.switchState,
    required this.relayPath,
    required this.isManualMode,
    required this.onToggle,
  });

  @override
  Widget build(BuildContext context) {
    final currentState = switchState;
    return Stack(
      children: [
        Container(
          width: double.infinity,
          height: 90,
          decoration: BoxDecoration(
            color: isManualMode
                ? (currentState ? Colors.transparent : BaseColors.success600)
                : BaseColors.neutral300,
            borderRadius: BorderRadius.circular(16),
          ),
          child: Padding(
            padding:
                const EdgeInsets.symmetric(vertical: 16.0, horizontal: 20.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                _buildIcon(),
                const SizedBox(width: 10),
                _buildText(),
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
                    onToggle(relayPath, value);
                  }
                : null,
            activeTrackColor:
                isManualMode ? BaseColors.success700 : BaseColors.neutral400,
            activeColor: BaseColors.neutral100,
          ),
        ),
      ],
    );
  }

  Widget _buildIcon() {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: isManualMode
            ? (switchState ? BaseColors.success600 : BaseColors.neutral50)
            : BaseColors.neutral50,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Icon(
        icon,
        size: 36,
        color: isManualMode
            ? (switchState ? BaseColors.neutral50 : BaseColors.neutral900)
            : BaseColors.neutral900,
      ),
    );
  }

  Widget _buildText() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          title,
          style: AppStyle.appTextStyles.smallNormalBold!.copyWith(
            color: isManualMode
                ? (switchState ? BaseColors.neutral900 : BaseColors.neutral50)
                : BaseColors.neutral900,
          ),
        ),
        Text(
          subtitle,
          style: AppStyle.appTextStyles.xSmallNormalReguler!.copyWith(
            color: isManualMode
                ? (switchState ? BaseColors.neutral900 : BaseColors.neutral50)
                : BaseColors.neutral900,
          ),
        ),
      ],
    );
  }
}
