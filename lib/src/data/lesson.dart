class Lesson {
  static String getLessons = """
    query getLessons {
      getLessons {
        id
        title
        level 
      }
    }
    """;

  static String getLesson = """
    query getLesson(\$id: String!) {
      getLesson(id: \$id) {
        id
        title
        level 
        answer
        questions
      }
    }
    """;
}
