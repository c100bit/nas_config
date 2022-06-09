import 'package:dartz/dartz.dart';

extension EitherExtension<L, R> on Either<L, R> {
  R asRight() => (this as Right).value;
  L asLeft() => (this as Left).value;
}
