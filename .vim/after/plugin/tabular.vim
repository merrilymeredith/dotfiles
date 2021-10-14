if exists(':Tabularize')
  AddTabularPattern! first_eq    /^.\{-}\zs=/
  AddTabularPattern! first_arrow /^.\{-}\zs=>/
  AddTabularPattern! first_colon /^.\{-}:\zs/l0l1
  AddTabularPattern! comma       /,\zs/l0l1
  AddTabularPattern! methods     /^.\{-}\zs\(->\|\.\)/l0
endif
