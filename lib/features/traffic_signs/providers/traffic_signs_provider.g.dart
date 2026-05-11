// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'traffic_signs_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(signsService)
const signsServiceProvider = SignsServiceProvider._();

final class SignsServiceProvider
    extends $FunctionalProvider<SignsService, SignsService, SignsService>
    with $Provider<SignsService> {
  const SignsServiceProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'signsServiceProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$signsServiceHash();

  @$internal
  @override
  $ProviderElement<SignsService> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  SignsService create(Ref ref) {
    return signsService(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(SignsService value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<SignsService>(value),
    );
  }
}

String _$signsServiceHash() => r'5a1f3c3056b757fdbcfe597988650d36469affde';

@ProviderFor(signsData)
const signsDataProvider = SignsDataProvider._();

final class SignsDataProvider
    extends
        $FunctionalProvider<
          AsyncValue<SignsData>,
          SignsData,
          FutureOr<SignsData>
        >
    with $FutureModifier<SignsData>, $FutureProvider<SignsData> {
  const SignsDataProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'signsDataProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$signsDataHash();

  @$internal
  @override
  $FutureProviderElement<SignsData> $createElement($ProviderPointer pointer) =>
      $FutureProviderElement(pointer);

  @override
  FutureOr<SignsData> create(Ref ref) {
    return signsData(ref);
  }
}

String _$signsDataHash() => r'cbeee4b1fcd8668b2d47baa9d171d630cff18e42';

@ProviderFor(SelectedCategory)
const selectedCategoryProvider = SelectedCategoryProvider._();

final class SelectedCategoryProvider
    extends $NotifierProvider<SelectedCategory, String?> {
  const SelectedCategoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'selectedCategoryProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$selectedCategoryHash();

  @$internal
  @override
  SelectedCategory create() => SelectedCategory();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(String? value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<String?>(value),
    );
  }
}

String _$selectedCategoryHash() => r'bace2749ee823648d1a15a76b76524bbc9e0fa29';

abstract class _$SelectedCategory extends $Notifier<String?> {
  String? build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref = this.ref as $Ref<String?, String?>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<String?, String?>,
              String?,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}
