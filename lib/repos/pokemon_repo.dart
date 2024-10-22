import 'dart:convert';
import 'dart:developer';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pokemon_app/data/pokemon.dart';
import 'package:pokemon_app/network/constants.dart';
import 'package:pokemon_app/network/dio_client.dart';

class PokemonRepo {
  final Ref ref;
  PokemonRepo(this.ref);

  Future <List<Pokemon>> getAllPokemons() async {
    try {
      final response = await ref.read(dioProvider).get(POKEMON_API_URL);
      if (response.statusCode == 200) {
        final decodedJson = jsonDecode(response.data);
        final List<Pokemon> pokemonList = decodedJson
        .map<Pokemon>((pokemon) => Pokemon.fromJson(pokemon))
        .toList();
        log(pokemonList.first.name!);
        return pokemonList;
      }
      else{
        throw Exception('Failed to load pokemons');

      }
      //log(response.data.toString());
    } catch (e) {
      log(e.toString());
      throw Exception(e);
    }
  }
}

final pokemonRepoProvider = Provider<PokemonRepo>((ref) => PokemonRepo(ref));