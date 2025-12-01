// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'payment_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$paymentNotifierHash() => r'f8bb2fcb351d0a017b6b465ff470ef6b547e9e00';

/// See also [PaymentNotifier].
@ProviderFor(PaymentNotifier)
final paymentNotifierProvider =
    NotifierProvider<PaymentNotifier, PaymentState>.internal(
      PaymentNotifier.new,
      name: r'paymentNotifierProvider',
      debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$paymentNotifierHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

typedef _$PaymentNotifier = Notifier<PaymentState>;

String _$paymentHistoryNotifierHash() =>
    r'c3a4a4f61fca6b505f0d18f06cf4f75a94aa66f2';

/// See also [PaymentHistoryNotifier].
@ProviderFor(PaymentHistoryNotifier)
final paymentHistoryNotifierProvider =
    NotifierProvider<PaymentHistoryNotifier, PaymentHistoryState>.internal(
  PaymentHistoryNotifier.new,
  name: r'paymentHistoryNotifierProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$paymentHistoryNotifierHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$PaymentHistoryNotifier = Notifier<PaymentHistoryState>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
