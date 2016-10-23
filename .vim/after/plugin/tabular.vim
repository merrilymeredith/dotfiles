if exists(':Tabularize')
  AddTabularPattern! first_eq    /^[^=]*\zs=/
  AddTabularPattern! first_arrow /^.\{-}\zs=>/
  AddTabularPattern! methods     /->\|\\./l1r0
endif
