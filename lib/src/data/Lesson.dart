class Lesson {
  static String getLessons = """
    query getLessons(\$module: String!) {
      getLessons(module: \$module) {
        id
        level 
      }
    }
    """;

  static String getLesson = """
    query getLesson(\$id: String!) {
      getLesson(id: \$id) {
        id
        level 
      }
    }
    """;
}
