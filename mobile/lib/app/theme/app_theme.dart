import 'package:material_ui/material_ui.dart';

class AppColors {
  const AppColors._();

  static const primary = Color(0xFF2B78B8);
  static const primaryPressed = Color(0xFF24669E);
  static const secondary = Color(0xFFFFB8CC);
  static const tertiary = Color(0xFFFFC94A);
  static const ink = Color(0xFF172B4D);
  static const mutedInk = Color(0xFF536981);
  static const background = Color(0xFFFFFCF8);
  static const softBlue = Color(0xFFEAF5FE);
  static const softPink = Color(0xFFFFF0F5);
  static const softGreen = Color(0xFFE0F5E9);
  static const softGold = Color(0xFFFFF3CD);
  static const softLavender = Color(0xFFF0E9FA);
  static const border = Color(0xFFD8E3ED);
  static const disabledSurface = Color(0xFFE5EAF0);
  static const disabledInk = Color(0xFF687789);
  static const accepted = Color(0xFF166648);
  static const pending = Color(0xFF765500);
  static const laterSuggested = Color(0xFF24558C);
  static const maybeLater = Color(0xFF7047A3);
}

class AppSpacing {
  const AppSpacing._();

  static const double xs = 4;
  static const double sm = 8;
  static const double md = 12;
  static const double lg = 16;
  static const double xl = 24;
  static const double xxl = 32;
  static const double xxxl = 48;
}

class AppRadii {
  const AppRadii._();

  static const double small = 8;
  static const double medium = 16;
  static const double large = 24;
  static const double pill = 999;
}

class RequestStatusColors extends ThemeExtension<RequestStatusColors> {
  const RequestStatusColors({
    required this.pending,
    required this.pendingContainer,
    required this.accepted,
    required this.acceptedContainer,
    required this.laterSuggested,
    required this.laterSuggestedContainer,
    required this.maybeLater,
    required this.maybeLaterContainer,
  });

  final Color pending;
  final Color pendingContainer;
  final Color accepted;
  final Color acceptedContainer;
  final Color laterSuggested;
  final Color laterSuggestedContainer;
  final Color maybeLater;
  final Color maybeLaterContainer;

  @override
  RequestStatusColors copyWith({
    Color? pending,
    Color? pendingContainer,
    Color? accepted,
    Color? acceptedContainer,
    Color? laterSuggested,
    Color? laterSuggestedContainer,
    Color? maybeLater,
    Color? maybeLaterContainer,
  }) {
    return RequestStatusColors(
      pending: pending ?? this.pending,
      pendingContainer: pendingContainer ?? this.pendingContainer,
      accepted: accepted ?? this.accepted,
      acceptedContainer: acceptedContainer ?? this.acceptedContainer,
      laterSuggested: laterSuggested ?? this.laterSuggested,
      laterSuggestedContainer:
          laterSuggestedContainer ?? this.laterSuggestedContainer,
      maybeLater: maybeLater ?? this.maybeLater,
      maybeLaterContainer: maybeLaterContainer ?? this.maybeLaterContainer,
    );
  }

  @override
  RequestStatusColors lerp(
    covariant ThemeExtension<RequestStatusColors>? other,
    double t,
  ) {
    if (other is! RequestStatusColors) {
      return this;
    }

    return RequestStatusColors(
      pending: Color.lerp(pending, other.pending, t)!,
      pendingContainer: Color.lerp(
        pendingContainer,
        other.pendingContainer,
        t,
      )!,
      accepted: Color.lerp(accepted, other.accepted, t)!,
      acceptedContainer: Color.lerp(
        acceptedContainer,
        other.acceptedContainer,
        t,
      )!,
      laterSuggested: Color.lerp(laterSuggested, other.laterSuggested, t)!,
      laterSuggestedContainer: Color.lerp(
        laterSuggestedContainer,
        other.laterSuggestedContainer,
        t,
      )!,
      maybeLater: Color.lerp(maybeLater, other.maybeLater, t)!,
      maybeLaterContainer: Color.lerp(
        maybeLaterContainer,
        other.maybeLaterContainer,
        t,
      )!,
    );
  }
}

class AppTheme {
  const AppTheme._();

