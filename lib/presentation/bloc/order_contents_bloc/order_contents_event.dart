part of 'order_contents_bloc.dart';

@immutable
sealed class OrderContentsEvent {}

final class Initial extends OrderContentsEvent {}

final class PizzaAdded extends OrderContentsEvent {}

final class PizzaRemoved extends OrderContentsEvent {}

final class PizzaEdited extends OrderContentsEvent {}
