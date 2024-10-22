import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pokemon_app/data/pokemon.dart';
import 'package:pokemon_app/repos/pokemon_repo.dart';

final pokemonFutureProvider = FutureProvider<List<Pokemon>>((ref) async {
  return await ref.watch(pokemonRepoProvider).getAllPokemons();
});

final counterStreamProvider = StreamProvider<int>((ref) async* {
  int counter = 0;
  while (counter < 20){
    await Future.delayed(const Duration(microseconds: 200));
         yield counter++;
  }
});


final counterStreamProvider2 = StreamProvider.autoDispose.family<int,int>((ref,counterStart) async* {
  int counter = counterStart;
  while (counter < 20){
    await Future.delayed(const Duration(microseconds: 200));
         yield counter++;
  }
});
// syntex
Future functionName() async {
  return 1;
}

Stream StreamName() async* {
  yield 1;
  Future.delayed(Duration(microseconds: 200));
    yield 2;
  Future.delayed(Duration(microseconds: 200));
    yield 3;
  Future.delayed(Duration(microseconds: 200));

}