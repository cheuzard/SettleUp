// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_database_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(totalAmountOwed)
const totalAmountOwedProvider = TotalAmountOwedProvider._();

final class TotalAmountOwedProvider
    extends $FunctionalProvider<AsyncValue<double>, double, Stream<double>>
    with $FutureModifier<double>, $StreamProvider<double> {
  const TotalAmountOwedProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'totalAmountOwedProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$totalAmountOwedHash();

  @$internal
  @override
  $StreamProviderElement<double> $createElement($ProviderPointer pointer) =>
      $StreamProviderElement(pointer);

  @override
  Stream<double> create(Ref ref) {
    return totalAmountOwed(ref);
  }
}

String _$totalAmountOwedHash() => r'2492e86958fc317e068305bc06faf18c342870fc';

@ProviderFor(totalAmountPayed)
const totalAmountPayedProvider = TotalAmountPayedProvider._();

final class TotalAmountPayedProvider
    extends $FunctionalProvider<AsyncValue<double>, double, Stream<double>>
    with $FutureModifier<double>, $StreamProvider<double> {
  const TotalAmountPayedProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'totalAmountPayedProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$totalAmountPayedHash();

  @$internal
  @override
  $StreamProviderElement<double> $createElement($ProviderPointer pointer) =>
      $StreamProviderElement(pointer);

  @override
  Stream<double> create(Ref ref) {
    return totalAmountPayed(ref);
  }
}

String _$totalAmountPayedHash() => r'5e4c5aaaef1a7d14ef788d56fa61a35455bf132f';
