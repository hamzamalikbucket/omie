part of 'omie_score_detail_bloc.dart';

/// [OmieScoreDetailEvent] - Base event class for Omie Score Detail screen
abstract class OmieScoreDetailEvent extends Equatable {
  const OmieScoreDetailEvent();

  @override
  List<Object> get props => [];
}

/// [LoadOmieScoreDetail] - Event to load Omie Score detail data
class LoadOmieScoreDetail extends OmieScoreDetailEvent {
  const LoadOmieScoreDetail();

  @override
  List<Object> get props => [];
}

/// [UpdateSelectedTimeFrame] - Event to update selected time frame
class UpdateSelectedTimeFrame extends OmieScoreDetailEvent {
  final String timeFrame;

  const UpdateSelectedTimeFrame(this.timeFrame);

  @override
  List<Object> get props => [timeFrame];
}
