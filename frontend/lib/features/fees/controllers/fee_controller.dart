import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/network/dio_provider.dart';
import '../../../models/fee.dart';
import '../repositories/fee_repository.dart';

class FeeControllerState {
  final FeeLedger? ledger;
  final bool isLoading;
  final String? error;
  const FeeControllerState({this.ledger, this.isLoading = false, this.error});
  FeeControllerState copyWith({FeeLedger? ledger, bool? isLoading, String? error}) {
    return FeeControllerState(ledger: ledger ?? this.ledger, isLoading: isLoading ?? this.isLoading, error: error ?? this.error);
  }
}

class FeeController extends StateNotifier<FeeControllerState> {
  final FeeRepository _repo;
  FeeController(this._repo) : super(const FeeControllerState());
}

final feeControllerProvider = StateNotifierProvider<FeeController, FeeControllerState>((ref) {
  final dio = ref.read(dioClientProvider);
  return FeeController(FeeRepository(dio));
});
