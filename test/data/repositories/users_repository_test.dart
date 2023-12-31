import 'package:fake_store_joao/data/models/user.dart';
import 'package:fake_store_joao/data/models/user_create.dart';
import 'package:fake_store_joao/data/repositories/users_repository.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:result_dart/result_dart.dart';

void main() {
  group("Groupt of test of user endpoint", () {
    UserRepository apiUser = UserRepository();
    late User userTest;
    test("create a user", () async {
      var userCrate = UserCreate(
          name: "Renan teste",
          email: "email@email.com",
          password: "1234",
          avatar: "https://api.lorem.space/image/face?w=640&h=480",
          role: "costumer");

      var response = await apiUser.createUser(userCrate);

      response.onSuccess((success) => userTest = success);

      expect(response, isA<Success>());
    });

    test("update a user", () async {
      var response = await apiUser.updateUser(userTest);

      expect(response, isA<Success>());
    });
  });
}
