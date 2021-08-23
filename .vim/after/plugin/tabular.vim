if exists(':Tabularize')
  AddTabularPattern! first_eq    /^.\{-}\zs=/
  AddTabularPattern! first_arrow /^.\{-}\zs=>/
  AddTabularPattern! first_colon /^.\{-}:\zs/
  AddTabularPattern! methods     /^.\{-}\zs\(->\|\.\)/l0
endif
