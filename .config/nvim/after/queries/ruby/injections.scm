;; extends

(heredoc_body
  (heredoc_content) @injection.content
  (heredoc_end) @injection.language
  (#gsub! @injection.language "^END_" "")
  (#downcase! @injection.language))
