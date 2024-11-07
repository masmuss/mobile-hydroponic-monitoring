import 'package:flutter/material.dart';

class AppStyle {
  AppStyle._();

  /// Contoh penggunaan : [AppStyle.appTextStyles.smallsmallNormalMedium]
  /// Menambahkan custom color : [AppStyle.appTextStyles.smallNormalMedium.copyWith(color: Colors.amber)]

  static const AppTextStyles appTextStyles = AppTextStyles();
}

// Custom TextStyle
class AppTextStyles {
  const AppTextStyles({TextStyle? small});

  // Title 1
  TextStyle? get title1 => const TextStyle(
        fontWeight: FontWeight.w700,
        fontSize: 48,
      );
  // Title 2
  TextStyle? get title2 => const TextStyle(
      fontWeight: FontWeight.w700, fontSize: 32, fontFamily: 'Monserrat');
  // Title 3
  TextStyle? get title3 => const TextStyle(
        fontWeight: FontWeight.w700,
        fontSize: 24,
      );
  // Title 4
  TextStyle? get title4 => const TextStyle(
        fontWeight: FontWeight.w500,
        fontSize: 32,
      );
  // Large None
  TextStyle? get largeNoneHeading1 => const TextStyle(
        fontWeight: FontWeight.w600,
        fontSize: 28,
      );
  TextStyle? get largeNoneMedium => const TextStyle(
        fontWeight: FontWeight.w500,
        fontSize: 20,
        fontFamily: 'Monserrat',
      );
  TextStyle? get largeNoneRegular => const TextStyle(
        fontWeight: FontWeight.w400,
        fontSize: 18,
      );

  // Large Tight
  TextStyle? get largeTightBold => const TextStyle(
        fontWeight: FontWeight.w700,
        fontSize: 18,
        height: 2.0,
      );
  TextStyle? get largeTightMedium => const TextStyle(
        fontWeight: FontWeight.w500,
        fontSize: 18,
        height: 2.0,
      );
  TextStyle? get largeTightRegular => const TextStyle(
        fontWeight: FontWeight.w400,
        fontSize: 18,
        height: 2.0,
      );

  // Large Normal
  TextStyle? get largeNormalh3 => const TextStyle(
        fontWeight: FontWeight.w700,
        fontSize: 18,
        height: 2.0,
      );
  TextStyle? get largeNormalMedium => const TextStyle(
        fontWeight: FontWeight.w500,
        fontSize: 18,
        height: 2.4,
      );
  TextStyle? get largeNormalRegular => const TextStyle(
        fontWeight: FontWeight.w400,
        fontSize: 18,
        height: 2.4,
      );

  // Reguler None
  TextStyle? get regulerNoneHeader1 => const TextStyle(
        fontWeight: FontWeight.w700,
        fontSize: 16,
      );
  TextStyle? get regulerNoneMedium => const TextStyle(
        fontWeight: FontWeight.w500,
        fontSize: 16,
      );
  TextStyle? get regulerNoneReguler => const TextStyle(
        fontWeight: FontWeight.w400,
        fontSize: 16,
      );

  // Reguler Tight
  TextStyle? get regulerTightBold => const TextStyle(
        fontWeight: FontWeight.w700,
        fontSize: 16,
        height: 2.0,
      );
  TextStyle? get regulerTightMedium => const TextStyle(
        fontWeight: FontWeight.w500,
        fontSize: 16,
        height: 2.0,
      );
  TextStyle? get regulerTightReguler => const TextStyle(
        fontWeight: FontWeight.w400,
        fontSize: 16,
        height: 2.0,
      );

  // Reguler Normal
  TextStyle? get largeNormalBold => const TextStyle(
        fontWeight: FontWeight.w700,
        fontSize: 16,
        height: 2.4,
      );
  TextStyle? get regulerNormalMedium => const TextStyle(
        fontWeight: FontWeight.w500,
        fontSize: 16,
        height: 2.4,
      );
  TextStyle? get regulerNormalRegular => const TextStyle(
        fontWeight: FontWeight.w400,
        fontSize: 16,
        height: 2.4,
      );

