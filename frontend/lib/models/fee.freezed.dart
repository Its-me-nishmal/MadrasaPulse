// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'fee.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

Payment _$PaymentFromJson(Map<String, dynamic> json) {
  return _Payment.fromJson(json);
}

/// @nodoc
mixin _$Payment {
  String get transactionId => throw _privateConstructorUsedError;
  double get amountPaid => throw _privateConstructorUsedError;
  String get paymentMethod => throw _privateConstructorUsedError;
  String? get paidAt => throw _privateConstructorUsedError;

  /// Serializes this Payment to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of Payment
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $PaymentCopyWith<Payment> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PaymentCopyWith<$Res> {
  factory $PaymentCopyWith(Payment value, $Res Function(Payment) then) =
      _$PaymentCopyWithImpl<$Res, Payment>;
  @useResult
  $Res call(
      {String transactionId,
      double amountPaid,
      String paymentMethod,
      String? paidAt});
}

/// @nodoc
class _$PaymentCopyWithImpl<$Res, $Val extends Payment>
    implements $PaymentCopyWith<$Res> {
  _$PaymentCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of Payment
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? transactionId = null,
    Object? amountPaid = null,
    Object? paymentMethod = null,
    Object? paidAt = freezed,
  }) {
    return _then(_value.copyWith(
      transactionId: null == transactionId
          ? _value.transactionId
          : transactionId // ignore: cast_nullable_to_non_nullable
              as String,
      amountPaid: null == amountPaid
          ? _value.amountPaid
          : amountPaid // ignore: cast_nullable_to_non_nullable
              as double,
      paymentMethod: null == paymentMethod
          ? _value.paymentMethod
          : paymentMethod // ignore: cast_nullable_to_non_nullable
              as String,
      paidAt: freezed == paidAt
          ? _value.paidAt
          : paidAt // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$PaymentImplCopyWith<$Res> implements $PaymentCopyWith<$Res> {
  factory _$$PaymentImplCopyWith(
          _$PaymentImpl value, $Res Function(_$PaymentImpl) then) =
      __$$PaymentImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String transactionId,
      double amountPaid,
      String paymentMethod,
      String? paidAt});
}

/// @nodoc
class __$$PaymentImplCopyWithImpl<$Res>
    extends _$PaymentCopyWithImpl<$Res, _$PaymentImpl>
    implements _$$PaymentImplCopyWith<$Res> {
  __$$PaymentImplCopyWithImpl(
      _$PaymentImpl _value, $Res Function(_$PaymentImpl) _then)
      : super(_value, _then);

  /// Create a copy of Payment
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? transactionId = null,
    Object? amountPaid = null,
    Object? paymentMethod = null,
    Object? paidAt = freezed,
  }) {
    return _then(_$PaymentImpl(
      transactionId: null == transactionId
          ? _value.transactionId
          : transactionId // ignore: cast_nullable_to_non_nullable
              as String,
      amountPaid: null == amountPaid
          ? _value.amountPaid
          : amountPaid // ignore: cast_nullable_to_non_nullable
              as double,
      paymentMethod: null == paymentMethod
          ? _value.paymentMethod
          : paymentMethod // ignore: cast_nullable_to_non_nullable
              as String,
      paidAt: freezed == paidAt
          ? _value.paidAt
          : paidAt // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$PaymentImpl implements _Payment {
  const _$PaymentImpl(
      {required this.transactionId,
      required this.amountPaid,
      this.paymentMethod = 'Cash',
      this.paidAt});

  factory _$PaymentImpl.fromJson(Map<String, dynamic> json) =>
      _$$PaymentImplFromJson(json);

  @override
  final String transactionId;
  @override
  final double amountPaid;
  @override
  @JsonKey()
  final String paymentMethod;
  @override
  final String? paidAt;

  @override
  String toString() {
    return 'Payment(transactionId: $transactionId, amountPaid: $amountPaid, paymentMethod: $paymentMethod, paidAt: $paidAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PaymentImpl &&
            (identical(other.transactionId, transactionId) ||
                other.transactionId == transactionId) &&
            (identical(other.amountPaid, amountPaid) ||
                other.amountPaid == amountPaid) &&
            (identical(other.paymentMethod, paymentMethod) ||
                other.paymentMethod == paymentMethod) &&
            (identical(other.paidAt, paidAt) || other.paidAt == paidAt));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType, transactionId, amountPaid, paymentMethod, paidAt);

  /// Create a copy of Payment
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$PaymentImplCopyWith<_$PaymentImpl> get copyWith =>
      __$$PaymentImplCopyWithImpl<_$PaymentImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$PaymentImplToJson(
      this,
    );
  }
}

