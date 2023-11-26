// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';

class ThemeState extends Equatable {
  final bool isDarkMode;
  const ThemeState({required this.isDarkMode});

  @override
  List<Object?> get props => [isDarkMode];

  ThemeState copyWith({
    bool? isDarkMode,
  }) {
    return ThemeState(
      isDarkMode: isDarkMode ?? this.isDarkMode,
    );
  }
}
