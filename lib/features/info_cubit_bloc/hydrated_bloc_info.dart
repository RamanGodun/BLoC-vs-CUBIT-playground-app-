

/*
  HydratedBloc.storage = await HydratedStorage.build(
    storageDirectory: kIsWeb
        ? HydratedStorageDirectory.web
        : HydratedStorageDirectory((await getTemporaryDirectory())
            .path), // or better getApplicationDocumentsDirectory(), which not be deleted eventually
  );


Є можливість задавати сховище для кожного Bloc/Cubit окремо. Тепер HydratedBloc дозволяє перевизначити сховище на рівні окремого блоку або кубіта. 
Ви можете передати свій об’єкт, що реалізує інтерфейс Storage, прямо в конструктор HydratedBloc/ HydratedCubit. Це реалізовано у версії 10.0.0 ￼. 
Наприклад, можна створити власне зашифроване або альтернативне сховище і задати його для конкретного кубіта:

class SettingsCubit extends HydratedCubit<SettingsState> {
  SettingsCubit() : super(initialState, storage: CustomStorage());
   ...
}

Такий підхід дає гнучкість – різні гідратовані BLoC можуть зберігати дані в різних джерелах (наприклад, окремо кеш і окремо налаштування)
 */