import 'package:flutter_riverpod/flutter_riverpod.dart';

class CompartmentBoardUiState {
  const CompartmentBoardUiState({
    required this.isZoomed,
  });

  final bool isZoomed;

  CompartmentBoardUiState copyWith({bool? isZoomed}) =>
      CompartmentBoardUiState(
        isZoomed: isZoomed ?? this.isZoomed,
      );
}

class CompartmentBoardUi extends Notifier<CompartmentBoardUiState> {
  @override
  CompartmentBoardUiState build() {
    return const CompartmentBoardUiState(isZoomed: false);
  }

  void toggleZoom() {
    state = state.copyWith(isZoomed: !state.isZoomed);
  }
}

final compartmentBoardUiProvider =
    NotifierProvider<CompartmentBoardUi, CompartmentBoardUiState>(
  CompartmentBoardUi.new,
);


