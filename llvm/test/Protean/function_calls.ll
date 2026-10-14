; RUN: opt -passes=protean-collect-features -S %s | %python %S/Inputs/extract-protean-features.py | FileCheck %s

define void @leaf() {
  ret void
}

define void @main() {
entry:
  call void @leaf()
  br label %last
last:
  ret void
}

; CHECK-DAG: total_function_calls = 1.000000
; CHECK-DAG: average_calls_per_function = 0.500000
; CHECK-DAG: median_calls_per_function = 0.500000
