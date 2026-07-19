import 'package:freezed_annotation/freezed_annotation.dart';

part 'filter.freezed.dart';
part 'filter.g.dart';

@freezed
class FilterState with _$FilterState {
  const factory FilterState({
    String? search,
    @Default([]) List<String> classIds,
    @Default('') String status,
    @Default(1) int page,
    @Default(20) int limit,
  }) = _FilterState;

  factory FilterState.fromJson(Map<String, dynamic> json) => _$FilterStateFromJson(json);
}