  // Small None
  TextStyle? get smallNonBold => const TextStyle(
        fontWeight: FontWeight.w700,
        fontSize: 14,
        height: 1.4,
      );
  TextStyle? get smallNoneMedium => const TextStyle(
        fontWeight: FontWeight.w500,
        fontSize: 14,
        height: 1.4,
      );
  TextStyle? get smallNoneReguler => const TextStyle(
        fontWeight: FontWeight.w400,
        fontSize: 14,
        height: 1.4,
      );

  // Small Tight
  TextStyle? get smallTightBold => const TextStyle(
        fontWeight: FontWeight.w700,
        fontSize: 14,
        height: 1.6,
      );
  TextStyle? get smallTightMedium => const TextStyle(
        fontWeight: FontWeight.w500,
        fontSize: 14,
        height: 1.6,
      );
  TextStyle? get smallTightReguler => const TextStyle(
        fontWeight: FontWeight.w400,
        fontSize: 14,
        height: 1.6,
      );

  // Small Normal
  TextStyle? get smallNormalBold => const TextStyle(
        fontWeight: FontWeight.w700,
        fontSize: 14,
        height: 2.0,
      );
  TextStyle? get smallNormalMedium => const TextStyle(
        fontWeight: FontWeight.w500,
        fontSize: 14,
        height: 2.0,
      );
  TextStyle? get smallNormalReguler => const TextStyle(
        fontWeight: FontWeight.w400,
        fontSize: 14,
        height: 2.0,
      );

  // xSmall None
  TextStyle? get xSmallNoneBold => const TextStyle(
        fontWeight: FontWeight.w700,
        fontSize: 12,
        height: 1.2,
      );
  TextStyle? get xSmallNoneMedium => const TextStyle(
        fontWeight: FontWeight.w500,
        fontSize: 12,
        height: 1.2,
      );
  TextStyle? get xSmallNoneReguler => const TextStyle(
        fontWeight: FontWeight.w400,
        fontSize: 12,
        height: 1.2,
      );

  // xSmall Tight
  TextStyle? get xSmallTightBold => const TextStyle(
        fontWeight: FontWeight.w700,
        fontSize: 12,
        height: 1.4,
      );
  TextStyle? get xSmallTightMedium => const TextStyle(
        fontWeight: FontWeight.w500,
        fontSize: 12,
        height: 1.4,
      );
  TextStyle? get xSmallTightReguler => const TextStyle(
        fontWeight: FontWeight.w400,
        fontSize: 12,
        height: 1.4,
      );

  // xSmall Normal
  TextStyle? get xSmallNormalBold => const TextStyle(
        fontWeight: FontWeight.w700,
        fontSize: 12,
        height: 1.6,
      );
  TextStyle? get xSmallNormalMedium => const TextStyle(
        fontWeight: FontWeight.w500,
        fontSize: 12,
        height: 1.6,
      );
  TextStyle? get xSmallNormalReguler => const TextStyle(
        fontWeight: FontWeight.w400,
        fontSize: 12,
        height: 1.6,
      );

  // Tiny None
  TextStyle? get tinyNoneKategori => const TextStyle(
        fontWeight: FontWeight.w600,
        fontSize: 16,
        height: 1.0,
      );
  TextStyle? get tinyNoneMedium => const TextStyle(
        fontWeight: FontWeight.w500,
        fontSize: 8,
        height: 1.0,
      );
  TextStyle? get tinyNoneReguler => const TextStyle(
        fontWeight: FontWeight.w400,
        fontSize: 10,
        height: 1.0,
      );

  // Tiny Tight
  TextStyle? get tinyTightBold => const TextStyle(
        fontWeight: FontWeight.w700,
        fontSize: 10,
        height: 1.2,
      );
  TextStyle? get tinyTightMedium => const TextStyle(
        fontWeight: FontWeight.w500,
        fontSize: 10,
        height: 1.2,
      );
  TextStyle? get tinyTightReguler => const TextStyle(
        fontWeight: FontWeight.w400,
        fontSize: 10,
        height: 1.2,
      );

  // Tiny Normal
  TextStyle? get tinyNormalBold => const TextStyle(
        fontWeight: FontWeight.w700,
        fontSize: 10,
        height: 1.4,
      );
  TextStyle? get tinyNormalMedium => const TextStyle(
        fontWeight: FontWeight.w500,
        fontSize: 10,
        height: 1.4,
      );
  TextStyle? get tinyNormalReguler => const TextStyle(
        fontWeight: FontWeight.w400,
        fontSize: 14,
        height: 2.0,
      );
}
