part of 'splash_bloc.dart';

@immutable
abstract class SplashState {}

class SplashInitial extends SplashState {}

final class NoCashedUserInfoDataExistState extends SplashState{}

final class ThereIsCashedUserInfoDataExistState extends SplashState{}