class TokenProvider {
  TokenProvider._();

  static final TokenProvider _instance = TokenProvider._();
  static TokenProvider get instance => _instance;

  String? _accessToken;
  String? _refreshToken;
  
  void Function(String newAccessToken)? onAccessTokenUpdated;

  void setTokens({String? accessToken, String? refreshToken}) {
    final wasAccessTokenUpdated = accessToken != null && 
                                  accessToken != _accessToken &&
                                  _accessToken != null;
    
    _accessToken = accessToken;
    if (refreshToken != null) {
      _refreshToken = refreshToken;
    }
    
    if (wasAccessTokenUpdated && 
        onAccessTokenUpdated != null) {
      onAccessTokenUpdated!(accessToken);
    }
  }

  String? get accessToken => _accessToken;

  String? get refreshToken => _refreshToken;

  void clearTokens() {
    _accessToken = null;
    _refreshToken = null;
  }

  bool get hasTokens => _accessToken != null && _accessToken!.isNotEmpty;
}

