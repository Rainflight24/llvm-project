; Test diagnostics for -file-override and -default-opt.

; REQUIRES: asserts
; A pair without '=' has an empty recipe.
; RUN: not protean -protean -file-override=selected.c -disable-output %s 2>&1 \
; RUN:   | FileCheck %s --check-prefix=EMPTY
; RUN: not protean -protean -file-override=selected.c= -disable-output %s 2>&1 \
; RUN:   | FileCheck %s --check-prefix=EMPTY

; RUN: not protean -protean -file-override=selected.c=CX -disable-output %s 2>&1 \
; RUN:   | FileCheck %s --check-prefix=BAD-CHAR

; RUN: not protean -O3 -file-override=selected.c=C -disable-output %s 2>&1 \
; RUN:   | FileCheck %s --check-prefix=NO-PROTEAN

; RUN: not protean -protean -default-opt=bogus -disable-output %s 2>&1 \
; RUN:   | FileCheck %s --check-prefix=BAD-DEFAULT

; RUN: protean -protean -default-opt=O3 -file-override=other.c=XYZ \
; RUN:   -disable-output -debug-only=protean %s 2>&1 | FileCheck %s --check-prefix=NO-MATCH

; EMPTY: Invalid recipe (empty)
; BAD-CHAR: Invalid recipe character 'X': expected A, B, C, D, or E
; NO-PROTEAN: -file-override requires -protean
; BAD-DEFAULT: for the --default-opt option: Cannot find option named 'bogus'!
; NO-MATCH: {{^}}selected.c had no override specified{{$}}
; NO-MATCH-NOT: {{.}}

source_filename = "selected.c"

define i32 @f(i32 %x) {
  ret i32 %x
}
