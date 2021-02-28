class Note {
  static String getNote = """
    query getNote(\$id: String!) {
     
      getNote(id: \$id) {
        id
        title
        markdown
        sanitizedHtml
      }
    }
    """;
}
