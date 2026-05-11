// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'rate_app_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(RateApp)
const rateAppProvider = RateAppProvider._();

final class RateAppProvider extends $AsyncNotifierProvider<RateApp, void> {
  const RateAppProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'rateAppProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$rateAppHash();

  @$internal
  @override
  RateApp create() => RateApp();
}

String _$rateAppHash() => r'7cd659f2219ff9776510c6ee7c22a4950aaf3848';

abstract class _$RateApp extends $AsyncNotifier<void> {
  FutureOr<void> build();
  @$mustCallSuper
  @override
  void runBuild() {
    build();
    final ref = this.ref as $Ref<AsyncValue<void>, void>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<void>, void>,
              AsyncValue<void>,
              Object?,
              Object?
            >;
    element.handleValue(ref, null);
  }
}
