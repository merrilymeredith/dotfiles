;; extends

(heredoc_content
  (heredoc_end) @injection.language (#gsub! @injection.language "^END_" "")
) @injection.content
