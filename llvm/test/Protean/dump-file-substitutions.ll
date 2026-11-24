; REQUIRES: asserts
; RUN: rm -f %t*

; RUN: protean -passes=protean-collect-features -enable-protean-feature-dump -protean-dump-file=%t%%f -disable-output %s
; RUN: ls %tdump-file-substitutions.ll

; RUN: protean -passes=protean-collect-features -enable-protean-feature-dump -protean-dump-file=%t%%%% -disable-output %s
; RUN: ls %t%%

; RUN: protean -passes=protean-collect-features -enable-protean-feature-dump -protean-dump-file=%t-hash-%%h-hash -disable-output %s
; RUN: ls %t-hash-*-hash | FileCheck %s
; CHECK: {{.*}}-hash-{{[0-9]+}}-hash

; RUN: protean -passes=protean-collect-features -enable-protean-feature-dump -ir2vec-dump-file=%t-ir2vec-%%f-%%h-%%%% -disable-output %s --debug-only=proteanFC
; RUN: ls %t-ir2vec-dump-file-substitutions.ll*

define void @main() {
  ret void
}