  static final ThemeData light = ThemeData(
    useMaterial3: true,
    colorScheme: ColorScheme.fromSeed(
      seedColor: AppColors.primary,
      brightness: Brightness.light,
    ).copyWith(
      primary: AppColors.primary,
      onPrimary: Colors.white,
      primaryContainer: AppColors.softBlue,
      onPrimaryContainer: AppColors.ink,
      secondary: AppColors.secondary,
      onSecondary: AppColors.ink,
      secondaryContainer: AppColors.softPink,
      onSecondaryContainer: AppColors.ink,
      tertiary: AppColors.tertiary,
      onTertiary: AppColors.ink,
      tertiaryContainer: AppColors.softGold,
      onTertiaryContainer: AppColors.ink,
      surface: AppColors.background,
      onSurface: AppColors.ink,
      onSurfaceVariant: AppColors.mutedInk,
      outline: AppColors.border,
      outlineVariant: AppColors.border,
    ),
    scaffoldBackgroundColor: AppColors.background,
    textTheme: const TextTheme(
      displayLarge: TextStyle(fontSize: 32, fontWeight: FontWeight.w700),
      displayMedium: TextStyle(fontSize: 28, fontWeight: FontWeight.w700),
      headlineLarge: TextStyle(fontSize: 26, fontWeight: FontWeight.w700),
      headlineMedium: TextStyle(fontSize: 22, fontWeight: FontWeight.w700),
      headlineSmall: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
      titleLarge: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
      titleMedium: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
      titleSmall: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
      bodyLarge: TextStyle(fontSize: 16, height: 1.4),
      bodyMedium: TextStyle(fontSize: 14, height: 1.4),
      bodySmall: TextStyle(fontSize: 12, height: 1.35),
      labelLarge: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
      labelMedium: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
      labelSmall: TextStyle(fontSize: 12, fontWeight: FontWeight.w500),
    ).apply(bodyColor: AppColors.ink, displayColor: AppColors.ink),
    appBarTheme: const AppBarTheme(
      backgroundColor: AppColors.background,
      foregroundColor: AppColors.ink,
      centerTitle: true,
      elevation: 0,
      scrolledUnderElevation: 0,
    ),
    filledButtonTheme: FilledButtonThemeData(
      style: ButtonStyle(
        minimumSize: const WidgetStatePropertyAll(Size(48, 48)),
        padding: const WidgetStatePropertyAll(
          EdgeInsets.symmetric(
            horizontal: AppSpacing.xl,
            vertical: AppSpacing.md,
          ),
        ),
        shape: WidgetStatePropertyAll(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppRadii.medium),
          ),
        ),
        backgroundColor: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.disabled)) {
            return AppColors.disabledSurface;
          }
          if (states.contains(WidgetState.pressed)) {
            return AppColors.primaryPressed;
          }
          return AppColors.primary;
        }),
        foregroundColor: WidgetStateProperty.resolveWith((states) {
          return states.contains(WidgetState.disabled)
              ? AppColors.disabledInk
              : Colors.white;
        }),
      ),
    ),
    outlinedButtonTheme: OutlinedButtonThemeData(
      style: ButtonStyle(
        minimumSize: const WidgetStatePropertyAll(Size(48, 48)),
        padding: const WidgetStatePropertyAll(
          EdgeInsets.symmetric(
            horizontal: AppSpacing.xl,
            vertical: AppSpacing.md,
          ),
        ),
        shape: WidgetStatePropertyAll(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppRadii.medium),
          ),
        ),
        side: WidgetStateProperty.resolveWith((states) {
          return BorderSide(
            color: states.contains(WidgetState.disabled)
                ? AppColors.border
                : AppColors.primary,
          );
        }),
        foregroundColor: WidgetStateProperty.resolveWith((states) {
          return states.contains(WidgetState.disabled)
              ? AppColors.disabledInk
              : AppColors.primary;
        }),
      ),
    ),
    extensions: const [
      RequestStatusColors(
        pending: AppColors.pending,
        pendingContainer: AppColors.softGold,
        accepted: AppColors.accepted,
        acceptedContainer: AppColors.softGreen,
        laterSuggested: AppColors.laterSuggested,
        laterSuggestedContainer: AppColors.softBlue,
        maybeLater: AppColors.maybeLater,
        maybeLaterContainer: AppColors.softLavender,
      ),
    ],
  );
}
