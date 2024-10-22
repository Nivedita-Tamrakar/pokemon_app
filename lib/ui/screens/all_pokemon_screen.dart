import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pokemon_app/data/pokemon.dart';
import 'package:pokemon_app/providers/pokemon_future_provider.dart';
import 'package:pokemon_app/providers/theme_provider.dart';
import 'package:pokemon_app/repos/pokemon_repo.dart';
import 'package:pokemon_app/ui/screens/favourite_pokemon_screen.dart';
import 'package:pokemon_app/ui/screens/pokemon_detail_screen.dart';
import 'package:pokemon_app/utils/extensions/build_context_extension.dart';
import 'package:pokemon_app/utils/extensions/helpers/helpers.dart';

class AllPokemonScreen extends ConsumerWidget {
  const AllPokemonScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final AsyncValue<List<Pokemon>> pokemonList =
        ref.watch(pokemonFutureProvider);
    return Scaffold(
        appBar: AppBar(
          title: const Text("Pokedex",
          ),
          //backgroundColor: const Color.fromARGB(255, 207, 162, 49),
          backgroundColor: Colors.transparent,
          actions: [
            IconButton(onPressed: (){
              //  Navigator.push(
              //                   context, MaterialPageRoute(builder: (_) => FavouritePokemonScreen()));
              context.go(const FavouritePokemonScreen());
                    
            }, icon: Icon(Icons.favorite)),
            IconButton(onPressed: (){
                //  Navigator.push(
                //                 context, MaterialPageRoute(builder: (_) => PokemonDetailScreen()));
            ref.read(themeProvider.notifier).toggleTheme();
            }, icon: Icon(Icons.lightbulb))
          ],
        ),
        body: pokemonList.when(data: (data) {
          return GridView.builder(
              itemCount: data.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 5,
                  mainAxisSpacing: 5,
                  childAspectRatio: 2 / 2),
              itemBuilder: (context, index) {
                return InkWell(
                  onTap: (){
                    context.go(PokemonDetailScreen(pokemon: data[index]));
                  },

                  child: Card(
                    color: Helpers.getPokemonCardColour(pokemonType: data[index]!.typeofpokemon!.first),
                    child: Stack(
                      children: [
                        Positioned(
                          right: -10,
                          bottom: -10,
                          child: Image.asset('images/pokeball.png',
                          height: 150,
                          fit:BoxFit.cover,),
                        ),
                        Positioned(
                          right: 0,
                          bottom: 0,
                          child: Hero(
                            tag: data[index].id!,
                            child: CachedNetworkImage(
                              imageUrl: data[index].imageurl!,
                              height: 130,
                              fit: BoxFit.cover,
                              placeholder: (context, url) => const Center(
                                child: CircularProgressIndicator(),
                              ),
                              errorWidget: (context, url, error) =>
                                  const Icon(Icons.error),
                            ),
                          ),
                        ),
                        Positioned(
                          left: 10,
                          top: 10,
                          child:  Text( data[index].name!,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        ),
                        Positioned(
                          left: 10,
                          top: 40,
                          child: Container(
                              decoration: BoxDecoration(
                                color: Colors.black.withOpacity(0.5),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Center(
                                    child:Padding(padding: const EdgeInsets.symmetric(vertical: 2,horizontal: 10),
                                    child: Text(
                                      data[index].typeofpokemon!.first,
                                      style: const TextStyle(color: Colors.white),
                                    ),
                                    )
                              ),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              });
        }, error: (error, stk) {
          return Center(
            child: Text(error.toString()),
          );
        }, loading: () {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }));
  }
}
