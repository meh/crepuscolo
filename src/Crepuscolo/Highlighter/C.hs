module Crepuscolo.Highlighter.C
    ( highlighter
    ) where

import Crepuscolo.Highlight
import Crepuscolo.Highlight.DSL hiding (keyword)
import qualified Crepuscolo.Highlight.DSL as DSL (keyword)

highlighter :: Highlighter
highlighter = keyword "c:statement" ["goto", "break", "return", "continue", "asm", "__asm__"]
          ||| keyword "c:label" ["case", "default"]
          ||| keyword "c:conditional" ["if", "else", "switch"]
          ||| keyword "c:repeat" ["while", "for", "do"]
          ||| keyword "c:structure" ["struct", "union", "enum", "typedef"]
          ||| keyword "c:storage_class" ["static", "register", "auto", "volatile", "extern",
                                         "const", "inline", "restrict", "__attribute__",
                                         "_Alignas", "alignas", "_Atomic", "_Noreturn",
                                         "noreturn", "_Thread_local", "thread_local"]
          ||| keyword "c:operator" ["sizeof", "typeof", "alignof", "static_assert",
                                    "_Alignof", "_Generic", "_Static_assert",
                                    "__real__", "__imag__"]
          ||| keyword "c:type" ["int", "long", "short", "char", "void", "signed",
                                "unsigned", "float", "double", "size_t", "ssize_t",
                                "off_t", "wchar_t", "ptrdiff_t", "sig_atomic_t",
                                "fpos_t", "clock_t", "time_t", "va_list", "jmp_buf",
                                "FILE", "DIR", "div_t", "ldiv_t", "mbstate_t", "wctrans_t",
                                "wint_t", "wctype_t", "_Bool", "bool", "_Complex", "complex",
                                "_Imaginary", "imaginary", "int8_t", "int16_t", "int32_t",
                                "int64_t", "uint8_t", "uint16_t", "uint32_t", "uint64_t",
                                "int_least8_t", "int_least16_t", "int_least32_t",
                                "int_least64_t", "uint_least8_t", "uint_least16_t",
                                "uint_least32_t", "uint_least64_t", "int_fast8_t",
                                "int_fast16_t", "int_fast32_t", "int_fast64_t",
                                "uint_fast8_t", "uint_fast16_t", "uint_fast32_t",
                                "uint_fast64_t", "intptr_t", "uintptr_t", "intmax_t",
                                "uintmax_t", "__label__", "__complex__", "__volatile__",
                                "char16_t", "char32_t"]

          ||| match "c:character" "'[^\\\\]'"

keyword group names =
    DSL.keyword group names "[A-Za-z_$][A-Za-z0-9_$]+"