abstract class _Payment implements Payment {
  const factory _Payment(
      {required final String transactionId,
      required final double amountPaid,
      final String paymentMethod,
      final String? paidAt}) = _$PaymentImpl;

  factory _Payment.fromJson(Map<String, dynamic> json) = _$PaymentImpl.fromJson;

  @override
  String get transactionId;
  @override
  double get amountPaid;
  @override
  String get paymentMethod;
  @override
  String? get paidAt;

  /// Create a copy of Payment
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$PaymentImplCopyWith<_$PaymentImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

Invoice _$InvoiceFromJson(Map<String, dynamic> json) {
  return _Invoice.fromJson(json);
}

/// @nodoc
mixin _$Invoice {
  String get invoiceNo => throw _privateConstructorUsedError;
  String get title => throw _privateConstructorUsedError;
  double get amount => throw _privateConstructorUsedError;
  String? get dueDate => throw _privateConstructorUsedError;
  String get status => throw _privateConstructorUsedError;
  double get paidAmount => throw _privateConstructorUsedError;
  List<Payment> get payments => throw _privateConstructorUsedError;

  /// Serializes this Invoice to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of Invoice
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $InvoiceCopyWith<Invoice> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $InvoiceCopyWith<$Res> {
  factory $InvoiceCopyWith(Invoice value, $Res Function(Invoice) then) =
      _$InvoiceCopyWithImpl<$Res, Invoice>;
  @useResult
  $Res call(
      {String invoiceNo,
      String title,
      double amount,
      String? dueDate,
      String status,
      double paidAmount,
      List<Payment> payments});
}

/// @nodoc
class _$InvoiceCopyWithImpl<$Res, $Val extends Invoice>
    implements $InvoiceCopyWith<$Res> {
  _$InvoiceCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of Invoice
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? invoiceNo = null,
    Object? title = null,
    Object? amount = null,
    Object? dueDate = freezed,
    Object? status = null,
    Object? paidAmount = null,
    Object? payments = null,
  }) {
    return _then(_value.copyWith(
      invoiceNo: null == invoiceNo
          ? _value.invoiceNo
          : invoiceNo // ignore: cast_nullable_to_non_nullable
              as String,
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      amount: null == amount
          ? _value.amount
          : amount // ignore: cast_nullable_to_non_nullable
              as double,
      dueDate: freezed == dueDate
          ? _value.dueDate
          : dueDate // ignore: cast_nullable_to_non_nullable
              as String?,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as String,
      paidAmount: null == paidAmount
          ? _value.paidAmount
          : paidAmount // ignore: cast_nullable_to_non_nullable
              as double,
      payments: null == payments
          ? _value.payments
          : payments // ignore: cast_nullable_to_non_nullable
              as List<Payment>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$InvoiceImplCopyWith<$Res> implements $InvoiceCopyWith<$Res> {
  factory _$$InvoiceImplCopyWith(
          _$InvoiceImpl value, $Res Function(_$InvoiceImpl) then) =
      __$$InvoiceImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String invoiceNo,
      String title,
      double amount,
      String? dueDate,
      String status,
      double paidAmount,
      List<Payment> payments});
}

/// @nodoc
class __$$InvoiceImplCopyWithImpl<$Res>
    extends _$InvoiceCopyWithImpl<$Res, _$InvoiceImpl>
    implements _$$InvoiceImplCopyWith<$Res> {
  __$$InvoiceImplCopyWithImpl(
      _$InvoiceImpl _value, $Res Function(_$InvoiceImpl) _then)
      : super(_value, _then);

  /// Create a copy of Invoice
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? invoiceNo = null,
    Object? title = null,
    Object? amount = null,
    Object? dueDate = freezed,
    Object? status = null,
    Object? paidAmount = null,
    Object? payments = null,
  }) {
    return _then(_$InvoiceImpl(
      invoiceNo: null == invoiceNo
          ? _value.invoiceNo
          : invoiceNo // ignore: cast_nullable_to_non_nullable
              as String,
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      amount: null == amount
          ? _value.amount
          : amount // ignore: cast_nullable_to_non_nullable
              as double,
      dueDate: freezed == dueDate
          ? _value.dueDate
          : dueDate // ignore: cast_nullable_to_non_nullable
              as String?,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as String,
      paidAmount: null == paidAmount
          ? _value.paidAmount
          : paidAmount // ignore: cast_nullable_to_non_nullable
              as double,
      payments: null == payments
          ? _value._payments
          : payments // ignore: cast_nullable_to_non_nullable
              as List<Payment>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$InvoiceImpl implements _Invoice {
  const _$InvoiceImpl(
      {required this.invoiceNo,
      required this.title,
      required this.amount,
      this.dueDate,
      this.status = 'Unpaid',
      this.paidAmount = 0,
      final List<Payment> payments = const []})
      : _payments = payments;

  factory _$InvoiceImpl.fromJson(Map<String, dynamic> json) =>
      _$$InvoiceImplFromJson(json);

  @override
  final String invoiceNo;
  @override
  final String title;
  @override
  final double amount;
  @override
  final String? dueDate;
  @override
  @JsonKey()
  final String status;
  @override
  @JsonKey()
  final double paidAmount;
  final List<Payment> _payments;
  @override
  @JsonKey()
  List<Payment> get payments {
    if (_payments is EqualUnmodifiableListView) return _payments;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_payments);
  }

  @override
  String toString() {
    return 'Invoice(invoiceNo: $invoiceNo, title: $title, amount: $amount, dueDate: $dueDate, status: $status, paidAmount: $paidAmount, payments: $payments)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$InvoiceImpl &&
            (identical(other.invoiceNo, invoiceNo) ||
                other.invoiceNo == invoiceNo) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.amount, amount) || other.amount == amount) &&
            (identical(other.dueDate, dueDate) || other.dueDate == dueDate) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.paidAmount, paidAmount) ||
                other.paidAmount == paidAmount) &&
            const DeepCollectionEquality().equals(other._payments, _payments));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      invoiceNo,
      title,
      amount,
      dueDate,
      status,
      paidAmount,
      const DeepCollectionEquality().hash(_payments));

  /// Create a copy of Invoice
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$InvoiceImplCopyWith<_$InvoiceImpl> get copyWith =>
      __$$InvoiceImplCopyWithImpl<_$InvoiceImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$InvoiceImplToJson(
      this,
    );
  }
}

