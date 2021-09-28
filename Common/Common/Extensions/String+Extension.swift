extension String {
  public static var posts: String {
    "posts".localized()
  }

  public static var comments: String {
    "comments".localized()
  }

  public static var error: String {
    "error".localized()
  }

  public static var ok: String {
    "ok".localized()
  }

  public static var serverError: String {
    "server_error".localized()
  }

  public static var parsingError: String {
    "parsing_error".localized()
  }

  func localized(withComment comment: String? = nil) -> String {
      return NSLocalizedString(self, comment: comment ?? "")
  }
}
