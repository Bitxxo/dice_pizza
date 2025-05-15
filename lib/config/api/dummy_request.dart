enum DummyEndpoint { login, me, refresh }

class DummyRequest {
  late DummyEndpoint endpoint;

  ///Might contain {username:'user', password:'password'} or {token:'JWT'}
  late Map<String, dynamic> info;

  DummyRequest(this.endpoint, this.info);

  ///Request with login data
  DummyRequest.login(String user, String password, {String? expires}) {
    endpoint = DummyEndpoint.login;
    info = {
      'username': user,
      'password': password,
      'expiresInMins': expires ?? '60'
    };
  }

  ///Request with a JWT
  DummyRequest.me(String jwt) {
    endpoint = DummyEndpoint.me;
    info = {'Authorization': jwt};
  }

  ///Request to refresh the JWT
  DummyRequest.refresh(String refresh, {String expiresInMins = '60'}) {
    endpoint = DummyEndpoint.refresh;
    info = {'refreshToken': refresh, 'expiresInMins': expiresInMins};
  }
}
