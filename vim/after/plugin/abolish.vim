" Exit if :Abolish isn't available.
if !exists(':Abolish')
    finish
endif

" Langue française
Abolish -cmdline dasn dans

" Langue anglaise
Abolish -cmdline {otd,tdo}o todo
Abolish -cmdline tood todo
Abolish -cmdline ifxme fixme
Abolish -cmdline psuh{,ed,ing,es} push{}
Abolish -cmdline c{outn,uont,otun} count
Abolish -cmdline {apss,psas}{word,wrod,wodr,owrd} password

" vim: set sts=2 ts=2 sw=2 tw=100 et :

