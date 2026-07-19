import 'package:freezed_annotation/freezed_annotation.dart';

part 'meta.freezed.dart';
part 'meta.g.dart';

@freezed
class Meta with _$Meta {
  const factory Meta({
    @Default(0) int total,
    @Default(1) int page,
    @Default(0) int limit,
    @Default(0) int pages,
  }) = _Meta;

  factory Meta.fromJson(Map<String, dynamic>? json) =>
      _$MetaFromJson(json ?? {});
}