abstract class _Invoice implements Invoice {
  const factory _Invoice(
      {required final String invoiceNo,
      required final String title,
      required final double amount,
      final String? dueDate,
      final String status,
      final double paidAmount,
      final List<Payment> payments}) = _$InvoiceImpl;

  factory _Invoice.fromJson(Map<String, dynamic> json) = _$InvoiceImpl.fromJson;

  @override
  String get invoiceNo;
  @override
  String get title;
  @override
  double get amount;
  @override
  String? get dueDate;
  @override
  String get status;
  @override
  double get paidAmount;
  @override
  List<Payment> get payments;

  /// Create a copy of Invoice
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$InvoiceImplCopyWith<_$InvoiceImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

FeeLedger _$FeeLedgerFromJson(Map<String, dynamic> json) {
  return _FeeLedger.fromJson(json);
}

/// @nodoc
mixin _$FeeLedger {
  @JsonKey(readValue: _readId)
  String get id => throw _privateConstructorUsedError;
  String get madrasaId => throw _privateConstructorUsedError;
  String get studentId => throw _privateConstructorUsedError;
  String get academicYear => throw _privateConstructorUsedError;
  List<Invoice> get invoices => throw _privateConstructorUsedError;

  /// Serializes this FeeLedger to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of FeeLedger
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $FeeLedgerCopyWith<FeeLedger> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $FeeLedgerCopyWith<$Res> {
  factory $FeeLedgerCopyWith(FeeLedger value, $Res Function(FeeLedger) then) =
      _$FeeLedgerCopyWithImpl<$Res, FeeLedger>;
  @useResult
  $Res call(
      {@JsonKey(readValue: _readId) String id,
      String madrasaId,
      String studentId,
      String academicYear,
      List<Invoice> invoices});
}

/// @nodoc
class _$FeeLedgerCopyWithImpl<$Res, $Val extends FeeLedger>
    implements $FeeLedgerCopyWith<$Res> {
  _$FeeLedgerCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of FeeLedger
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? madrasaId = null,
    Object? studentId = null,
    Object? academicYear = null,
    Object? invoices = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      madrasaId: null == madrasaId
          ? _value.madrasaId
          : madrasaId // ignore: cast_nullable_to_non_nullable
              as String,
      studentId: null == studentId
          ? _value.studentId
          : studentId // ignore: cast_nullable_to_non_nullable
              as String,
      academicYear: null == academicYear
          ? _value.academicYear
          : academicYear // ignore: cast_nullable_to_non_nullable
              as String,
      invoices: null == invoices
          ? _value.invoices
          : invoices // ignore: cast_nullable_to_non_nullable
              as List<Invoice>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$FeeLedgerImplCopyWith<$Res>
    implements $FeeLedgerCopyWith<$Res> {
  factory _$$FeeLedgerImplCopyWith(
          _$FeeLedgerImpl value, $Res Function(_$FeeLedgerImpl) then) =
      __$$FeeLedgerImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(readValue: _readId) String id,
      String madrasaId,
      String studentId,
      String academicYear,
      List<Invoice> invoices});
}

/// @nodoc
class __$$FeeLedgerImplCopyWithImpl<$Res>
    extends _$FeeLedgerCopyWithImpl<$Res, _$FeeLedgerImpl>
    implements _$$FeeLedgerImplCopyWith<$Res> {
  __$$FeeLedgerImplCopyWithImpl(
      _$FeeLedgerImpl _value, $Res Function(_$FeeLedgerImpl) _then)
      : super(_value, _then);

  /// Create a copy of FeeLedger
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? madrasaId = null,
    Object? studentId = null,
    Object? academicYear = null,
    Object? invoices = null,
  }) {
    return _then(_$FeeLedgerImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      madrasaId: null == madrasaId
          ? _value.madrasaId
          : madrasaId // ignore: cast_nullable_to_non_nullable
              as String,
      studentId: null == studentId
          ? _value.studentId
          : studentId // ignore: cast_nullable_to_non_nullable
              as String,
      academicYear: null == academicYear
          ? _value.academicYear
          : academicYear // ignore: cast_nullable_to_non_nullable
              as String,
      invoices: null == invoices
          ? _value._invoices
          : invoices // ignore: cast_nullable_to_non_nullable
              as List<Invoice>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$FeeLedgerImpl implements _FeeLedger {
  const _$FeeLedgerImpl(
      {@JsonKey(readValue: _readId) required this.id,
      required this.madrasaId,
      required this.studentId,
      required this.academicYear,
      final List<Invoice> invoices = const []})
      : _invoices = invoices;

  factory _$FeeLedgerImpl.fromJson(Map<String, dynamic> json) =>
      _$$FeeLedgerImplFromJson(json);

  @override
  @JsonKey(readValue: _readId)
  final String id;
  @override
  final String madrasaId;
  @override
  final String studentId;
  @override
  final String academicYear;
  final List<Invoice> _invoices;
  @override
  @JsonKey()
  List<Invoice> get invoices {
    if (_invoices is EqualUnmodifiableListView) return _invoices;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_invoices);
  }

  @override
  String toString() {
    return 'FeeLedger(id: $id, madrasaId: $madrasaId, studentId: $studentId, academicYear: $academicYear, invoices: $invoices)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$FeeLedgerImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.madrasaId, madrasaId) ||
                other.madrasaId == madrasaId) &&
            (identical(other.studentId, studentId) ||
                other.studentId == studentId) &&
            (identical(other.academicYear, academicYear) ||
                other.academicYear == academicYear) &&
            const DeepCollectionEquality().equals(other._invoices, _invoices));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, madrasaId, studentId,
      academicYear, const DeepCollectionEquality().hash(_invoices));

  /// Create a copy of FeeLedger
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$FeeLedgerImplCopyWith<_$FeeLedgerImpl> get copyWith =>
      __$$FeeLedgerImplCopyWithImpl<_$FeeLedgerImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$FeeLedgerImplToJson(
      this,
    );
  }
}

abstract class _FeeLedger implements FeeLedger {
  const factory _FeeLedger(
      {@JsonKey(readValue: _readId) required final String id,
      required final String madrasaId,
      required final String studentId,
      required final String academicYear,
      final List<Invoice> invoices}) = _$FeeLedgerImpl;

  factory _FeeLedger.fromJson(Map<String, dynamic> json) =
      _$FeeLedgerImpl.fromJson;

  @override
  @JsonKey(readValue: _readId)
  String get id;
  @override
  String get madrasaId;
  @override
  String get studentId;
  @override
  String get academicYear;
  @override
  List<Invoice> get invoices;

  /// Create a copy of FeeLedger
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$FeeLedgerImplCopyWith<_$FeeLedgerImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
