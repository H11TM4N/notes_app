// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';
import 'package:notes_app/logic/repositories/repos.dart';

class ThemeState extends Equatable {
  final bool isDarkMode;
  const ThemeState({this.isDarkMode = false});

  @override
  List<Object?> get props => [isDarkMode];

  ThemeState.empty() : isDarkMode = ThemePreferences.getTheme() ?? false;

  ThemeState copyWith({
    bool? isDarkMode,
  }) {
    return ThemeState(
      isDarkMode: isDarkMode ?? this.isDarkMode,
    );
  }
}
