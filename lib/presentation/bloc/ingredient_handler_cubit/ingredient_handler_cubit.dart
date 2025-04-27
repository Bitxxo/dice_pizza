import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'ingredient_handler_state.dart';

class IngredientHandlerCubit extends Cubit<IngredientHandlerState> {
  IngredientHandlerCubit() : super(IngredientHandlerInitial());
}
