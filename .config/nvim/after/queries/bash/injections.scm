;; extends

((heredoc_redirect
  (heredoc_body) @injection.content
  (heredoc_end) @injection.language)
  (#gsub! @injection.language "^END_" "")
  (#downcase! @injection.language))
