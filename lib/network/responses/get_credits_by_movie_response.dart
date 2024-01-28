import '../../data/vos/credit_vo.dart';

class GetCreditsByMovieResponse {
  int? id;

  List<CreditVO>? cast;

  List<CreditVO>? crew;

  GetCreditsByMovieResponse(this.id, this.cast, this.crew);
}
