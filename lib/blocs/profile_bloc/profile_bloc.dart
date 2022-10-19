import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:intl/intl.dart';
import 'package:sanity/blocs/home/home_bloc.dart';
import 'package:sanity/model/user_info_model.dart';
import 'package:sanity/repository/auth_repo.dart';
import 'package:sanity/repository/log_repository/log_repo.dart';
import 'package:sanity/repository/threads_repository/threds_repo.dart';

part 'profile_event.dart';
part 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  final HomeBloc _homeBloc;

  final AuthRepository auth = AuthRepository();
  final LogRepository log = LogRepository();
  final ThreadsRepo threadsRepo = ThreadsRepo();

  ProfileBloc({required HomeBloc homeBloc})
      : _homeBloc = homeBloc,
        super(ProfileLoading()) {
    on<FetchProfile>(_fetchProfile);
  }

  void _fetchProfile(FetchProfile event, Emitter<ProfileState> emit) async {
    try {
      final Map numbers = await auth.getNumbers(id: event.profileId);
      final Map threadMap = await threadsRepo.getThreadUser(event.profileId);
      if ((_homeBloc.state as HomeLoaded).user!.userId == event.profileId) {
        final Map logs = await log.retrieveLog(event.profileId);

        final DateFormat formatter = DateFormat('yyyy-MM-dd');
        Map listed = {};

        logs['candidates'].forEach((val) {
          listed[
              "${formatter.format(DateTime.parse(val['created_at'])).split("-")[1]}-${formatter.format(DateTime.parse(val['created_at'])).split("-")[2]}"] = {
            "log": val['log'],
            "score": val['depression_score']
          };
        });

        print(listed['10-19']);

        emit(ProfileFetched(
            timelineLog: listed,
            logs: logs['candidates'],
            threads: threadMap['threads'],
            owners: threadMap['user_info'],
            upVotes: threadMap['up_votes'],
            comments: threadMap['comments'],
            user: UserInfoModel.fromJson(numbers['candidates']),
            activeThreads: numbers['active'],
            entries: numbers['entries']));
      } else {
        emit(ProfileFetched(
          
            threads: threadMap['threads'],
            owners: threadMap['user_info'],
            upVotes: threadMap['up_votes'],
            comments: threadMap['comments'],
            user: UserInfoModel.fromJson(numbers['candidates']),
            activeThreads: numbers['active'],
            entries: numbers['entries']));
      }
    } catch (e) {
      emit(ProfileError());
    }
  }
}
