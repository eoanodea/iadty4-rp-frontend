enum QuestionType {
  // SCALE,
  // CHORD,
  // SIGNT_READING,
  // CHORD_PROGRESSION,
  MULTIPLE_CHOICE,
  TEXT
}

class Question {
  static String getQuestions = """
    query getQuestions(\$lesson: String!) {
      getQuestions(lesson: \$lesson) {
        id 
        text {
          id
          text
          order
            note {
              id
            }
        }
        answer
        type
        answerArr
        options
        image
        answerHint
        requiresPiano
      }
      get {
        id
      }
    }
    """;

  static String getQuestion = """
    query getQuestion(\$id: String!) {
      getQuestion(lesson: \$id) {    
        id
        text {
          id
          text  
          order
          note {
            id
          }
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
      get {
        id
      }
    }
    """;

  static String completeQuestion = """
    mutation(\$userId: String!, \$lessonId: String!) {
      completeQuestion(userId: \$userId, lessonId: \$lessonId) {
        id
      }
    }
  """;
}
