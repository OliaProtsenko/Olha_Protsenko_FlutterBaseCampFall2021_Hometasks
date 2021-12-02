import 'package:campnotes/auth/auth_repository.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:test/test.dart';
import 'package:mockito/mockito.dart';

class MockFirebaseAuth extends Mock implements FirebaseAuth {}


void main() async {
  MockFirebaseAuth _auth = MockFirebaseAuth();
  final repo = AuthRepository(_auth);

  test('Log in with weak  password', () async {
    when(_auth.signInWithEmailAndPassword(email: "email", password: "123"))
        .thenAnswer((_) {
      return null;
    });
    User user = await repo.login(email: "user@test.com", password: "12345678");
    expect(user, null);
  });

  test("sign up", () async {
    when(_auth.createUserWithEmailAndPassword(
            email: "user@test.com", password: "1234"))
        .thenAnswer((_) {
      throw FirebaseAuthException(code: "weak-password");
    });

    User user = await repo.signUp(
        username: "user", email: "user@test.com", password: "1234");
    expect(user, null);
  });
  test("failed sign in", () async {
    when(_auth.signOut()).thenAnswer((_){ throw Exception();});
    expect(await repo.signOut(), false);
  });
}
