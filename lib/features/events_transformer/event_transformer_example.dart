import 'package:bloc/bloc.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:equatable/equatable.dart';
import 'package:rxdart/rxdart.dart';

/// Кастомний Event Transformer для різних BLoC-ів
EventTransformer<E> customEventTransformer<E>(Type blocType) {
  if (blocType == SearchBloc) {
    return restartable<E>(); // Обробляє лише останній запит
  } else if (blocType == ScrollBloc) {
    return throttleDroppableCustom<E>(); // Запобігає частим запитам
  } else if (blocType == AuthBloc) {
    return droppable<E>(); // Ігнорує нові події, якщо попередня ще триває
  } else {
    return sequential<E>(); // За замовчуванням — послідовна обробка
  }
}

/// Дебаунс для пошукових запитів (для точності введення)
EventTransformer<E> debounceSequential<E>(
    {Duration duration = const Duration(milliseconds: 300)}) {
  return (events, mapper) {
    return events.debounceTime(duration).switchMap(mapper);
  };
}

/// Кастомний тротл, що дозволяє тільки одну подію в заданий проміжок часу
EventTransformer<E> throttleDroppableCustom<E>(
    {Duration duration = const Duration(seconds: 1)}) {
  return (events, mapper) {
    return events.throttleTime(duration, trailing: false).switchMap(mapper);
  };
}

/// ==================== SearchBloc ====================

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  SearchBloc() : super(SearchInitial()) {
    on<SearchQueryChanged>(
      (event, emit) async {
        await Future.delayed(const Duration(milliseconds: 500));
        emit(SearchLoaded(const ["Result 1", "Result 2", "Result 3"]));
      },
      transformer: customEventTransformer<SearchQueryChanged>(SearchBloc),
    );
  }
}

abstract class SearchEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class SearchQueryChanged extends SearchEvent {
  final String query;

  SearchQueryChanged(this.query);

  @override
  List<Object?> get props => [query];
}

abstract class SearchState extends Equatable {
  @override
  List<Object?> get props => [];
}

class SearchInitial extends SearchState {}

class SearchLoaded extends SearchState {
  final List<String> results;

  SearchLoaded(this.results);

  @override
  List<Object?> get props => [results];
}

/// ==================== ScrollBloc ====================

class ScrollBloc extends Bloc<ScrollEvent, ScrollState> {
  ScrollBloc() : super(ScrollInitial()) {
    on<LoadMoreItems>(
      (event, emit) async {
        await Future.delayed(const Duration(seconds: 1));
        emit(ScrollLoaded(const ["Item 1", "Item 2", "Item 3"]));
      },
      transformer: customEventTransformer<LoadMoreItems>(ScrollBloc),
    );
  }
}

abstract class ScrollEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class LoadMoreItems extends ScrollEvent {}

abstract class ScrollState extends Equatable {
  @override
  List<Object?> get props => [];
}

class ScrollInitial extends ScrollState {}

class ScrollLoaded extends ScrollState {
  final List<String> items;

  ScrollLoaded(this.items);

  @override
  List<Object?> get props => [items];
}

/// ==================== AuthBloc ====================

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc() : super(AuthInitial()) {
    on<LoginEvent>(
      (event, emit) async {
        await Future.delayed(const Duration(seconds: 2));
        emit(AuthLoggedIn("user_token_123"));
      },
      transformer: customEventTransformer<LoginEvent>(AuthBloc),
    );
  }
}

abstract class AuthEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class LoginEvent extends AuthEvent {
  final String username;
  final String password;

  LoginEvent(this.username, this.password);

  @override
  List<Object?> get props => [username, password];
}

abstract class AuthState extends Equatable {
  @override
  List<Object?> get props => [];
}

class AuthInitial extends AuthState {}

class AuthLoggedIn extends AuthState {
  final String token;

  AuthLoggedIn(this.token);

  @override
  List<Object?> get props => [token];
}

/// ==================== Кастомний Event Transformer ====================

EventTransformer<E> customMapEventTransformer<E>(Type blocType) {
  if (blocType == SearchBloc) {
    return (events, mapper) => events
        .debounceTime(const Duration(milliseconds: 300))
        .switchMap(mapper); // debounceTime для пошуку
  } else if (blocType == ScrollBloc) {
    return (events, mapper) => events
        .throttleTime(const Duration(seconds: 2))
        .switchMap(mapper); // throttleTime для скролу
  } else {
    return (events, mapper) => events.asyncExpand(mapper);
  }
}
