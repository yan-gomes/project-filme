import 'dart:ui';

import 'package:app_test/models/movies_detail_model.dart';
import 'package:app_test/repository/movies_api.dart';
import 'package:flutter/material.dart';

class MovieDetailPage extends StatefulWidget {
  final String? idMovie;
  const MovieDetailPage({super.key, this.idMovie});

  @override
  State<MovieDetailPage> createState() => _MovieDetailPageState();
}

class _MovieDetailPageState extends State<MovieDetailPage> {
  final _moviesApi = MoviesApi();
  MoviesDetail? _moviesDetail;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    getMovies();
  }

  Future<void> getMovies() async {
    _moviesDetail = await _moviesApi.getMoviesDetail(widget.idMovie!);
    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Detail movie"),
        centerTitle: true,
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : Stack(fit: StackFit.expand, children: [
              Image.network(
                _moviesDetail!.backdropUrl!,
                fit: BoxFit.cover,
              ),
              BackdropFilter(
                filter: ImageFilter.blur(
                  sigmaX: 5.0,
                  sigmaY: 5.0,
                ),
                child: Container(
                  color: Colors.black.withOpacity(0.5),
                ),
              ),
              SingleChildScrollView(
                child: Container(
                  margin: const EdgeInsets.all(20.0),
                  child: Column(
                    children: <Widget>[
                      Container(
                        alignment: Alignment.center,
                        child: Container(
                          width: 200.0,
                          height: 200.0,
                          child: Icon(
                            Icons.play_circle_fill,
                            size: 70,
                            color: Colors.white,
                          ),
                        ),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10.0),
                            image: DecorationImage(
                                image:
                                    NetworkImage(_moviesDetail!.backdropUrl!),
                                fit: BoxFit.cover),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black,
                                blurRadius: 20.0,
                                offset: Offset(0.0, 10.0),
                              )
                            ]),
                      ),
                      Container(
                        margin: const EdgeInsets.symmetric(
                            vertical: 20.0, horizontal: 0.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Expanded(
                              child: Text(
                                _moviesDetail!.title!,
                                style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 22,
                                    fontFamily: 'Arvo'),
                              ),
                            ),
                            Container(
                              padding: const EdgeInsets.all(5),
                              margin: const EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                color: Colors.black.withOpacity(0.4),
                                borderRadius: BorderRadius.circular(15),
                              ),
                              child: Row(
                                children: [
                                  const Icon(
                                    Icons.star,
                                    color: Colors.yellow,
                                    size: 18,
                                  ),
                                  const SizedBox(width: 7),
                                  Text(_moviesDetail!.voteAverage!.toString()),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      Text(
                        _moviesDetail!.overview!,
                        style: const TextStyle(
                            color: Colors.white,
                            fontFamily: 'Arvo',
                            fontSize: 16),
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          const Icon(
                            Icons.dataset,
                            color: Colors.yellow,
                            size: 18,
                          ),
                          const SizedBox(width: 7),
                          Text(_moviesDetail!.releaseDate!),
                        ],
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      Text(
                          "Original language: ${_moviesDetail!.originalLanguage!.toUpperCase()}"),
                      const SizedBox(
                        height: 10,
                      ),
                      Text("Popularity: ${_moviesDetail!.popularity!}"),
                    ],
                  ),
                ),
              )
            ]),
    );
  }
}
