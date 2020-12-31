class Auth {
  static String login = """
      mutation login(\$email: String!, \$password: String!) {
      login(input: { email: \$email, password: \$password }) {
        token
        user {
          email
          id
        }
      }
    }
  """;

  static String getUser = """
    query getUser {
      get {
        name
        email 
      }
    }
    """;
}
