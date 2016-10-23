if exists(':Tabularize')
  AddTabularPattern! first_eq    /^[^=]*\zs=/
  AddTabularPattern! first_arrow /^.\{-}\zs=>/
endif
