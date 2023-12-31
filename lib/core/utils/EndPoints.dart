class EndPoints {
  static const baseUrl = 'https://pro-pracker.azurewebsites.net/api/';

  static const register = baseUrl + 'auth/register';
  static const login = baseUrl + 'auth/mobile/login';
  static const logout = baseUrl + 'auth/logout';
  static const getRole = baseUrl + 'auth/get-role';
  static const forgotPassword = baseUrl + 'auth/forgot-password';
  static const validateOtp = baseUrl + 'auth/validate-otp';
  static const resetPassword = baseUrl + 'auth/reset-password';
  static const getAllProject = baseUrl + 'auth/project/crew/get-all-project';
  static const createProject = baseUrl + 'project/:name/create-project';
  // String project;
  // String project = _baseUrl + 'auth/project/${name}/get-all-project';

  // static getAllProjectEndpoint(var name) {
  //   String project = _baseUrl + 'auth/project/${name}/get-all-project';
  //   return project;
  // }
}

// http.get(Uri.parse(Apis.loginApi));
// var a = EndPoints.register;