part of 'pagination_bloc.dart';

@immutable
abstract class PaginationEvent {}

final class GetNewPageEvent extends PaginationEvent{}