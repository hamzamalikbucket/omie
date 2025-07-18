part of 'omie_score_detail_bloc.dart';

/// [OmieScoreDetailState] - Base state class for Omie Score Detail screen
abstract class OmieScoreDetailState extends Equatable {
  const OmieScoreDetailState();

  @override
  List<Object> get props => [];
}

/// [OmieScoreDetailInitial] - Initial state
class OmieScoreDetailInitial extends OmieScoreDetailState {
  @override
  List<Object> get props => [];
}

/// [OmieScoreDetailLoading] - Loading state
class OmieScoreDetailLoading extends OmieScoreDetailState {
  @override
  List<Object> get props => [];
}

/// [OmieScoreDetailLoaded] - Loaded state with score data
class OmieScoreDetailLoaded extends OmieScoreDetailState {
  final OmieScoreData scoreData;

  const OmieScoreDetailLoaded(this.scoreData);

  @override
  List<Object> get props => [scoreData];
}

/// [OmieScoreDetailError] - Error state
class OmieScoreDetailError extends OmieScoreDetailState {
  final String message;

  const OmieScoreDetailError(this.message);

  @override
  List<Object> get props => [message];
}
