import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:urban_match/src/services/api_services.dart';

part 'repository_event.dart';
part 'repository_state.dart';

class RepositoryBloc extends Bloc<RepositoryEvent, RepositoryState> {
  final ApiService apiService;
  int count = 0;
  RepositoryBloc({required this.apiService}) : super(RepositoryInitial()) {
    on<FetchPRCount>(onFetchCount);
  }

  onFetchCount(FetchPRCount event, emit) async {
    count = 0;
    try {
      count = await ApiService().getRepoPR(event.username, event.repo);
      emit(RepositoryLoaded());
    } catch (e) {
      emit(RepositoryError());
    }
  }
}
