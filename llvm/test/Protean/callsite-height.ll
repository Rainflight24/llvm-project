; RUN: opt -passes=protean-collect-features -S %s | \
; RUN:   %python %S/Inputs/extract-protean-features.py | FileCheck %s

; The two callsites have heights 2 and 1.
; CHECK: callsite_height = 3.000000

define void @root() {
  call void @middle()
  ret void
}

define void @middle() {
  call void @leaf()
  ret void
}

define void @leaf() {
  ret void
}
