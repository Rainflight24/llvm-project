; RUN: opt -passes=protean-collect-features -S %s | \
; RUN:   %python %S/Inputs/extract-protean-features.py | FileCheck %s

; The two callsites have heights 2 and 1.
; Their callees have heights 1 and 0, and their callers have heights 2 and 1.
; CHECK-DAG: callee_CallerHeight = 1.000000
; CHECK-DAG: caller_CallerHeight = 3.000000
; CHECK-DAG: callsite_height = 3.000000

define internal void @root() {
  call void @middle()
  ret void
}

define internal void @middle() {
  call void @leaf()
  ret void
}

define internal void @leaf() {
  ret void
}
