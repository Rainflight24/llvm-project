; RUN: rm -f %t*
; RUN: protean --passes=protean-collect-features --enable-protean-feature-dump --protean-dump-file=%tp --ir2vec-dump-file=%t1 -disable-output < %s
; RUN: protean --passes=protean-collect-features --enable-protean-feature-dump --protean-dump-file=%tp --ir2vec-dump-file=%t2 -disable-output < %s
; RUN: cat %t1 | tr ',' '\n' | wc -l | FileCheck %s
; RUN: cat %t2 | tr ',' '\n' | wc -l | FileCheck %s

; CHECK: 300

; RUN: protean --passes=protean-collect-features --enable-protean-feature-dump --protean-dump-file=%tp --ir2vec-dump-file=%t3 -disable-output < %s
; RUN: cat %t3 | FileCheck %s -check-prefix=VALUES
; VALUES: {{^\-?[0-9]+}}.{{[0-9]+}},

define void @main() {
  ret void
}
