
setlocal textwidth=120
setlocal tabstop=4
setlocal shiftwidth=4

" Abbreviations and substitutions.

iabbrev ;: ::
iabbrev :; ::
iabbrev ;; ::
iabbrev std:; std::
iabbrev std;: std::
iabbrev std;; std::
iabbrev ui8  uint8_t
iabbrev ui16 uint16_t
iabbrev ui32 uint32_t
iabbrev ui64 uint64_t

Abolish -cmdline s{tir,rti}ng string
Abolish -cmdline {pia,apir}r pair
Abolish -cmdline v{ecot,ceot,ceto}r vector

Abolish -cmdline {iunt,uitn}{8,16,32,64}{_t,t_} uint{{}}_t
Abolish -cmdline {uat,atu}o auto
Abolish -cmdline a{uot,tuo,tou} auto

" vim:set et sw=2 ts=2 tw=100:

