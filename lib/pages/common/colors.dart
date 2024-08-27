import 'dart:ui';

// penggunaan
// BaseColors.neutral950

extension HexColor on Color {
  /// String is in the format "aabbcc" or "ffaabbcc" with an optional leading "#".
  static Color fromHex(String hexString) {
    final buffer = StringBuffer();
    if (hexString.length == 6 || hexString.length == 7) buffer.write('ff');
    buffer.write(hexString.replaceFirst('#', ''));
    return Color(int.parse(buffer.toString(), radix: 16));
  }

  /// Prefixes a hash sign if [leadingHashSign] is set to `true` (default is `true`).
  String toHex({bool leadingHashSign = true}) => '${leadingHashSign ? '#' : ''}'
      '${alpha.toRadixString(16).padLeft(2, '0')}'
      '${red.toRadixString(16).padLeft(2, '0')}'
      '${green.toRadixString(16).padLeft(2, '0')}'
      '${blue.toRadixString(16).padLeft(2, '0')}';
}

class BaseColors {
  //neutral
  static Color neutral950 = HexColor.fromHex('#020617');
  static Color neutral900 = HexColor.fromHex('#0F172A');
  static Color neutral800 = HexColor.fromHex('#1E293B');
  static Color neutral700 = HexColor.fromHex('#334155');
  static Color neutral600 = HexColor.fromHex('#475569');
  static Color neutral500 = HexColor.fromHex('#64748B');
  static Color neutral400 = HexColor.fromHex('#94A3B8');
  static Color neutral300 = HexColor.fromHex('#CBD5E1');
  static Color neutral200 = HexColor.fromHex('#E2E8F0');
  static Color neutral100 = HexColor.fromHex('#F1F5F9');
  static Color neutral50 = HexColor.fromHex('#FFFFFF');
  //gray
  static Color gray950 = HexColor.fromHex('#030712');
  static Color gray900 = HexColor.fromHex('#0F172A');
  static Color gray800 = HexColor.fromHex('#1F2937');
  static Color gray700 = HexColor.fromHex('#374151');
  static Color gray600 = HexColor.fromHex('#4B5563');
  static Color gray500 = HexColor.fromHex('#6B7280');
  static Color gray400 = HexColor.fromHex('#9CA3AF');
  static Color gray300 = HexColor.fromHex('#D1D5DB');
  static Color gray200 = HexColor.fromHex('#E5E7EB');
  static Color gray100 = HexColor.fromHex('#F3F4F6');
  static Color gray50 = HexColor.fromHex('#F9FAFB');
  //primary
  static Color primary950 = HexColor.fromHex('#172554');
  static Color primary900 = HexColor.fromHex('#1E3A8A');
  static Color primary800 = HexColor.fromHex('#1E40AF');
  static Color primary700 = HexColor.fromHex('#1D4ED8');
  static Color primary600 = HexColor.fromHex('#2563EB');
  static Color primary500 = HexColor.fromHex('#3B82F6');
  static Color primary400 = HexColor.fromHex('#60A5FA');
  static Color primary300 = HexColor.fromHex('#93C5FD');
  static Color primary200 = HexColor.fromHex('#BFDBFE');
  static Color primary100 = HexColor.fromHex('#DBEAFE');
  static Color primary50 = HexColor.fromHex('#EFF6FF');
  //secondary
  static Color secondary950 = HexColor.fromHex('#360269');
  static Color secondary900 = HexColor.fromHex('#52178C');
  static Color secondary800 = HexColor.fromHex('#631AAF');
  static Color secondary700 = HexColor.fromHex('#731AD6');
  static Color secondary600 = HexColor.fromHex('#862AF3');
  static Color secondary500 = HexColor.fromHex('#9742FF');
  static Color secondary400 = HexColor.fromHex('#B87EFF');
  static Color secondary300 = HexColor.fromHex('#D3B0FF');
  static Color secondary200 = HexColor.fromHex('#E6D3FF');
  static Color secondary100 = HexColor.fromHex('#F1E7FF');
  static Color secondary50 = HexColor.fromHex('#F9F5FF');
  //danger
  static Color danger950 = HexColor.fromHex('#431407');
  static Color danger900 = HexColor.fromHex('#7F1D1D');
  static Color danger800 = HexColor.fromHex('#991B1B');
  static Color danger700 = HexColor.fromHex('#B91C1C');
  static Color danger600 = HexColor.fromHex('#DC2626');
  static Color danger500 = HexColor.fromHex('#EF4444');
  static Color danger400 = HexColor.fromHex('#F87171');
  static Color danger300 = HexColor.fromHex('#FCA5A5');
  static Color danger200 = HexColor.fromHex('#FECACA');
  static Color danger100 = HexColor.fromHex('#FEE2E2');
  static Color danger50 = HexColor.fromHex('#FEF2F2');
  //warning
  static Color warning950 = HexColor.fromHex('#422006');
  static Color warning900 = HexColor.fromHex('#713F12');
  static Color warning800 = HexColor.fromHex('#854D0E');
  static Color warning700 = HexColor.fromHex('#A16207');
  static Color warning600 = HexColor.fromHex('#CA8A04');
  static Color warning500 = HexColor.fromHex('#EAB308');
  static Color warning400 = HexColor.fromHex('#FACC15');
  static Color warning300 = HexColor.fromHex('#FDE047');
  static Color warning200 = HexColor.fromHex('#FEF08A');
  static Color warning100 = HexColor.fromHex('#FEF9C3');
  static Color warning50 = HexColor.fromHex('#FEFCE8');
  //info
  static Color info950 = HexColor.fromHex('#082F49');
  static Color info900 = HexColor.fromHex('#0C4A6E');
  static Color info800 = HexColor.fromHex('#075985');
  static Color info700 = HexColor.fromHex('#0369A1');
  static Color info600 = HexColor.fromHex('#0284C7');
  static Color info500 = HexColor.fromHex('#0EA5E9');
  static Color info400 = HexColor.fromHex('#38BDF8');
  static Color info300 = HexColor.fromHex('#7DD3FC');
  static Color info200 = HexColor.fromHex('#BAE6FD');
  static Color info100 = HexColor.fromHex('#E0F2FE');
  static Color info50 = HexColor.fromHex('#F0F9FF');
  //success
  static Color success950 = HexColor.fromHex('#052E16');
  static Color success900 = HexColor.fromHex('#14532D');
  static Color success800 = HexColor.fromHex('#166534');
  static Color success700 = HexColor.fromHex('#15803D');
  static Color success600 = HexColor.fromHex('#16A34A');
  static Color success500 = HexColor.fromHex('#22C55E');
  static Color success400 = HexColor.fromHex('#4ADE80');
  static Color success300 = HexColor.fromHex('#86EFAC');
  static Color success200 = HexColor.fromHex('#BBF7D0');
  static Color success100 = HexColor.fromHex('#DCFCE7');
  static Color success50 = HexColor.fromHex('#F0FDF4');
}
