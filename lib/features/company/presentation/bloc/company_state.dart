part of 'company_cubit.dart';

@immutable
sealed class CompanyState extends Equatable {
  const CompanyState();

  T when<T>({
    required T Function() initial,
    required T Function() loading,
    required T Function(List<Company> companies) success,
    required T Function(String message) error,
    required T Function() tryAgain,
  }) {
    if (this is CompanyInitial) {
      return initial();
    } else if (this is CompanyLoading) {
      return loading();
    } else if (this is CompanySuccess) {
      return success((this as CompanySuccess).companies);
    } else if (this is CompanyError) {
      return error((this as CompanyError).message);
    } else if (this is CompanyTryAgain) {
      return tryAgain();
    }
    throw Exception('Unreachable');
  }

  T maybeWhen<T>({
    T Function()? initial,
    T Function()? loading,
    T Function(List<Company> companies)? success,
    T Function(String message)? error,
    T Function()? tryAgain,
    required T Function() orElse,
  }) {
    if (this is CompanyInitial && initial != null) {
      return initial();
    } else if (this is CompanyLoading && loading != null) {
      return loading();
    } else if (this is CompanySuccess && success != null) {
      return success((this as CompanySuccess).companies);
    } else if (this is CompanyError && error != null) {
      return error((this as CompanyError).message);
    } else if (this is CompanyTryAgain && tryAgain != null) {
      return tryAgain();
    } else {
      return orElse();
    }
  }

  T? whenOrNull<T>({
    T Function()? initial,
    T Function()? loading,
    T Function(List<Company> companies)? success,
    T Function(String message)? error,
    T Function()? tryAgain,
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

final class CompanyInitial extends CompanyState {}

final class CompanyLoading extends CompanyState {}

final class CompanySuccess extends CompanyState {
  final List<Company> companies;

  const CompanySuccess({required this.companies});

  @override
  List<Object?> get props => [companies];
}

final class CompanyError extends CompanyState {
  final String message;

  const CompanyError({required this.message});

  @override
  List<Object?> get props => [message];
}

final class CompanyTryAgain extends CompanyState {}
