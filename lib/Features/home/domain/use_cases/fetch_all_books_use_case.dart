import 'package:dartz/dartz.dart';

import '../../../../core/shared/errors/failure.dart';
import '../entities/book_entity.dart';
import '../repositories/home_repo.dart';
import 'use_case_methods.dart';

class FetchAllBooksUseCase implements UseCase<List<BookEntity>, void> {
  HomeRepo homeRepo;

  FetchAllBooksUseCase(this.homeRepo);

  @override
  Future<Either<Failure, List<BookEntity>>> call() async {
    return await homeRepo.fetchAllBooks();
  }
}
