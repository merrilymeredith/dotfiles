@ECHO ON

copy ..\.vimrc %USERPROFILE%\_vimrc
xcopy /s ..\.vim %USERPROFILE%\vimfiles\
