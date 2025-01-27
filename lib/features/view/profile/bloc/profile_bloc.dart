import 'package:bloc/bloc.dart';
import 'package:food_app/features/view/profile/bloc/profile_event.dart';
import 'package:food_app/features/view/profile/bloc/profile_state.dart';
import '../../../../utils/helper/firedb_helper.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  final FireDbHelper dbHelper;
  ProfileBloc(this.dbHelper) : super(ProfileLoading());

  Stream<ProfileState> mapEventToState(ProfileEvent event) async* {
    if (event is LoadProfile) {
      yield ProfileLoading();
      try {
        final userProfile = {'name': '', 'email': ''};
        yield ProfileLoaded(userProfile);
      } catch (e) {
        yield ProfileError(e.toString());
      }
    }
  }
}

