import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pokemon_app/data/pokemon.dart';
import 'package:pokemon_app/repos/hive_repo.dart';
import 'package:pokemon_app/ui/widgets/rotating_widget.dart';
import 'package:pokemon_app/utils/extensions/build_context_extension.dart';
import 'package:pokemon_app/utils/extensions/helpers/helpers.dart';

class PokemonDetailScreen extends ConsumerStatefulWidget {
  const PokemonDetailScreen({super.key, required this.pokemon});
  final Pokemon pokemon;

  @override
  ConsumerState<PokemonDetailScreen> createState() => _PokemonDetailScreenState();
}

class _PokemonDetailScreenState extends ConsumerState<PokemonDetailScreen> {

  bool _isLiked = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Helpers.getPokemonCardColour(
          pokemonType: widget.pokemon.typeofpokemon!.first),
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.white),
        title: Text(
          widget.pokemon.name!,
          style:
              const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        //backgroundColor: const Color.fromARGB(255, 207, 162, 49),
        backgroundColor: Colors.transparent,
        actions: [
          IconButton(
            onPressed: (
             
            ) {
               ref.read(hiveRepoProvider).addPokemontohive(widget.pokemon);
                _isLiked = !_isLiked;
                setState(() {
                  
                });
            },
            icon: Icon(_isLiked ? Icons.favorite : Icons.favorite_border),
            color: Colors.white,
          )
        ],
      ),
      body: Stack(
        children: [
          //pokemon ball background image
          Positioned(
              top: 50,
              left: context.getWidth(percentage: 0.55) - 130,
              child: RotatingImageWidget()
              ),
          //bottom white background
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              decoration:  BoxDecoration(
                  //color: Colors.white,
                  color: Theme.of(context).scaffoldBackgroundColor,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(30),
                      topRight: Radius.circular(30))),
              height: context.getHeight(percentage: 0.60),
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  children: [
                    const SizedBox(
                      height: 10,
                    ),
                    Text(widget.pokemon.xdescription!),
                    PokemonDetailRowWidget( title: 'Type', data: widget.pokemon.typeofpokemon!.first,),
                    PokemonDetailRowWidget( title: 'Height', data: widget.pokemon.height!,),
                    PokemonDetailRowWidget( title: 'Weight', data: widget.pokemon.weight!,),
                    PokemonDetailRowWidget( title: 'Speed', data: widget.pokemon.speed.toString(),),
                    PokemonDetailRowWidget( title: 'Attack', data: widget.pokemon.attack.toString(),),
                    PokemonDetailRowWidget( title: 'Defence', data: widget.pokemon.defense.toString(),),
                    PokemonDetailRowWidget( title: 'Weakness', data: widget.pokemon.weaknesses!.join(','),),


                  ],
                ),
              ),
            ),
          ),
          //pokemon image
          Positioned(
            top: 50,
            left: context.getWidth(percentage: 0.55) - 130,
            child: Hero(
              tag: widget.pokemon.id!,
              child: CachedNetworkImage(
                imageUrl: widget.pokemon.imageurl!,
                width: 200,
                fit: BoxFit.fitWidth,
                placeholder: (context, url) =>
                    const CircularProgressIndicator(),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class PokemonDetailRowWidget extends StatelessWidget {
  const PokemonDetailRowWidget({
    required this.title, required this.data,
  });

  //final PokemonDetailScreen widget;
    final String title;
  final String data;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          SizedBox(
              width: context.getWidth(percentage: 0.3),
              child: Text(
                title,
                style: TextStyle(
                    fontSize: 12, fontWeight: FontWeight.bold),
              )),
          //Text(widget.pokemon.typeofpokemon!.join(',')),
          SizedBox(
            width: 200,
            child: Text(data,
            maxLines: 2,
            style: TextStyle(
               fontSize: 12, fontWeight: FontWeight.normal
            ),),
          )
        ],
      ),
    );
  }
}
