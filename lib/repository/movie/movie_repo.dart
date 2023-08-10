abstract class MoviesRepo {
  Future getMovies() async {}
  Future getMovieDetail(int id) async {}
  Future getMovieTrailerUrl(int id) async {}
}
