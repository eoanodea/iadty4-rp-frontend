class Auth {
  static String login = """
      mutation login(\$email: String!, \$password: String!) {
      login(input: { email: \$email, password: \$password }) {
        token
        expiration
        user {
          email
          id
        }
      }
    }
  """;

  static String register = """
      mutation register(\$name: String!, \$email: String!, \$password: String!) {
      addUser(input: { name: \$name, email: \$email, password: \$password }) {
          email
          id
      }
    }
  """;

  static String getUser = """
    query getUser {
      get {
        id
        name
        email 
        createdAt
      }
    }
    """;
}
