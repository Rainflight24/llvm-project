; A module outside the forced selection must receive the same full pipeline as
; ordinary -O3, even when -protean is enabled.
; RUN: protean -O3 -disable-output -print-pipeline-passes -disable-pipeline-verification %s > %t.o3
; RUN: protean -protean -protean-force-recipe=C -protean-force-module=other.c \
; RUN:   -disable-output -print-pipeline-passes -disable-pipeline-verification %s > %t.forced
; RUN: diff %t.o3 %t.forced

source_filename = "selected.c"

define i32 @f(i32 %x) {
  %sum = add i32 %x, 0
  ret i32 %sum
}
