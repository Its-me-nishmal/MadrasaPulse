import 'package:freezed_annotation/freezed_annotation.dart';

part 'fee.freezed.dart';
part 'fee.g.dart';

@freezed
class Payment with _$Payment {
  const factory Payment({
    required String transactionId,
    required double amountPaid,
    @Default('Cash') String paymentMethod,
    String? paidAt,
  }) = _Payment;

  factory Payment.fromJson(Map<String, dynamic>? json) =>
      _$PaymentFromJson(json ?? {});
}

@freezed
class Invoice with _$Invoice {
  const factory Invoice({
    required String invoiceNo,
    required String title,
    required double amount,
    String? dueDate,
    @Default('Unpaid') String status,
    @Default(0) double paidAmount,
    @Default([]) List<Payment> payments,
  }) = _Invoice;

  factory Invoice.fromJson(Map<String, dynamic>? json) =>
      _$InvoiceFromJson(json ?? {});
}

@freezed
class FeeLedger with _$FeeLedger {
  const factory FeeLedger({
    required String id,
    required String madrasaId,
    required String studentId,
    required String academicYear,
    @Default([]) List<Invoice> invoices,
  }) = _FeeLedger;

  factory FeeLedger.fromJson(Map<String, dynamic>? json) {
    if (json != null && json['id'] == null && json['_id'] != null) {
      json = {...json, 'id': json['_id']};
    }
    return _$FeeLedgerFromJson(json ?? {});
  }
}
