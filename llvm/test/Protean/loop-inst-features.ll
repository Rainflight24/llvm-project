; RUN: opt -passes=protean-collect-features -S %s | \
; RUN:   %python %S/Inputs/extract-protean-features.py | FileCheck %s

; CHECK-DAG: NumLoadInstPerLoopNest = 2.000000
; CHECK-DAG: NumStoreInstPerLoopNest = 2.000000
; CHECK-DAG: TotLoopNestInstCount = 7.000000
; CHECK-DAG: AvgNumLoadInstPerLoopNest = 0.285714

; CHECK-DAG: NumLoadInstPerLoop = 1.000000
; CHECK-DAG: NumStoreInstPerLoop = 1.000000
; CHECK-DAG: TotLoopInstCount = 3.000000
; CHECK-DAG: AvgNumLoadInstPerLoop = 0.333333
; CHECK-DAG: TotBlocksPerLoop = 1.000000

define void @sibling_loops(ptr %p, i1 %again) {
entry:
  br label %outer.header

outer.header:
  %outer.value = load i32, ptr %p
  store i32 %outer.value, ptr %p
  br label %inner.load

inner.load:
  %inner.value = load i32, ptr %p
  br i1 %again, label %inner.load, label %inner.store

inner.store:
  store i32 0, ptr %p
  br i1 %again, label %inner.store, label %outer.header
}
