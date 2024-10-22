import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive/hive.dart';
import 'package:pokemon_app/data/pokemon.dart';

class HiveRepo {
  final pokemonBoxName = 'pokemonBox1';

  void registerAdapter(){
    Hive.registerAdapter(PokemonAdapter());
  }

  Future addPokemontohive(Pokemon pokemon) async {
    final pokemonBox = await Hive.openBox(pokemonBoxName);
    if(pokemonBox.isOpen){
          //await pokemonBox.add(pokeman); //in add key is auto incremented while in put we provide key 
          await pokemonBox.put(pokemon.id, pokemon);
          //pokemonBox.close();
          //Hive.close();
    }else{
      throw Exception("box is not open");
    }
  }
  Future deletePokemonFromHive(String id ) async {
    final pokemonBox = await Hive.openBox(pokemonBoxName);
    if(pokemonBox.isOpen){
          await pokemonBox.delete(id);
    }else{
      throw Exception("box is not open");
    }
  }

  Future <List<Pokemon>> getAllPokemonsFromHive() async {
    final pokemonBox = await Hive.openBox<Pokemon>(pokemonBoxName);
    if(pokemonBox.isOpen){
          return pokemonBox.values.toList();
    }else{
      throw Exception("box is not open");
    }
  }

Future <Pokemon >getSinglePokemonFromHive(String id) async {
    final pokemonBox = await Hive.openBox<Pokemon>(pokemonBoxName);
    if(pokemonBox.isOpen){
          return pokemonBox.get(id)!;
    }else{
      throw Exception("box is not open");
    }
  }


}
final hiveRepoProvider = Provider<HiveRepo>((ref) => HiveRepo());