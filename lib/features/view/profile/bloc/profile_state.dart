class ProfileState {}
class ProfileLoading extends ProfileState {}
class ProfileLoaded extends ProfileState {
  final Map<String, dynamic> userProfile;
  ProfileLoaded(this.userProfile);
}
class ProfileError extends ProfileState {
  final String error;
  ProfileError(this.error);
}