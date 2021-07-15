class FakeRepo {
  Future<void> logIn(String name, String password) async {
    print("logging in");
    await Future.delayed(Duration(seconds: 3));
    print("$name and $password");
    print("user logged in");
  }

  Future<void> signUp() async {
    print("signing up.....");
    await Future.delayed(Duration(seconds: 3));
    print("signed in");
  }

  Future<void> signOut() async {
    print("signing out");
    await Future.delayed(Duration(seconds: 3));
    print("signed out");
  }
}
