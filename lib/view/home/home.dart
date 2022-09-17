import 'package:app_test/repository/movies_api.dart';
import 'package:app_test/models/movies_model.dart';
import 'package:app_test/shared/movies_card.dart';
import 'package:app_test/view/movie_detail/movie_detail_page.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _moviesApi = MoviesApi();
  List<Movies>? _movies;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    getMovies();
  }

  Future<void> getMovies() async {
    _movies = await _moviesApi.getListMovies();
    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const <Widget>[
            Icon(Icons.video_stable),
            SizedBox(width: 10),
            Text('Films')
          ],
        ),
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: _movies!.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => MovieDetailPage(
                              idMovie: _movies![index].id!.toString(),
                            )),
                  ),
                  child: RecipeCard(
                      title: _movies![index].title!,
                      date: _movies![index].releaseDate!,
                      rating: _movies![index].voteAverage.toString(),
                      thumbnailUrl: _movies![index].posterUrl!),
                );
              },
            ),
    );
  }
}
