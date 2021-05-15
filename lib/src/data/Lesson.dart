enum QuestionType {
  // SCALE,
  // CHORD,
  // SIGNT_READING,
  // CHORD_PROGRESSION,
  MULTIPLE_CHOICE,
  TEXT
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
          text {
            id
            text
          }
          answer
          type
          answerArr
          options
          image
          answerHint
          requiresPiano
        }
        module {
          id
          title
        }
      }
      get {
        id
      }
    }
    """;

  static String completeLesson = """
    mutation(\$lessonId: String!) {
      completeLesson(lessonId: \$lessonId) {
        lesson {
          id
        }
        streak
      }
    }
  """;
}
