; RUN: rm -f %t*

; RUN: protean -passes=protean-collect-features -enable-protean-feature-dump -protean-dump-file=%t1 -disable-output -protean-dump-only=%s %s
; RUN: ls %t1

; RUN: protean -passes=protean-collect-features -enable-protean-feature-dump -protean-dump-file=%t2 -disable-output -protean-dump-only=other %s
; RUN: not ls %t2

; RUN: protean -passes=protean-collect-features -enable-protean-feature-dump -protean-dump-file=%t3 -disable-output -protean-dump-only=%s -protean-dump-only=other %s
; RUN: ls %t3

define void @main() {
  ret void
}
