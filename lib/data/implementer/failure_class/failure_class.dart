import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';

class FailureClass {
  FirebaseException? firebaseException;
  String? error;

  FailureClass({
    this.firebaseException,
    this.error,
  });
}

Future<Either<FailureClass, T>> handleFirebaseOperation<T>(
    Future<T> Function() firebaseOperation) async {
  try {
    final result = await firebaseOperation();
    return Right(result);
  } on FirebaseException catch (error) {
    return Left(
      FailureClass(firebaseException: error),
    );
  } catch (e) {
    return Left(
      FailureClass(error: e.toString(), firebaseException: null),
    );
  }
}
