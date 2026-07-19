// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'fee.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$PaymentImpl _$$PaymentImplFromJson(Map<String, dynamic> json) =>
    _$PaymentImpl(
      transactionId: json['transactionId'] as String,
      amountPaid: (json['amountPaid'] as num).toDouble(),
      paymentMethod: json['paymentMethod'] as String? ?? 'Cash',
      paidAt: json['paidAt'] as String?,
    );

Map<String, dynamic> _$$PaymentImplToJson(_$PaymentImpl instance) =>
    <String, dynamic>{
      'transactionId': instance.transactionId,
      'amountPaid': instance.amountPaid,
      'paymentMethod': instance.paymentMethod,
      'paidAt': instance.paidAt,
    };

_$InvoiceImpl _$$InvoiceImplFromJson(Map<String, dynamic> json) =>
    _$InvoiceImpl(
      invoiceNo: json['invoiceNo'] as String,
      title: json['title'] as String,
      amount: (json['amount'] as num).toDouble(),
      dueDate: json['dueDate'] as String?,
      status: json['status'] as String? ?? 'Unpaid',
      paidAmount: (json['paidAmount'] as num?)?.toDouble() ?? 0,
      payments: (json['payments'] as List<dynamic>?)
              ?.map((e) => Payment.fromJson(e as Map<String, dynamic>?))
              .toList() ??
          const [],
    );

Map<String, dynamic> _$$InvoiceImplToJson(_$InvoiceImpl instance) =>
    <String, dynamic>{
      'invoiceNo': instance.invoiceNo,
      'title': instance.title,
      'amount': instance.amount,
      'dueDate': instance.dueDate,
      'status': instance.status,
      'paidAmount': instance.paidAmount,
      'payments': instance.payments,
    };

_$FeeLedgerImpl _$$FeeLedgerImplFromJson(Map<String, dynamic> json) =>
    _$FeeLedgerImpl(
      id: json['id'] as String,
      madrasaId: json['madrasaId'] as String,
      studentId: json['studentId'] as String,
      academicYear: json['academicYear'] as String,
      invoices: (json['invoices'] as List<dynamic>?)
              ?.map((e) => Invoice.fromJson(e as Map<String, dynamic>?))
              .toList() ??
          const [],
    );

Map<String, dynamic> _$$FeeLedgerImplToJson(_$FeeLedgerImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'madrasaId': instance.madrasaId,
      'studentId': instance.studentId,
      'academicYear': instance.academicYear,
      'invoices': instance.invoices,
    };
