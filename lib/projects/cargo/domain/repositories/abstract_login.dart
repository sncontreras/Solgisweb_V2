abstract class AbstractLoginRepository{

  Future<void> doLogin({String username, String password});

  Future<void> doLogout();

}