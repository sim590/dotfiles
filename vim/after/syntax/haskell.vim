
""""""""""""""
"  Coloring  "
""""""""""""""

" Prelude
syntax match Keyword "\<abs\>"
syntax match Keyword "\<acos\>"
syntax match Keyword "\<acosh\>"
syntax match Keyword "\<all\>"
syntax match Keyword "\<and\>"
syntax match Keyword "\<any\>"
syntax match Keyword "\<appendFile\>"
syntax match Keyword "\<asTypeOf\>"
syntax match Keyword "\<asin\>"
syntax match Keyword "\<asinh\>"
syntax match Keyword "\<atan\>"
syntax match Keyword "\<atan2\>"
syntax match Keyword "\<atanh\>"
syntax match Keyword "\<break\>"
syntax match Keyword "\<ceiling\>"
syntax match Keyword "\<compare\>"
syntax match Keyword "\<concat\>"
syntax match Keyword "\<concatMap\>"
syntax match Keyword "\<const\>"
syntax match Keyword "\<cos\>"
syntax match Keyword "\<cosh\>"
syntax match Keyword "\<curry\>"
syntax match Keyword "\<cycle\>"
syntax match Keyword "\<decodeFloat\>"
syntax match Keyword "\<div\>"
syntax match Keyword "\<divMod\>"
syntax match Keyword "\<drop\>"
syntax match Keyword "\<dropWhile\>"
syntax match Keyword "\<either\>"
syntax match Keyword "\<elem\>"
syntax match Keyword "\<encodeFloat\>"
syntax match Keyword "\<enumFrom\>"
syntax match Keyword "\<enumFromThen\>"
syntax match Keyword "\<enumFromThenTo\>"
syntax match Keyword "\<enumFromTo\>"
syntax match Keyword "\<error\>"
syntax match Keyword "\<errorWithoutStackTrace\>"
syntax match Keyword "\<even\>"
syntax match Keyword "\<exp\>"
syntax match Keyword "\<exponent\>"
syntax match Keyword "\<fail\>"
syntax match Keyword "\<filter\>"
syntax match Keyword "\<flip\>"
syntax match Keyword "\<floatDigits\>"
syntax match Keyword "\<floatRadix\>"
syntax match Keyword "\<floatRange\>"
syntax match Keyword "\<floor\>"
syntax match Keyword "\<fmap\>"
syntax match Keyword "\<foldMap\>"
syntax match Keyword "\<foldl\>"
syntax match Keyword "\<foldl1\>"
syntax match Keyword "\<foldr\>"
syntax match Keyword "\<foldr1\>"
syntax match Keyword "\<fromEnum\>"
syntax match Keyword "\<fromInteger\>"
syntax match Keyword "\<fromIntegral\>"
syntax match Keyword "\<fromRational\>"
syntax match Keyword "\<fst\>"
syntax match Keyword "\<gcd\>"
syntax match Keyword "\<getChar\>"
syntax match Keyword "\<getContents\>"
syntax match Keyword "\<getLine\>"
syntax match Keyword "\<head\>"
syntax match Keyword "\<id\>"
syntax match Keyword "\<init\>"
syntax match Keyword "\<interact\>"
syntax match Keyword "\<ioError\>"
syntax match Keyword "\<isDenormalized\>"
syntax match Keyword "\<isIEEE\>"
syntax match Keyword "\<isInfinite\>"
syntax match Keyword "\<isNaN\>"
syntax match Keyword "\<isNegativeZero\>"
syntax match Keyword "\<iterate\>"
syntax match Keyword "\<last\>"
syntax match Keyword "\<lcm\>"
syntax match Keyword "\<length\>"
syntax match Keyword "\<lex\>"
syntax match Keyword "\<lines\>"
syntax match Keyword "\<log\>"
syntax match Keyword "\<logBase\>"
syntax match Keyword "\<lookup\>"
syntax match Keyword "\<map\>"
syntax match Keyword "\<mapM\>"
syntax match Keyword "\<mapM_\>"
syntax match Keyword "\<mappend\>"
syntax match Keyword "\<max\>"
syntax match Keyword "\<maxBound\>"
syntax match Keyword "\<maximum\>"
syntax match Keyword "\<maybe\>"
syntax match Keyword "\<mconcat\>"
syntax match Keyword "\<mempty\>"
syntax match Keyword "\<min\>"
syntax match Keyword "\<minBound\>"
syntax match Keyword "\<minimum\>"
syntax match Keyword "\<mod\>"
syntax match Keyword "\<negate\>"
syntax match Keyword "\<not\>"
syntax match Keyword "\<notElem\>"
syntax match Keyword "\<null\>"
syntax match Keyword "\<odd\>"
syntax match Keyword "\<or\>"
syntax match Keyword "\<otherwise\>"
syntax match Keyword "\<pi\>"
syntax match Keyword "\<pred\>"
syntax match Keyword "\<print\>"
syntax match Keyword "\<product\>"
syntax match Keyword "\<properFraction\>"
syntax match Keyword "\<pure\>"
syntax match Keyword "\<putChar\>"
syntax match Keyword "\<putStr\>"
syntax match Keyword "\<putStrLn\>"
syntax match Keyword "\<quot\>"
syntax match Keyword "\<quotRem\>"
syntax match Keyword "\<read\>"
syntax match Keyword "\<readFile\>"
syntax match Keyword "\<readIO\>"
syntax match Keyword "\<readList\>"
syntax match Keyword "\<readLn\>"
syntax match Keyword "\<readParen\>"
syntax match Keyword "\<reads\>"
syntax match Keyword "\<readsPrec\>"
syntax match Keyword "\<realToFrac\>"
syntax match Keyword "\<recip\>"
syntax match Keyword "\<rem\>"
syntax match Keyword "\<repeat\>"
syntax match Keyword "\<replicate\>"
syntax match Keyword "\<return\>"
syntax match Keyword "\<reverse\>"
syntax match Keyword "\<round\>"
syntax match Keyword "\<scaleFloat\>"
syntax match Keyword "\<scanl\>"
syntax match Keyword "\<scanl1\>"
syntax match Keyword "\<scanr\>"
syntax match Keyword "\<scanr1\>"
syntax match Keyword "\<seq\>"
syntax match Keyword "\<sequence\>"
syntax match Keyword "\<sequenceA\>"
syntax match Keyword "\<sequence_\>"
syntax match Keyword "\<show\>"
syntax match Keyword "\<showChar\>"
syntax match Keyword "\<showList\>"
syntax match Keyword "\<showParen\>"
syntax match Keyword "\<showString\>"
syntax match Keyword "\<shows\>"
syntax match Keyword "\<showsPrec\>"
syntax match Keyword "\<significand\>"
syntax match Keyword "\<signum\>"
syntax match Keyword "\<sin\>"
syntax match Keyword "\<sinh\>"
syntax match Keyword "\<snd\>"
syntax match Keyword "\<span\>"
syntax match Keyword "\<splitAt\>"
syntax match Keyword "\<sqrt\>"
syntax match Keyword "\<subtract\>"
syntax match Keyword "\<succ\>"
syntax match Keyword "\<sum\>"
syntax match Keyword "\<tail\>"
syntax match Keyword "\<take\>"
syntax match Keyword "\<takeWhile\>"
syntax match Keyword "\<tan\>"
syntax match Keyword "\<tanh\>"
syntax match Keyword "\<toEnum\>"
syntax match Keyword "\<toInteger\>"
syntax match Keyword "\<toRational\>"
syntax match Keyword "\<traverse\>"
syntax match Keyword "\<truncate\>"
syntax match Keyword "\<uncurry\>"
syntax match Keyword "\<undefined\>"
syntax match Keyword "\<unlines\>"
syntax match Keyword "\<until\>"
syntax match Keyword "\<unwords\>"
syntax match Keyword "\<unzip\>"
syntax match Keyword "\<unzip3\>"
syntax match Keyword "\<userError\>"
syntax match Keyword "\<words\>"
syntax match Keyword "\<writeFile\>"
syntax match Keyword "\<zip\>"
syntax match Keyword "\<zip3\>"
syntax match Keyword "\<zipWith\>"
syntax match Keyword "\<zipWith3\>"

""""""""""""""""
"  Concealing  "
""""""""""""""""

syntax match hsNiceOperator "\\\ze[[:alpha:][:space:]_([]" conceal cchar=λ
syntax match hsNiceOperator /\s\.\s/ms=s+1,me=e-1 conceal cchar=∘

hi link hsNiceOperator Operator
hi! link Conceal Operator
setlocal conceallevel=2

" vim: set sts=2 ts=2 sw=2 tw=100 et :

