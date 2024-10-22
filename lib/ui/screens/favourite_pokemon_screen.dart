import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pokemon_app/data/pokemon.dart';
import 'package:pokemon_app/providers/pokemon_future_provider.dart';
import 'package:pokemon_app/repos/hive_repo.dart';

class FavouritePokemonScreen extends ConsumerStatefulWidget {
  const FavouritePokemonScreen({super.key});

  @override
  ConsumerState<FavouritePokemonScreen> createState() => _FavouritePokemonScreenState();
}

class _FavouritePokemonScreenState extends ConsumerState<FavouritePokemonScreen> {
  List<Pokemon> favPokemonList = [];
  @override
  void initState(){
    super.initState();
    Future.microtask(()async {
        await ref.read(hiveRepoProvider)
        .getAllPokemonsFromHive()
        .then((pokemonList){
              log(pokemonList.length.toString());
              //log(pokemonList.toList().first.name!);
              setState(() {
                favPokemonList = pokemonList;
              });
        });
    });

  }
  @override
  Widget build(BuildContext context) {
    final AsyncValue<int> counterProvider = ref.watch(counterStreamProvider2(5));
    return Scaffold(
      appBar: AppBar(
            title:Text('Favourite Pokemons',style: TextStyle(
              fontSize: 12,
            ),)
      ),
      body: counterProvider.when(data: (data){
        return Center(
          child:Text(data.toString()),
        );
           
      }, error: (error, stk){
          return Center(
          child:Text('Error:,$error'),
        );
      }, loading: (){
        return const Center (
          child:CircularProgressIndicator(),
        );

      })
    );
  }
}