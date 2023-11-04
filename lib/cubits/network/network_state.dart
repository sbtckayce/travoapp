part of 'network_cubit.dart';

class NetworkState extends Equatable {
  const NetworkState();

  @override
  List<Object> get props => [];
}

class OnNetwork extends NetworkState {}

class OffNetwork extends NetworkState {
  final String message;

  const OffNetwork({required this.message});
  @override
  List<Object> get props => [message];
}
