import 'dart:async';

import 'package:flutter_pokedex/model/pokedex.dart';
import 'package:flutter_pokedex/pokemon_detail.dart';
import "package:http/http.dart" as http;
import 'package:flutter/material.dart';
import 'dart:convert';

class PokemonList extends StatefulWidget {
  const PokemonList({Key? key}) : super(key: key);

  @override
  _PokemonListState createState() => _PokemonListState();
}

class _PokemonListState extends State<PokemonList> {
  Uri url = Uri.parse(
      "https://raw.githubusercontent.com/Biuni/PokemonGO-Pokedex/master/pokedex.json");

  late Pokedex pokedex;
  late Future<Pokedex> veri;

  Future<Pokedex> pokemonlariGetir() async {
    var response = await http.get(url);
    var decodeJson = jsonDecode(response.body);
    pokedex = Pokedex.fromJson(decodeJson);
    return pokedex;
  }

  @override
  void initState() {
    super.initState();
    veri = pokemonlariGetir();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Pokedex'),
        ),
        body: OrientationBuilder(
          builder: (context, orientatin) {
            if (orientatin == Orientation.portrait) {
              return FutureBuilder(
                  future: veri,
                  builder: (context, AsyncSnapshot<Pokedex> gelenPokedex) {
                    if (gelenPokedex.connectionState ==
                        ConnectionState.waiting) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    } else if (gelenPokedex.connectionState ==
                        ConnectionState.done) {
                      // return GridView.builder(
                      //     itemCount: gelenPokedex.data!.pokemon!.length,
                      //     gridDelegate:
                      //         const SliverGridDelegateWithFixedCrossAxisCount(
                      //             crossAxisCount: 2),
                      //     itemBuilder: (context, index) {
                      //       return Text(
                      //           gelenPokedex.data!.pokemon![index]!.name.toString());
                      //     });
                      return GridView.count(
                        crossAxisCount: 2,
                        children: gelenPokedex.data!.pokemon!.map((poke) {
                          return InkWell(
                            onTap: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => PokemonDetail(
                                        pokemon: poke,
                                      )));
                            },
                            child: Hero(
                              tag: poke!.img.toString(),
                              child: Card(
                                  elevation: 6,
                                  child: Column(
                                    children: [
                                      Expanded(
                                        child: SizedBox(
                                          height: 100,
                                          width: 100,
                                          child: FadeInImage.assetNetwork(
                                              placeholder: 'assets/loading.gif',
                                              image: poke.img.toString()),
                                        ),
                                      ),
                                      SizedBox(
                                        height:
                                            MediaQuery.of(context).size.height *
                                                0.03,
                                      ),
                                      Text(
                                        poke.name.toString(),
                                        style: const TextStyle(
                                            fontSize: 22,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.black),
                                      )
                                    ],
                                  )),
                            ),
                          );
                        }).toList(),
                      );
                    } else {
                      return const Text('hata');
                    }
                  });
            } else {
              return FutureBuilder(
                  future: veri,
                  builder: (context, AsyncSnapshot<Pokedex> gelenPokedex) {
                    if (gelenPokedex.connectionState ==
                        ConnectionState.waiting) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    } else if (gelenPokedex.connectionState ==
                        ConnectionState.done) {
                      // return GridView.builder(
                      //     itemCount: gelenPokedex.data!.pokemon!.length,
                      //     gridDelegate:
                      //         const SliverGridDelegateWithFixedCrossAxisCount(
                      //             crossAxisCount: 2),
                      //     itemBuilder: (context, index) {
                      //       return Text(
                      //           gelenPokedex.data!.pokemon![index]!.name.toString());
                      //     });
                      return GridView.extent(
                        maxCrossAxisExtent: 200,
                        children: gelenPokedex.data!.pokemon!.map((poke) {
                          return InkWell(
                            onTap: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => PokemonDetail(
                                        pokemon: poke,
                                      )));
                            },
                            child: Hero(
                              tag: poke!.img.toString(),
                              child: Card(
                                  elevation: 6,
                                  child: Column(
                                    children: [
                                      SizedBox(
                                        height: 100,
                                        width: 100,
                                        child: FadeInImage.assetNetwork(
                                            placeholder: 'assets/loading.gif',
                                            image: poke.img.toString()),
                                      ),
                                      Text(
                                        poke.name.toString(),
                                        style: const TextStyle(
                                            fontSize: 22,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.black),
                                      )
                                    ],
                                  )),
                            ),
                          );
                        }).toList(),
                      );
                    } else {
                      return const Text('hata');
                    }
                  });
            }
          },
        ));
  }
}
