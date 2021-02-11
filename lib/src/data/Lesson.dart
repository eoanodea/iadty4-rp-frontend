enum QuestionType {
  SCALE,
  CHORD,
  SIGNT_READING,
  CHORD_PROGRESSION,
}

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
        level
        id
        questions {
          id
          text
          answer
          type
          requiresPiano
        }
        module {
          id
          title
        }
      }
    }
    """;
}
