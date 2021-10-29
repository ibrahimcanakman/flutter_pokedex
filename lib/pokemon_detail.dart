import 'package:flutter/material.dart';
import 'package:flutter_pokedex/model/pokedex.dart';
import 'package:palette_generator/palette_generator.dart';

class PokemonDetail extends StatefulWidget {
  final PokedexPokemon? pokemon;

  const PokemonDetail({required this.pokemon, Key? key}) : super(key: key);

  @override
  State<PokemonDetail> createState() => _PokemonDetailState();
}

class _PokemonDetailState extends State<PokemonDetail> {
  late PaletteGenerator paletteGenerator;
  Color baskinRenk = Colors.deepOrange.shade100;

  @override
  void initState() {
    super.initState();
    baskinRengiBul();
  }

  void baskinRengiBul() {
    Future<PaletteGenerator> fPaletGenerator =
        PaletteGenerator.fromImageProvider(
            NetworkImage(widget.pokemon!.img.toString()));
    fPaletGenerator.then((value) {
      paletteGenerator = value;
      debugPrint(
          "secilen renk :" + paletteGenerator.dominantColor!.color.toString());

      setState(() {
        baskinRenk = paletteGenerator.dominantColor!.color;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
        backgroundColor: baskinRenk,
        appBar: AppBar(
          backgroundColor: baskinRenk,
          elevation: 0,
          title: Text(
            widget.pokemon!.name.toString(),
            textAlign: TextAlign.center,
          ),
        ),
        body: OrientationBuilder(builder: (context, orientation) {
          if (orientation == Orientation.portrait) {
            return dikeyBody(size);
          } else {
            return yatayBody(size);
          }
        }));
  }

  Widget yatayBody(Size size) {
    return Container(
      width: size.width,
      height: size.height * 0.75,
      margin: const EdgeInsets.symmetric(horizontal: 20),
      decoration: BoxDecoration(
          border: Border.all(color: Colors.white),
          borderRadius: BorderRadius.circular(15),
          color: Colors.white),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Flexible(
            flex: 1,
            child: Container(
              padding: const EdgeInsets.only(left: 40),
              width: size.width,
              height: size.height,
              child: Image.network(
                widget.pokemon!.img.toString(),
                fit: BoxFit.fill,
              ),
            ),
          ),
          Flexible(
            flex: 2,
            child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Column(
                children: [
                  SizedBox(
                    height: size.height / 30,
                  ),
                  Text(
                    widget.pokemon!.name.toString(),
                    style: const TextStyle(
                        fontSize: 25, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: size.height / 60),
                  Text('Height: ' + widget.pokemon!.height.toString()),
                  Text('Weight: ' + widget.pokemon!.weight.toString()),
                  SizedBox(height: size.height / 30),
                  const Text('Types: ',
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                  Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: widget.pokemon!.type!
                          .map((tip) => Chip(
                              backgroundColor: Colors.deepOrange.shade300,
                              label: Text(
                                tip.toString(),
                                style: const TextStyle(color: Colors.white),
                              )))
                          .toList()),
                  const Text('Pre Evolutions: ',
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                  Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: widget.pokemon!.prevEvolution != null
                          ? widget.pokemon!.prevEvolution!
                              .map((evolution) => Chip(
                                  backgroundColor: Colors.deepOrange.shade300,
                                  label: Text(
                                    evolution!.name.toString(),
                                    style: const TextStyle(color: Colors.white),
                                  )))
                              .toList()
                          : [
                              Column(children: [
                                SizedBox(height: size.height / 100),
                                const Text(
                                  'İlk Hali',
                                  style: TextStyle(),
                                ),
                                SizedBox(height: size.height / 100),
                              ])
                            ]),
                  const Text('Next Evolutions: ',
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                  Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: widget.pokemon!.nextEvolution != null
                          ? widget.pokemon!.nextEvolution!
                              .map((evolution) => Chip(
                                  backgroundColor: Colors.deepOrange.shade300,
                                  label: Text(
                                    evolution!.name.toString(),
                                    style: const TextStyle(color: Colors.white),
                                  )))
                              .toList()
                          : [
                              Column(children: [
                                SizedBox(height: size.height / 100),
                                const Text(
                                  'Son Hali',
                                  style: TextStyle(),
                                ),
                                SizedBox(height: size.height / 100),
                              ])
                            ]),
                  const Text('Weakness: ',
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                  Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: widget.pokemon!.weaknesses != null
                          ? widget.pokemon!.weaknesses!
                              .map((weakness) => Chip(
                                  backgroundColor: Colors.deepOrange.shade300,
                                  label: Text(
                                    weakness.toString(),
                                    style: const TextStyle(color: Colors.white),
                                  )))
                              .toList()
                          : [
                              Column(children: [
                                SizedBox(height: size.height / 100),
                                const Text(
                                  'Zayıflığı Yok',
                                  style: TextStyle(),
                                ),
                                SizedBox(height: size.height / 100),
                              ])
                            ])
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  Stack dikeyBody(Size size) {
    return Stack(
      children: [
        Positioned(
          height: size.height * 0.7,
          width: size.width * 0.968,
          left: size.width * 0.02,
          top: size.height * 0.1,
          child: Card(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
            elevation: 6,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                SizedBox(
                  height: size.height * 0.07,
                ),
                Text(
                  widget.pokemon!.name.toString(),
                  style: const TextStyle(
                      fontSize: 25, fontWeight: FontWeight.bold),
                ),
                Text('Height: ' + widget.pokemon!.height.toString()),
                Text('Weight: ' + widget.pokemon!.weight.toString()),
                const Text('Types: ',
                    style:
                        TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: widget.pokemon!.type!
                        .map((tip) => Chip(
                            backgroundColor: Colors.deepOrange.shade300,
                            label: Text(
                              tip.toString(),
                              style: const TextStyle(color: Colors.white),
                            )))
                        .toList()),
                const Text('Pre Evolutions: ',
                    style:
                        TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: widget.pokemon!.prevEvolution != null
                        ? widget.pokemon!.prevEvolution!
                            .map((evolution) => Chip(
                                backgroundColor: Colors.deepOrange.shade300,
                                label: Text(
                                  evolution!.name.toString(),
                                  style: const TextStyle(color: Colors.white),
                                )))
                            .toList()
                        : [const Text('İlk Hali')]),
                const Text('Next Evolutions: ',
                    style:
                        TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: widget.pokemon!.nextEvolution != null
                        ? widget.pokemon!.nextEvolution!
                            .map((evolution) => Chip(
                                backgroundColor: Colors.deepOrange.shade300,
                                label: Text(
                                  evolution!.name.toString(),
                                  style: const TextStyle(color: Colors.white),
                                )))
                            .toList()
                        : [const Text('Son Hali')]),
                const Text('Weakness: ',
                    style:
                        TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: widget.pokemon!.weaknesses != null
                        ? widget.pokemon!.weaknesses!
                            .map((weakness) => Chip(
                                labelStyle: const TextStyle(fontSize: 13),
                                backgroundColor: Colors.deepOrange.shade300,
                                label: Text(
                                  weakness.toString(),
                                  style: const TextStyle(color: Colors.white),
                                )))
                            .toList()
                        : [const Text('Zayıflığı Yok')])
              ],
            ),
          ),
        ),
        Align(
          alignment: Alignment.topCenter,
          child: Hero(
            tag: widget.pokemon!.img.toString(),
            child: SizedBox(
              height: size.height * 0.2,
              width: size.width * 0.4,
              child: Image.network(
                widget.pokemon!.img.toString(),
                fit: BoxFit.contain,
              ),
            ),
          ),
        )
      ],
    );
  }
}
