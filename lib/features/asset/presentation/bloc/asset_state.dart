part of 'asset_cubit.dart';

@immutable
sealed class AssetState extends Equatable {
  const AssetState();

  T when<T>({
    required T Function() initial,
    required T Function() loading,
    required T Function(List<LocationTreeModel> locations) success,
    required T Function(String message) error,
  }) {
    if (this is AssetInitial) {
      return initial();
    } else if (this is AssetLoading) {
      return loading();
    } else if (this is AssetSuccess) {
      return success((this as AssetSuccess).locations);
    } else if (this is AssetError) {
      return error((this as AssetError).message);
    }
    throw Exception('Unreachable');
  }

  T maybeWhen<T>({
    T Function()? initial,
    T Function()? loading,
    T Function(List<LocationTreeModel> locations)? success,
    T Function(String message)? error,
    required T Function() orElse,
  }) {
    if (this is AssetInitial && initial != null) {
      return initial();
    } else if (this is AssetLoading && loading != null) {
      return loading();
    } else if (this is AssetSuccess && success != null) {
      return success((this as AssetSuccess).locations);
    } else if (this is AssetError && error != null) {
      return error((this as AssetError).message);
    } else {
      return orElse();
    }
  }

  T? whenOrNull<T>({
    T Function()? initial,
    T Function()? loading,
    T Function(List<LocationTreeModel> locations)? success,
    T Function(String message)? error,
  }) {
    return maybeWhen(
      initial: initial,
      loading: loading,
      success: success,
      error: error,
      orElse: () => null,
    );
  }

  @override
  List<Object?> get props => [];
}

final class AssetInitial extends AssetState {}

final class AssetLoading extends AssetState {}

final class AssetSuccess extends AssetState {
  final List<LocationTreeModel> locations;

  const AssetSuccess({required this.locations});

  @override
  List<Object?> get props => [locations];
}

final class AssetError extends AssetState {
  final String message;

  const AssetError({required this.message});

  @override
  List<Object?> get props => [message];
}
