; When -enable-protean-feature-dump is set, modules should dump their features
; regardless of how they are compiled (recipes, O3, SA).
; The emitted IR is unchanged.
; RUN: rm -f %t*

; RUN: protean -O3 -o %t.o3.bc %s
; RUN: protean -protean -default-opt=O3 -enable-protean-feature-dump \
; RUN:   -protean-dump-file=%t.o3.csv -debug-pass-manager -o %t.default.bc %s \
; RUN:   2> %t.default.err
; RUN: FileCheck %s --check-prefix=PM < %t.default.err
; RUN: llvm-diff %t.o3.bc %t.default.bc
; RUN: FileCheck %s --check-prefix=CSV < %t.o3.csv

; RUN: protean -protean -file-override=selected.c=O3 \
; RUN:   -enable-protean-feature-dump -protean-dump-file=%t.override.csv \
; RUN:   -o %t.override.bc %s
; RUN: FileCheck %s --check-prefix=CSV < %t.override.csv

; RUN: protean -protean -file-override=selected.c=C \
; RUN:   -enable-protean-feature-dump -protean-dump-file=%t.recipe.csv \
; RUN:   -debug-pass-manager -o %t.recipe.bc %s 2> %t.recipe.err
; RUN: FileCheck %s --check-prefix=PM < %t.recipe.err
; RUN: FileCheck %s --check-prefix=CSV < %t.recipe.csv

; No SA parent exists, so collection must not try to share features with one.
; RUN: FileCheck %s --check-prefix=NOSHM --allow-empty < %t.default.err
; RUN: FileCheck %s --check-prefix=NOSHM --allow-empty < %t.recipe.err

; Without the dump flag, no collection runs and no file is created.
; RUN: protean -protean -default-opt=O3 -protean-dump-file=%t.none.csv \
; RUN:   -debug-pass-manager -o %t.none.bc %s 2> %t.none.err
; RUN: FileCheck %s --check-prefix=PM-NONE < %t.none.err
; RUN: not ls %t.none.csv

; PM: Running pass: BitcodeWriterPass on
; PM-NEXT: Running pass: CollectFeaturesPass on

; PM-NONE-NOT: CollectFeaturesPass

; CSV: Module|Function|Callee|Caller|Loop,
; CSV-NEXT: dump-non-sa.ll||||,

; NOSHM-NOT: shm_open

source_filename = "selected.c"

define i32 @f(i32 %x) {
  %sum = add i32 %x, 0
  ret i32 %sum
}
