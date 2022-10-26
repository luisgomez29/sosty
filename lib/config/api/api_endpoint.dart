class ApiEndpoint {
  ApiEndpoint._();

  static const login = "https://sosty-api.azurewebsites.net/api/User/Login";

  static const signup = "https://sosty-api.azurewebsites.net/api/User/Register";

  static const getUserById =
      "https://sosty-api.azurewebsites.net/api/User/GetUserbyID";

  static const getInvestmentsInProgressByInvestor =
      "https://sosty-api.azurewebsites.net/api/Investment/GetInvestmentsInProgressByInvestor";

  static const publicProjects =
      "https://sosty-api.azurewebsites.net/api/Project/GetPublicTopProjects";

  static const getProjectProgressInformation =
      "https://sosty-api.azurewebsites.net/api/Project/GetProjectProgressInformation";

  static const getProjectPublicByCode =
      "https://sosty-api.azurewebsites.net/api/Project/GetProjectPublicByCode";
}
