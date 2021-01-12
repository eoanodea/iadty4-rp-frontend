enum ModuleType { THEORY, IMPROV }

class Module {
  static String getModules = """
    query getModules(\$type: String!) {
      getModules(type: \$type) {
        id
        title
        level 
      }
    }
    """;

  static String getModule = """
    query getModule(\$id: String!) {
      getModule(id: \$id) {
        id
        title
        level 
        answer
        questions
      }
    }
    """;
}
