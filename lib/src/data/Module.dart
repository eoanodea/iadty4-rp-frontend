enum ModuleType { THEORY, IMPROV }

class Module {
  static String getModules = """
    query getModules(\$type: String!) {
      getModules(type: \$type) {
        id
        title
        level 
        lessons {
          id
        }
      }
      get {
        id
        completedLessons {
          id
        }

      }
    }
    """;

  static String getModule = """
    query getModule(\$id: String!) {
      getModule(id: \$id) {
        id
        title
        level
        lessons {
          id
        }
      }
    }
    """;
}
