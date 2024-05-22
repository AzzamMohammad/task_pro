import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import '../../data/repositories/splash_repository.dart';

part 'splash_event.dart';

part 'splash_state.dart';

class SplashBloc extends Bloc<SplashEvent, SplashState> {
  SplashRepository splashRepository = SplashRepository();
  SplashBloc() : super(SplashInitial()) {
    on<GetTargetPageEvent>(_onGetTargetPage);
  }

  void _onGetTargetPage(
    GetTargetPageEvent event,
    Emitter<SplashState> emit,
  )async {
    // Checks if there is stored user info data
    bool isStoredUserInfoExist = await splashRepository.checksIfThereIsStoredUserInfo();
    if(isStoredUserInfoExist){
      // we can rout to home page
      emit(ThereIsCashedUserInfoDataExistState());
    }else{
      // we can not rout to home page so we rout to intro page
      emit(NoCashedUserInfoDataExistState());
    }
  }
}
