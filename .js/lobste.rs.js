// If story previews are enabled, set regular spacing and place byline below
// title.
if (document.querySelector('div.story_content')) {
  var sheet = document.createElement('style')
  sheet.innerHTML = "\
    li.story { height: 7.5em; } \
    li.story div.byline { color: #777; } \
    li.story div.byline a { color: #777; } \
    li.story div.story_content { color: #999; font-size: 95%; }"
  document.body.appendChild(sheet)

  var bylines = document.querySelectorAll('div.story_content + div.byline')
  for (var e of bylines) {
    e.parentNode.insertBefore(e, e.previousElementSibling)
  }
}