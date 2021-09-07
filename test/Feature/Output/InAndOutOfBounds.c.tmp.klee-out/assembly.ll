; ModuleID = '/home/sanghu/TracerX/tracerx/test/Feature/Output/InAndOutOfBounds.c.tmp1.bc'
target datalayout = "e-p:64:64:64-i1:8:8-i8:8:8-i16:16:16-i32:32:32-i64:64:64-f32:32:32-f64:64:64-v64:64:64-v128:128:128-a0:0:64-s0:64:64-f80:128:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

@.str = private unnamed_addr constant [22 x i8] c"klee_div_zero_check.c\00", align 1
@.str1 = private unnamed_addr constant [15 x i8] c"divide by zero\00", align 1
@.str2 = private unnamed_addr constant [8 x i8] c"div.err\00", align 1
@.str3 = private unnamed_addr constant [8 x i8] c"IGNORED\00", align 1
@.str14 = private unnamed_addr constant [16 x i8] c"overshift error\00", align 1
@.str25 = private unnamed_addr constant [14 x i8] c"overshift.err\00", align 1
@.str6 = private unnamed_addr constant [13 x i8] c"klee_range.c\00", align 1
@.str17 = private unnamed_addr constant [14 x i8] c"invalid range\00", align 1
@.str28 = private unnamed_addr constant [5 x i8] c"user\00", align 1

; Function Attrs: nounwind uwtable
define i32 @klee_urange(i32 %start, i32 %end) #0 {
  %1 = alloca i32, align 4
  %2 = alloca i32, align 4
  %x = alloca i32, align 4
  store i32 %start, i32* %1, align 4
  store i32 %end, i32* %2, align 4
  %3 = call i32 (i32*, i64, ...)* bitcast (i32 (...)* @klee_make_symbolic to i32 (i32*, i64, ...)*)(i32* %x, i64 4), !dbg !132
  %4 = load i32* %x, align 4, !dbg !133
  %5 = load i32* %1, align 4, !dbg !133
  %6 = sub i32 %4, %5, !dbg !133
  %7 = load i32* %2, align 4, !dbg !133
  %8 = load i32* %1, align 4, !dbg !133
  %9 = sub i32 %7, %8, !dbg !133
  %10 = icmp uge i32 %6, %9, !dbg !133
  br i1 %10, label %11, label %13, !dbg !133

; <label>:11                                      ; preds = %0
  %12 = call i32 (i32, ...)* bitcast (i32 (...)* @klee_silent_exit to i32 (i32, ...)*)(i32 0), !dbg !133
  br label %13, !dbg !133

; <label>:13                                      ; preds = %11, %0
  %14 = load i32* %x, align 4, !dbg !135
  ret i32 %14, !dbg !135
}

; Function Attrs: nounwind readnone
declare void @llvm.dbg.declare(metadata, metadata) #1

declare i32 @klee_make_symbolic(...) #2

; Function Attrs: noreturn
declare i32 @klee_silent_exit(...) #3

; Function Attrs: nounwind uwtable
define i32 @main() #0 {
  %1 = alloca i32, align 4
  %x = alloca i32*, align 8
  store i32 0, i32* %1
  %2 = call i8* @malloc(i64 4), !dbg !136
  %3 = bitcast i8* %2 to i32*, !dbg !136
  store i32* %3, i32** %x, align 8, !dbg !136
  %4 = call i32 @klee_urange(i32 0, i32 2), !dbg !137
  %5 = zext i32 %4 to i64, !dbg !137
  %6 = load i32** %x, align 8, !dbg !137
  %7 = getelementptr inbounds i32* %6, i64 %5, !dbg !137
  store i32 1, i32* %7, align 4, !dbg !137
  %8 = load i32** %x, align 8, !dbg !138
  %9 = call i32 (i32*, ...)* bitcast (i32 (...)* @free to i32 (i32*, ...)*)(i32* %8), !dbg !138
  ret i32 0, !dbg !139
}

declare i8* @malloc(i64) #2

declare i32 @free(...) #2

; Function Attrs: nounwind uwtable
define void @klee_div_zero_check(i64 %z) #4 {
  %1 = icmp eq i64 %z, 0, !dbg !140
  br i1 %1, label %2, label %3, !dbg !140

; <label>:2                                       ; preds = %0
  tail call void @klee_report_error(i8* getelementptr inbounds ([22 x i8]* @.str, i64 0, i64 0), i32 14, i8* getelementptr inbounds ([15 x i8]* @.str1, i64 0, i64 0), i8* getelementptr inbounds ([8 x i8]* @.str2, i64 0, i64 0)) #7, !dbg !142
  unreachable, !dbg !142

; <label>:3                                       ; preds = %0
  ret void, !dbg !143
}

; Function Attrs: noreturn
declare void @klee_report_error(i8*, i32, i8*, i8*) #5

; Function Attrs: nounwind readnone
declare void @llvm.dbg.value(metadata, i64, metadata) #1

; Function Attrs: nounwind uwtable
define i32 @klee_int(i8* %name) #4 {
  %x = alloca i32, align 4
  %1 = bitcast i32* %x to i8*, !dbg !144
  call void bitcast (i32 (...)* @klee_make_symbolic to void (i8*, i64, i8*)*)(i8* %1, i64 4, i8* %name) #8, !dbg !144
  %2 = load i32* %x, align 4, !dbg !145, !tbaa !146
  ret i32 %2, !dbg !145
}

; Function Attrs: nounwind uwtable
define void @klee_overshift_check(i64 %bitWidth, i64 %shift) #4 {
  %1 = icmp ult i64 %shift, %bitWidth, !dbg !150
  br i1 %1, label %3, label %2, !dbg !150

; <label>:2                                       ; preds = %0
  tail call void @klee_report_error(i8* getelementptr inbounds ([8 x i8]* @.str3, i64 0, i64 0), i32 0, i8* getelementptr inbounds ([16 x i8]* @.str14, i64 0, i64 0), i8* getelementptr inbounds ([14 x i8]* @.str25, i64 0, i64 0)) #7, !dbg !152
  unreachable, !dbg !152

; <label>:3                                       ; preds = %0
  ret void, !dbg !154
}

; Function Attrs: nounwind uwtable
define i32 @klee_range(i32 %start, i32 %end, i8* %name) #4 {
  %x = alloca i32, align 4
  %1 = icmp slt i32 %start, %end, !dbg !155
  br i1 %1, label %3, label %2, !dbg !155

; <label>:2                                       ; preds = %0
  call void @klee_report_error(i8* getelementptr inbounds ([13 x i8]* @.str6, i64 0, i64 0), i32 17, i8* getelementptr inbounds ([14 x i8]* @.str17, i64 0, i64 0), i8* getelementptr inbounds ([5 x i8]* @.str28, i64 0, i64 0)) #7, !dbg !157
  unreachable, !dbg !157

; <label>:3                                       ; preds = %0
  %4 = add nsw i32 %start, 1, !dbg !158
  %5 = icmp eq i32 %4, %end, !dbg !158
  br i1 %5, label %21, label %6, !dbg !158

; <label>:6                                       ; preds = %3
  %7 = bitcast i32* %x to i8*, !dbg !160
  call void bitcast (i32 (...)* @klee_make_symbolic to void (i8*, i64, i8*)*)(i8* %7, i64 4, i8* %name) #8, !dbg !160
  %8 = icmp eq i32 %start, 0, !dbg !162
  %9 = load i32* %x, align 4, !dbg !164, !tbaa !146
  br i1 %8, label %10, label %13, !dbg !162

; <label>:10                                      ; preds = %6
  %11 = icmp ult i32 %9, %end, !dbg !164
  %12 = zext i1 %11 to i64, !dbg !164
  call void @klee_assume(i64 %12) #8, !dbg !164
  br label %19, !dbg !166

; <label>:13                                      ; preds = %6
  %14 = icmp sge i32 %9, %start, !dbg !167
  %15 = zext i1 %14 to i64, !dbg !167
  call void @klee_assume(i64 %15) #8, !dbg !167
  %16 = load i32* %x, align 4, !dbg !169, !tbaa !146
  %17 = icmp slt i32 %16, %end, !dbg !169
  %18 = zext i1 %17 to i64, !dbg !169
  call void @klee_assume(i64 %18) #8, !dbg !169
  br label %19

; <label>:19                                      ; preds = %13, %10
  %20 = load i32* %x, align 4, !dbg !170, !tbaa !146
  br label %21, !dbg !170

; <label>:21                                      ; preds = %19, %3
  %.0 = phi i32 [ %20, %19 ], [ %start, %3 ]
  ret i32 %.0, !dbg !171
}

declare void @klee_assume(i64) #6

; Function Attrs: nounwind uwtable
define weak i8* @memcpy(i8* %destaddr, i8* %srcaddr, i64 %len) #4 {
  %1 = icmp eq i64 %len, 0, !dbg !172
  br i1 %1, label %._crit_edge, label %.lr.ph.preheader, !dbg !172

.lr.ph.preheader:                                 ; preds = %0
  %n.vec = and i64 %len, -32
  %cmp.zero = icmp eq i64 %n.vec, 0
  %2 = add i64 %len, -1
  br i1 %cmp.zero, label %middle.block, label %vector.memcheck

vector.memcheck:                                  ; preds = %.lr.ph.preheader
  %scevgep4 = getelementptr i8* %srcaddr, i64 %2
  %scevgep = getelementptr i8* %destaddr, i64 %2
  %bound1 = icmp uge i8* %scevgep, %srcaddr
  %bound0 = icmp uge i8* %scevgep4, %destaddr
  %memcheck.conflict = and i1 %bound0, %bound1
  %ptr.ind.end = getelementptr i8* %srcaddr, i64 %n.vec
  %ptr.ind.end6 = getelementptr i8* %destaddr, i64 %n.vec
  %rev.ind.end = sub i64 %len, %n.vec
  br i1 %memcheck.conflict, label %middle.block, label %vector.body

vector.body:                                      ; preds = %vector.body, %vector.memcheck
  %index = phi i64 [ %index.next, %vector.body ], [ 0, %vector.memcheck ]
  %next.gep = getelementptr i8* %srcaddr, i64 %index
  %next.gep103 = getelementptr i8* %destaddr, i64 %index
  %3 = bitcast i8* %next.gep to <16 x i8>*, !dbg !173
  %wide.load = load <16 x i8>* %3, align 1, !dbg !173
  %next.gep.sum279 = or i64 %index, 16, !dbg !173
  %4 = getelementptr i8* %srcaddr, i64 %next.gep.sum279, !dbg !173
  %5 = bitcast i8* %4 to <16 x i8>*, !dbg !173
  %wide.load200 = load <16 x i8>* %5, align 1, !dbg !173
  %6 = bitcast i8* %next.gep103 to <16 x i8>*, !dbg !173
  store <16 x i8> %wide.load, <16 x i8>* %6, align 1, !dbg !173
  %7 = getelementptr i8* %destaddr, i64 %next.gep.sum279, !dbg !173
  %8 = bitcast i8* %7 to <16 x i8>*, !dbg !173
  store <16 x i8> %wide.load200, <16 x i8>* %8, align 1, !dbg !173
  %index.next = add i64 %index, 32
  %9 = icmp eq i64 %index.next, %n.vec
  br i1 %9, label %middle.block, label %vector.body, !llvm.loop !174

middle.block:                                     ; preds = %vector.body, %vector.memcheck, %.lr.ph.preheader
  %resume.val = phi i8* [ %srcaddr, %.lr.ph.preheader ], [ %srcaddr, %vector.memcheck ], [ %ptr.ind.end, %vector.body ]
  %resume.val5 = phi i8* [ %destaddr, %.lr.ph.preheader ], [ %destaddr, %vector.memcheck ], [ %ptr.ind.end6, %vector.body ]
  %resume.val7 = phi i64 [ %len, %.lr.ph.preheader ], [ %len, %vector.memcheck ], [ %rev.ind.end, %vector.body ]
  %new.indc.resume.val = phi i64 [ 0, %.lr.ph.preheader ], [ 0, %vector.memcheck ], [ %n.vec, %vector.body ]
  %cmp.n = icmp eq i64 %new.indc.resume.val, %len
  br i1 %cmp.n, label %._crit_edge, label %.lr.ph

.lr.ph:                                           ; preds = %.lr.ph, %middle.block
  %src.03 = phi i8* [ %11, %.lr.ph ], [ %resume.val, %middle.block ]
  %dest.02 = phi i8* [ %13, %.lr.ph ], [ %resume.val5, %middle.block ]
  %.01 = phi i64 [ %10, %.lr.ph ], [ %resume.val7, %middle.block ]
  %10 = add i64 %.01, -1, !dbg !172
  %11 = getelementptr inbounds i8* %src.03, i64 1, !dbg !173
  %12 = load i8* %src.03, align 1, !dbg !173, !tbaa !177
  %13 = getelementptr inbounds i8* %dest.02, i64 1, !dbg !173
  store i8 %12, i8* %dest.02, align 1, !dbg !173, !tbaa !177
  %14 = icmp eq i64 %10, 0, !dbg !172
  br i1 %14, label %._crit_edge, label %.lr.ph, !dbg !172, !llvm.loop !178

._crit_edge:                                      ; preds = %.lr.ph, %middle.block, %0
  ret i8* %destaddr, !dbg !179
}

; Function Attrs: nounwind uwtable
define weak i8* @memmove(i8* %dst, i8* %src, i64 %count) #4 {
  %1 = icmp eq i8* %src, %dst, !dbg !180
  br i1 %1, label %.loopexit, label %2, !dbg !180

; <label>:2                                       ; preds = %0
  %3 = icmp ugt i8* %src, %dst, !dbg !182
  br i1 %3, label %.preheader, label %18, !dbg !182

.preheader:                                       ; preds = %2
  %4 = icmp eq i64 %count, 0, !dbg !184
  br i1 %4, label %.loopexit, label %.lr.ph.preheader, !dbg !184

.lr.ph.preheader:                                 ; preds = %.preheader
  %n.vec = and i64 %count, -32
  %cmp.zero = icmp eq i64 %n.vec, 0
  %5 = add i64 %count, -1
  br i1 %cmp.zero, label %middle.block, label %vector.memcheck

vector.memcheck:                                  ; preds = %.lr.ph.preheader
  %scevgep11 = getelementptr i8* %src, i64 %5
  %scevgep = getelementptr i8* %dst, i64 %5
  %bound1 = icmp uge i8* %scevgep, %src
  %bound0 = icmp uge i8* %scevgep11, %dst
  %memcheck.conflict = and i1 %bound0, %bound1
  %ptr.ind.end = getelementptr i8* %src, i64 %n.vec
  %ptr.ind.end13 = getelementptr i8* %dst, i64 %n.vec
  %rev.ind.end = sub i64 %count, %n.vec
  br i1 %memcheck.conflict, label %middle.block, label %vector.body

vector.body:                                      ; preds = %vector.body, %vector.memcheck
  %index = phi i64 [ %index.next, %vector.body ], [ 0, %vector.memcheck ]
  %next.gep = getelementptr i8* %src, i64 %index
  %next.gep110 = getelementptr i8* %dst, i64 %index
  %6 = bitcast i8* %next.gep to <16 x i8>*, !dbg !184
  %wide.load = load <16 x i8>* %6, align 1, !dbg !184
  %next.gep.sum586 = or i64 %index, 16, !dbg !184
  %7 = getelementptr i8* %src, i64 %next.gep.sum586, !dbg !184
  %8 = bitcast i8* %7 to <16 x i8>*, !dbg !184
  %wide.load207 = load <16 x i8>* %8, align 1, !dbg !184
  %9 = bitcast i8* %next.gep110 to <16 x i8>*, !dbg !184
  store <16 x i8> %wide.load, <16 x i8>* %9, align 1, !dbg !184
  %10 = getelementptr i8* %dst, i64 %next.gep.sum586, !dbg !184
  %11 = bitcast i8* %10 to <16 x i8>*, !dbg !184
  store <16 x i8> %wide.load207, <16 x i8>* %11, align 1, !dbg !184
  %index.next = add i64 %index, 32
  %12 = icmp eq i64 %index.next, %n.vec
  br i1 %12, label %middle.block, label %vector.body, !llvm.loop !186

middle.block:                                     ; preds = %vector.body, %vector.memcheck, %.lr.ph.preheader
  %resume.val = phi i8* [ %src, %.lr.ph.preheader ], [ %src, %vector.memcheck ], [ %ptr.ind.end, %vector.body ]
  %resume.val12 = phi i8* [ %dst, %.lr.ph.preheader ], [ %dst, %vector.memcheck ], [ %ptr.ind.end13, %vector.body ]
  %resume.val14 = phi i64 [ %count, %.lr.ph.preheader ], [ %count, %vector.memcheck ], [ %rev.ind.end, %vector.body ]
  %new.indc.resume.val = phi i64 [ 0, %.lr.ph.preheader ], [ 0, %vector.memcheck ], [ %n.vec, %vector.body ]
  %cmp.n = icmp eq i64 %new.indc.resume.val, %count
  br i1 %cmp.n, label %.loopexit, label %.lr.ph

.lr.ph:                                           ; preds = %.lr.ph, %middle.block
  %b.04 = phi i8* [ %14, %.lr.ph ], [ %resume.val, %middle.block ]
  %a.03 = phi i8* [ %16, %.lr.ph ], [ %resume.val12, %middle.block ]
  %.02 = phi i64 [ %13, %.lr.ph ], [ %resume.val14, %middle.block ]
  %13 = add i64 %.02, -1, !dbg !184
  %14 = getelementptr inbounds i8* %b.04, i64 1, !dbg !184
  %15 = load i8* %b.04, align 1, !dbg !184, !tbaa !177
  %16 = getelementptr inbounds i8* %a.03, i64 1, !dbg !184
  store i8 %15, i8* %a.03, align 1, !dbg !184, !tbaa !177
  %17 = icmp eq i64 %13, 0, !dbg !184
  br i1 %17, label %.loopexit, label %.lr.ph, !dbg !184, !llvm.loop !187

; <label>:18                                      ; preds = %2
  %19 = add i64 %count, -1, !dbg !188
  %20 = icmp eq i64 %count, 0, !dbg !190
  br i1 %20, label %.loopexit, label %.lr.ph9, !dbg !190

.lr.ph9:                                          ; preds = %18
  %21 = getelementptr inbounds i8* %src, i64 %19, !dbg !191
  %22 = getelementptr inbounds i8* %dst, i64 %19, !dbg !188
  %n.vec215 = and i64 %count, -32
  %cmp.zero217 = icmp eq i64 %n.vec215, 0
  br i1 %cmp.zero217, label %middle.block210, label %vector.memcheck224

vector.memcheck224:                               ; preds = %.lr.ph9
  %bound1221 = icmp ule i8* %21, %dst
  %bound0220 = icmp ule i8* %22, %src
  %memcheck.conflict223 = and i1 %bound0220, %bound1221
  %.sum = sub i64 %19, %n.vec215
  %rev.ptr.ind.end = getelementptr i8* %src, i64 %.sum
  %rev.ptr.ind.end229 = getelementptr i8* %dst, i64 %.sum
  %rev.ind.end231 = sub i64 %count, %n.vec215
  br i1 %memcheck.conflict223, label %middle.block210, label %vector.body209

vector.body209:                                   ; preds = %vector.body209, %vector.memcheck224
  %index212 = phi i64 [ %index.next234, %vector.body209 ], [ 0, %vector.memcheck224 ]
  %.sum440 = sub i64 %19, %index212
  %next.gep236.sum = add i64 %.sum440, -15, !dbg !190
  %23 = getelementptr i8* %src, i64 %next.gep236.sum, !dbg !190
  %24 = bitcast i8* %23 to <16 x i8>*, !dbg !190
  %wide.load434 = load <16 x i8>* %24, align 1, !dbg !190
  %reverse = shufflevector <16 x i8> %wide.load434, <16 x i8> undef, <16 x i32> <i32 15, i32 14, i32 13, i32 12, i32 11, i32 10, i32 9, i32 8, i32 7, i32 6, i32 5, i32 4, i32 3, i32 2, i32 1, i32 0>, !dbg !190
  %.sum505 = add i64 %.sum440, -31, !dbg !190
  %25 = getelementptr i8* %src, i64 %.sum505, !dbg !190
  %26 = bitcast i8* %25 to <16 x i8>*, !dbg !190
  %wide.load435 = load <16 x i8>* %26, align 1, !dbg !190
  %reverse436 = shufflevector <16 x i8> %wide.load435, <16 x i8> undef, <16 x i32> <i32 15, i32 14, i32 13, i32 12, i32 11, i32 10, i32 9, i32 8, i32 7, i32 6, i32 5, i32 4, i32 3, i32 2, i32 1, i32 0>, !dbg !190
  %reverse437 = shufflevector <16 x i8> %reverse, <16 x i8> undef, <16 x i32> <i32 15, i32 14, i32 13, i32 12, i32 11, i32 10, i32 9, i32 8, i32 7, i32 6, i32 5, i32 4, i32 3, i32 2, i32 1, i32 0>, !dbg !190
  %27 = getelementptr i8* %dst, i64 %next.gep236.sum, !dbg !190
  %28 = bitcast i8* %27 to <16 x i8>*, !dbg !190
  store <16 x i8> %reverse437, <16 x i8>* %28, align 1, !dbg !190
  %reverse438 = shufflevector <16 x i8> %reverse436, <16 x i8> undef, <16 x i32> <i32 15, i32 14, i32 13, i32 12, i32 11, i32 10, i32 9, i32 8, i32 7, i32 6, i32 5, i32 4, i32 3, i32 2, i32 1, i32 0>, !dbg !190
  %29 = getelementptr i8* %dst, i64 %.sum505, !dbg !190
  %30 = bitcast i8* %29 to <16 x i8>*, !dbg !190
  store <16 x i8> %reverse438, <16 x i8>* %30, align 1, !dbg !190
  %index.next234 = add i64 %index212, 32
  %31 = icmp eq i64 %index.next234, %n.vec215
  br i1 %31, label %middle.block210, label %vector.body209, !llvm.loop !192

middle.block210:                                  ; preds = %vector.body209, %vector.memcheck224, %.lr.ph9
  %resume.val225 = phi i8* [ %21, %.lr.ph9 ], [ %21, %vector.memcheck224 ], [ %rev.ptr.ind.end, %vector.body209 ]
  %resume.val227 = phi i8* [ %22, %.lr.ph9 ], [ %22, %vector.memcheck224 ], [ %rev.ptr.ind.end229, %vector.body209 ]
  %resume.val230 = phi i64 [ %count, %.lr.ph9 ], [ %count, %vector.memcheck224 ], [ %rev.ind.end231, %vector.body209 ]
  %new.indc.resume.val232 = phi i64 [ 0, %.lr.ph9 ], [ 0, %vector.memcheck224 ], [ %n.vec215, %vector.body209 ]
  %cmp.n233 = icmp eq i64 %new.indc.resume.val232, %count
  br i1 %cmp.n233, label %.loopexit, label %scalar.ph211

scalar.ph211:                                     ; preds = %scalar.ph211, %middle.block210
  %b.18 = phi i8* [ %33, %scalar.ph211 ], [ %resume.val225, %middle.block210 ]
  %a.17 = phi i8* [ %35, %scalar.ph211 ], [ %resume.val227, %middle.block210 ]
  %.16 = phi i64 [ %32, %scalar.ph211 ], [ %resume.val230, %middle.block210 ]
  %32 = add i64 %.16, -1, !dbg !190
  %33 = getelementptr inbounds i8* %b.18, i64 -1, !dbg !190
  %34 = load i8* %b.18, align 1, !dbg !190, !tbaa !177
  %35 = getelementptr inbounds i8* %a.17, i64 -1, !dbg !190
  store i8 %34, i8* %a.17, align 1, !dbg !190, !tbaa !177
  %36 = icmp eq i64 %32, 0, !dbg !190
  br i1 %36, label %.loopexit, label %scalar.ph211, !dbg !190, !llvm.loop !193

.loopexit:                                        ; preds = %scalar.ph211, %middle.block210, %18, %.lr.ph, %middle.block, %.preheader, %0
  ret i8* %dst, !dbg !194
}

; Function Attrs: nounwind uwtable
define weak i8* @mempcpy(i8* %destaddr, i8* %srcaddr, i64 %len) #4 {
  %1 = icmp eq i64 %len, 0, !dbg !195
  br i1 %1, label %15, label %.lr.ph.preheader, !dbg !195

.lr.ph.preheader:                                 ; preds = %0
  %n.vec = and i64 %len, -32
  %cmp.zero = icmp eq i64 %n.vec, 0
  %2 = add i64 %len, -1
  br i1 %cmp.zero, label %middle.block, label %vector.memcheck

vector.memcheck:                                  ; preds = %.lr.ph.preheader
  %scevgep5 = getelementptr i8* %srcaddr, i64 %2
  %scevgep4 = getelementptr i8* %destaddr, i64 %2
  %bound1 = icmp uge i8* %scevgep4, %srcaddr
  %bound0 = icmp uge i8* %scevgep5, %destaddr
  %memcheck.conflict = and i1 %bound0, %bound1
  %ptr.ind.end = getelementptr i8* %srcaddr, i64 %n.vec
  %ptr.ind.end7 = getelementptr i8* %destaddr, i64 %n.vec
  %rev.ind.end = sub i64 %len, %n.vec
  br i1 %memcheck.conflict, label %middle.block, label %vector.body

vector.body:                                      ; preds = %vector.body, %vector.memcheck
  %index = phi i64 [ %index.next, %vector.body ], [ 0, %vector.memcheck ]
  %next.gep = getelementptr i8* %srcaddr, i64 %index
  %next.gep104 = getelementptr i8* %destaddr, i64 %index
  %3 = bitcast i8* %next.gep to <16 x i8>*, !dbg !196
  %wide.load = load <16 x i8>* %3, align 1, !dbg !196
  %next.gep.sum280 = or i64 %index, 16, !dbg !196
  %4 = getelementptr i8* %srcaddr, i64 %next.gep.sum280, !dbg !196
  %5 = bitcast i8* %4 to <16 x i8>*, !dbg !196
  %wide.load201 = load <16 x i8>* %5, align 1, !dbg !196
  %6 = bitcast i8* %next.gep104 to <16 x i8>*, !dbg !196
  store <16 x i8> %wide.load, <16 x i8>* %6, align 1, !dbg !196
  %7 = getelementptr i8* %destaddr, i64 %next.gep.sum280, !dbg !196
  %8 = bitcast i8* %7 to <16 x i8>*, !dbg !196
  store <16 x i8> %wide.load201, <16 x i8>* %8, align 1, !dbg !196
  %index.next = add i64 %index, 32
  %9 = icmp eq i64 %index.next, %n.vec
  br i1 %9, label %middle.block, label %vector.body, !llvm.loop !197

middle.block:                                     ; preds = %vector.body, %vector.memcheck, %.lr.ph.preheader
  %resume.val = phi i8* [ %srcaddr, %.lr.ph.preheader ], [ %srcaddr, %vector.memcheck ], [ %ptr.ind.end, %vector.body ]
  %resume.val6 = phi i8* [ %destaddr, %.lr.ph.preheader ], [ %destaddr, %vector.memcheck ], [ %ptr.ind.end7, %vector.body ]
  %resume.val8 = phi i64 [ %len, %.lr.ph.preheader ], [ %len, %vector.memcheck ], [ %rev.ind.end, %vector.body ]
  %new.indc.resume.val = phi i64 [ 0, %.lr.ph.preheader ], [ 0, %vector.memcheck ], [ %n.vec, %vector.body ]
  %cmp.n = icmp eq i64 %new.indc.resume.val, %len
  br i1 %cmp.n, label %._crit_edge, label %.lr.ph

.lr.ph:                                           ; preds = %.lr.ph, %middle.block
  %src.03 = phi i8* [ %11, %.lr.ph ], [ %resume.val, %middle.block ]
  %dest.02 = phi i8* [ %13, %.lr.ph ], [ %resume.val6, %middle.block ]
  %.01 = phi i64 [ %10, %.lr.ph ], [ %resume.val8, %middle.block ]
  %10 = add i64 %.01, -1, !dbg !195
  %11 = getelementptr inbounds i8* %src.03, i64 1, !dbg !196
  %12 = load i8* %src.03, align 1, !dbg !196, !tbaa !177
  %13 = getelementptr inbounds i8* %dest.02, i64 1, !dbg !196
  store i8 %12, i8* %dest.02, align 1, !dbg !196, !tbaa !177
  %14 = icmp eq i64 %10, 0, !dbg !195
  br i1 %14, label %._crit_edge, label %.lr.ph, !dbg !195, !llvm.loop !198

._crit_edge:                                      ; preds = %.lr.ph, %middle.block
  %scevgep = getelementptr i8* %destaddr, i64 %len
  br label %15, !dbg !195

; <label>:15                                      ; preds = %._crit_edge, %0
  %dest.0.lcssa = phi i8* [ %scevgep, %._crit_edge ], [ %destaddr, %0 ]
  ret i8* %dest.0.lcssa, !dbg !199
}

; Function Attrs: nounwind uwtable
define weak i8* @memset(i8* %dst, i32 %s, i64 %count) #4 {
  %1 = icmp eq i64 %count, 0, !dbg !200
  br i1 %1, label %._crit_edge, label %.lr.ph, !dbg !200

.lr.ph:                                           ; preds = %0
  %2 = trunc i32 %s to i8, !dbg !201
  br label %3, !dbg !200

; <label>:3                                       ; preds = %3, %.lr.ph
  %a.02 = phi i8* [ %dst, %.lr.ph ], [ %5, %3 ]
  %.01 = phi i64 [ %count, %.lr.ph ], [ %4, %3 ]
  %4 = add i64 %.01, -1, !dbg !200
  %5 = getelementptr inbounds i8* %a.02, i64 1, !dbg !201
  store volatile i8 %2, i8* %a.02, align 1, !dbg !201, !tbaa !177
  %6 = icmp eq i64 %4, 0, !dbg !200
  br i1 %6, label %._crit_edge, label %3, !dbg !200

._crit_edge:                                      ; preds = %3, %0
  ret i8* %dst, !dbg !202
}

attributes #0 = { nounwind uwtable "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float
attributes #1 = { nounwind readnone }
attributes #2 = { "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #3 = { noreturn "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false
attributes #4 = { nounwind uwtable "less-precise-fpmad"="false" "no-frame-pointer-elim"="false" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #5 = { noreturn "less-precise-fpmad"="false" "no-frame-pointer-elim"="false" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #6 = { "less-precise-fpmad"="false" "no-frame-pointer-elim"="false" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #7 = { nobuiltin noreturn nounwind }
attributes #8 = { nobuiltin nounwind }

!llvm.dbg.cu = !{!0, !13, !24, !38, !50, !63, !83, !98, !113}
!llvm.module.flags = !{!129, !130}
!llvm.ident = !{!131, !131, !131, !131, !131, !131, !131, !131, !131}

!0 = metadata !{i32 786449, metadata !1, i32 12, metadata !"clang version 3.4.2 (tags/RELEASE_34/dot2-final)", i1 false, metadata !"", i32 0, metadata !2, metadata !2, metadata !3, metadata !2, metadata !2, metadata !""} ; [ DW_TAG_compile_unit ] [/home/
!1 = metadata !{metadata !"/home/sanghu/TracerX/tracerx/test/Feature/InAndOutOfBounds.c", metadata !"/home/sanghu/TracerX/tracerx/test/Feature"}
!2 = metadata !{i32 0}
!3 = metadata !{metadata !4, metadata !9}
!4 = metadata !{i32 786478, metadata !1, metadata !5, metadata !"klee_urange", metadata !"klee_urange", metadata !"", i32 8, metadata !6, i1 false, i1 true, i32 0, i32 0, null, i32 256, i1 false, i32 (i32, i32)* @klee_urange, null, null, metadata !2, i32
!5 = metadata !{i32 786473, metadata !1}          ; [ DW_TAG_file_type ] [/home/sanghu/TracerX/tracerx/test/Feature//home/sanghu/TracerX/tracerx/test/Feature/InAndOutOfBounds.c]
!6 = metadata !{i32 786453, i32 0, null, metadata !"", i32 0, i64 0, i64 0, i64 0, i32 0, null, metadata !7, i32 0, null, null, null} ; [ DW_TAG_subroutine_type ] [line 0, size 0, align 0, offset 0] [from ]
!7 = metadata !{metadata !8, metadata !8, metadata !8}
!8 = metadata !{i32 786468, null, null, metadata !"unsigned int", i32 0, i64 32, i64 32, i64 0, i32 0, i32 7} ; [ DW_TAG_base_type ] [unsigned int] [line 0, size 32, align 32, offset 0, enc DW_ATE_unsigned]
!9 = metadata !{i32 786478, metadata !1, metadata !5, metadata !"main", metadata !"main", metadata !"", i32 15, metadata !10, i1 false, i1 true, i32 0, i32 0, null, i32 0, i1 false, i32 ()* @main, null, null, metadata !2, i32 15} ; [ DW_TAG_subprogram ] 
!10 = metadata !{i32 786453, i32 0, null, metadata !"", i32 0, i64 0, i64 0, i64 0, i32 0, null, metadata !11, i32 0, null, null, null} ; [ DW_TAG_subroutine_type ] [line 0, size 0, align 0, offset 0] [from ]
!11 = metadata !{metadata !12}
!12 = metadata !{i32 786468, null, null, metadata !"int", i32 0, i64 32, i64 32, i64 0, i32 0, i32 5} ; [ DW_TAG_base_type ] [int] [line 0, size 32, align 32, offset 0, enc DW_ATE_signed]
!13 = metadata !{i32 786449, metadata !14, i32 1, metadata !"clang version 3.4.2 (tags/RELEASE_34/dot2-final)", i1 true, metadata !"", i32 0, metadata !2, metadata !2, metadata !15, metadata !2, metadata !2, metadata !""} ; [ DW_TAG_compile_unit ] [/home
!14 = metadata !{metadata !"/home/sanghu/TracerX/tracerx/runtime/Intrinsic/klee_div_zero_check.c", metadata !"/home/sanghu/TracerX/tracerx/runtime/Intrinsic"}
!15 = metadata !{metadata !16}
!16 = metadata !{i32 786478, metadata !17, metadata !18, metadata !"klee_div_zero_check", metadata !"klee_div_zero_check", metadata !"", i32 12, metadata !19, i1 false, i1 true, i32 0, i32 0, null, i32 256, i1 true, void (i64)* @klee_div_zero_check, null
!17 = metadata !{metadata !"klee_div_zero_check.c", metadata !"/home/sanghu/TracerX/tracerx/runtime/Intrinsic"}
!18 = metadata !{i32 786473, metadata !17}        ; [ DW_TAG_file_type ] [/home/sanghu/TracerX/tracerx/runtime/Intrinsic/klee_div_zero_check.c]
!19 = metadata !{i32 786453, i32 0, null, metadata !"", i32 0, i64 0, i64 0, i64 0, i32 0, null, metadata !20, i32 0, null, null, null} ; [ DW_TAG_subroutine_type ] [line 0, size 0, align 0, offset 0] [from ]
!20 = metadata !{null, metadata !21}
!21 = metadata !{i32 786468, null, null, metadata !"long long int", i32 0, i64 64, i64 64, i64 0, i32 0, i32 5} ; [ DW_TAG_base_type ] [long long int] [line 0, size 64, align 64, offset 0, enc DW_ATE_signed]
!22 = metadata !{metadata !23}
!23 = metadata !{i32 786689, metadata !16, metadata !"z", metadata !18, i32 16777228, metadata !21, i32 0, i32 0} ; [ DW_TAG_arg_variable ] [z] [line 12]
!24 = metadata !{i32 786449, metadata !25, i32 1, metadata !"clang version 3.4.2 (tags/RELEASE_34/dot2-final)", i1 true, metadata !"", i32 0, metadata !2, metadata !2, metadata !26, metadata !2, metadata !2, metadata !""} ; [ DW_TAG_compile_unit ] [/home
!25 = metadata !{metadata !"/home/sanghu/TracerX/tracerx/runtime/Intrinsic/klee_int.c", metadata !"/home/sanghu/TracerX/tracerx/runtime/Intrinsic"}
!26 = metadata !{metadata !27}
!27 = metadata !{i32 786478, metadata !28, metadata !29, metadata !"klee_int", metadata !"klee_int", metadata !"", i32 13, metadata !30, i1 false, i1 true, i32 0, i32 0, null, i32 256, i1 true, i32 (i8*)* @klee_int, null, null, metadata !35, i32 13} ; [ 
!28 = metadata !{metadata !"klee_int.c", metadata !"/home/sanghu/TracerX/tracerx/runtime/Intrinsic"}
!29 = metadata !{i32 786473, metadata !28}        ; [ DW_TAG_file_type ] [/home/sanghu/TracerX/tracerx/runtime/Intrinsic/klee_int.c]
!30 = metadata !{i32 786453, i32 0, null, metadata !"", i32 0, i64 0, i64 0, i64 0, i32 0, null, metadata !31, i32 0, null, null, null} ; [ DW_TAG_subroutine_type ] [line 0, size 0, align 0, offset 0] [from ]
!31 = metadata !{metadata !12, metadata !32}
!32 = metadata !{i32 786447, null, null, metadata !"", i32 0, i64 64, i64 64, i64 0, i32 0, metadata !33} ; [ DW_TAG_pointer_type ] [line 0, size 64, align 64, offset 0] [from ]
!33 = metadata !{i32 786470, null, null, metadata !"", i32 0, i64 0, i64 0, i64 0, i32 0, metadata !34} ; [ DW_TAG_const_type ] [line 0, size 0, align 0, offset 0] [from char]
!34 = metadata !{i32 786468, null, null, metadata !"char", i32 0, i64 8, i64 8, i64 0, i32 0, i32 6} ; [ DW_TAG_base_type ] [char] [line 0, size 8, align 8, offset 0, enc DW_ATE_signed_char]
!35 = metadata !{metadata !36, metadata !37}
!36 = metadata !{i32 786689, metadata !27, metadata !"name", metadata !29, i32 16777229, metadata !32, i32 0, i32 0} ; [ DW_TAG_arg_variable ] [name] [line 13]
!37 = metadata !{i32 786688, metadata !27, metadata !"x", metadata !29, i32 14, metadata !12, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [x] [line 14]
!38 = metadata !{i32 786449, metadata !39, i32 1, metadata !"clang version 3.4.2 (tags/RELEASE_34/dot2-final)", i1 true, metadata !"", i32 0, metadata !2, metadata !2, metadata !40, metadata !2, metadata !2, metadata !""} ; [ DW_TAG_compile_unit ] [/home
!39 = metadata !{metadata !"/home/sanghu/TracerX/tracerx/runtime/Intrinsic/klee_overshift_check.c", metadata !"/home/sanghu/TracerX/tracerx/runtime/Intrinsic"}
!40 = metadata !{metadata !41}
!41 = metadata !{i32 786478, metadata !42, metadata !43, metadata !"klee_overshift_check", metadata !"klee_overshift_check", metadata !"", i32 20, metadata !44, i1 false, i1 true, i32 0, i32 0, null, i32 256, i1 true, void (i64, i64)* @klee_overshift_che
!42 = metadata !{metadata !"klee_overshift_check.c", metadata !"/home/sanghu/TracerX/tracerx/runtime/Intrinsic"}
!43 = metadata !{i32 786473, metadata !42}        ; [ DW_TAG_file_type ] [/home/sanghu/TracerX/tracerx/runtime/Intrinsic/klee_overshift_check.c]
!44 = metadata !{i32 786453, i32 0, null, metadata !"", i32 0, i64 0, i64 0, i64 0, i32 0, null, metadata !45, i32 0, null, null, null} ; [ DW_TAG_subroutine_type ] [line 0, size 0, align 0, offset 0] [from ]
!45 = metadata !{null, metadata !46, metadata !46}
!46 = metadata !{i32 786468, null, null, metadata !"long long unsigned int", i32 0, i64 64, i64 64, i64 0, i32 0, i32 7} ; [ DW_TAG_base_type ] [long long unsigned int] [line 0, size 64, align 64, offset 0, enc DW_ATE_unsigned]
!47 = metadata !{metadata !48, metadata !49}
!48 = metadata !{i32 786689, metadata !41, metadata !"bitWidth", metadata !43, i32 16777236, metadata !46, i32 0, i32 0} ; [ DW_TAG_arg_variable ] [bitWidth] [line 20]
!49 = metadata !{i32 786689, metadata !41, metadata !"shift", metadata !43, i32 33554452, metadata !46, i32 0, i32 0} ; [ DW_TAG_arg_variable ] [shift] [line 20]
!50 = metadata !{i32 786449, metadata !51, i32 1, metadata !"clang version 3.4.2 (tags/RELEASE_34/dot2-final)", i1 true, metadata !"", i32 0, metadata !2, metadata !2, metadata !52, metadata !2, metadata !2, metadata !""} ; [ DW_TAG_compile_unit ] [/home
!51 = metadata !{metadata !"/home/sanghu/TracerX/tracerx/runtime/Intrinsic/klee_range.c", metadata !"/home/sanghu/TracerX/tracerx/runtime/Intrinsic"}
!52 = metadata !{metadata !53}
!53 = metadata !{i32 786478, metadata !54, metadata !55, metadata !"klee_range", metadata !"klee_range", metadata !"", i32 13, metadata !56, i1 false, i1 true, i32 0, i32 0, null, i32 256, i1 true, i32 (i32, i32, i8*)* @klee_range, null, null, metadata !
!54 = metadata !{metadata !"klee_range.c", metadata !"/home/sanghu/TracerX/tracerx/runtime/Intrinsic"}
!55 = metadata !{i32 786473, metadata !54}        ; [ DW_TAG_file_type ] [/home/sanghu/TracerX/tracerx/runtime/Intrinsic/klee_range.c]
!56 = metadata !{i32 786453, i32 0, null, metadata !"", i32 0, i64 0, i64 0, i64 0, i32 0, null, metadata !57, i32 0, null, null, null} ; [ DW_TAG_subroutine_type ] [line 0, size 0, align 0, offset 0] [from ]
!57 = metadata !{metadata !12, metadata !12, metadata !12, metadata !32}
!58 = metadata !{metadata !59, metadata !60, metadata !61, metadata !62}
!59 = metadata !{i32 786689, metadata !53, metadata !"start", metadata !55, i32 16777229, metadata !12, i32 0, i32 0} ; [ DW_TAG_arg_variable ] [start] [line 13]
!60 = metadata !{i32 786689, metadata !53, metadata !"end", metadata !55, i32 33554445, metadata !12, i32 0, i32 0} ; [ DW_TAG_arg_variable ] [end] [line 13]
!61 = metadata !{i32 786689, metadata !53, metadata !"name", metadata !55, i32 50331661, metadata !32, i32 0, i32 0} ; [ DW_TAG_arg_variable ] [name] [line 13]
!62 = metadata !{i32 786688, metadata !53, metadata !"x", metadata !55, i32 14, metadata !12, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [x] [line 14]
!63 = metadata !{i32 786449, metadata !64, i32 1, metadata !"clang version 3.4.2 (tags/RELEASE_34/dot2-final)", i1 true, metadata !"", i32 0, metadata !2, metadata !2, metadata !65, metadata !2, metadata !2, metadata !""} ; [ DW_TAG_compile_unit ] [/home
!64 = metadata !{metadata !"/home/sanghu/TracerX/tracerx/runtime/Intrinsic/memcpy.c", metadata !"/home/sanghu/TracerX/tracerx/runtime/Intrinsic"}
!65 = metadata !{metadata !66}
!66 = metadata !{i32 786478, metadata !67, metadata !68, metadata !"memcpy", metadata !"memcpy", metadata !"", i32 12, metadata !69, i1 false, i1 true, i32 0, i32 0, null, i32 256, i1 true, i8* (i8*, i8*, i64)* @memcpy, null, null, metadata !76, i32 12} 
!67 = metadata !{metadata !"memcpy.c", metadata !"/home/sanghu/TracerX/tracerx/runtime/Intrinsic"}
!68 = metadata !{i32 786473, metadata !67}        ; [ DW_TAG_file_type ] [/home/sanghu/TracerX/tracerx/runtime/Intrinsic/memcpy.c]
!69 = metadata !{i32 786453, i32 0, null, metadata !"", i32 0, i64 0, i64 0, i64 0, i32 0, null, metadata !70, i32 0, null, null, null} ; [ DW_TAG_subroutine_type ] [line 0, size 0, align 0, offset 0] [from ]
!70 = metadata !{metadata !71, metadata !71, metadata !72, metadata !74}
!71 = metadata !{i32 786447, null, null, metadata !"", i32 0, i64 64, i64 64, i64 0, i32 0, null} ; [ DW_TAG_pointer_type ] [line 0, size 64, align 64, offset 0] [from ]
!72 = metadata !{i32 786447, null, null, metadata !"", i32 0, i64 64, i64 64, i64 0, i32 0, metadata !73} ; [ DW_TAG_pointer_type ] [line 0, size 64, align 64, offset 0] [from ]
!73 = metadata !{i32 786470, null, null, metadata !"", i32 0, i64 0, i64 0, i64 0, i32 0, null} ; [ DW_TAG_const_type ] [line 0, size 0, align 0, offset 0] [from ]
!74 = metadata !{i32 786454, metadata !67, null, metadata !"size_t", i32 42, i64 0, i64 0, i64 0, i32 0, metadata !75} ; [ DW_TAG_typedef ] [size_t] [line 42, size 0, align 0, offset 0] [from long unsigned int]
!75 = metadata !{i32 786468, null, null, metadata !"long unsigned int", i32 0, i64 64, i64 64, i64 0, i32 0, i32 7} ; [ DW_TAG_base_type ] [long unsigned int] [line 0, size 64, align 64, offset 0, enc DW_ATE_unsigned]
!76 = metadata !{metadata !77, metadata !78, metadata !79, metadata !80, metadata !82}
!77 = metadata !{i32 786689, metadata !66, metadata !"destaddr", metadata !68, i32 16777228, metadata !71, i32 0, i32 0} ; [ DW_TAG_arg_variable ] [destaddr] [line 12]
!78 = metadata !{i32 786689, metadata !66, metadata !"srcaddr", metadata !68, i32 33554444, metadata !72, i32 0, i32 0} ; [ DW_TAG_arg_variable ] [srcaddr] [line 12]
!79 = metadata !{i32 786689, metadata !66, metadata !"len", metadata !68, i32 50331660, metadata !74, i32 0, i32 0} ; [ DW_TAG_arg_variable ] [len] [line 12]
!80 = metadata !{i32 786688, metadata !66, metadata !"dest", metadata !68, i32 13, metadata !81, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [dest] [line 13]
!81 = metadata !{i32 786447, null, null, metadata !"", i32 0, i64 64, i64 64, i64 0, i32 0, metadata !34} ; [ DW_TAG_pointer_type ] [line 0, size 64, align 64, offset 0] [from char]
!82 = metadata !{i32 786688, metadata !66, metadata !"src", metadata !68, i32 14, metadata !32, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [src] [line 14]
!83 = metadata !{i32 786449, metadata !84, i32 1, metadata !"clang version 3.4.2 (tags/RELEASE_34/dot2-final)", i1 true, metadata !"", i32 0, metadata !2, metadata !2, metadata !85, metadata !2, metadata !2, metadata !""} ; [ DW_TAG_compile_unit ] [/home
!84 = metadata !{metadata !"/home/sanghu/TracerX/tracerx/runtime/Intrinsic/memmove.c", metadata !"/home/sanghu/TracerX/tracerx/runtime/Intrinsic"}
!85 = metadata !{metadata !86}
!86 = metadata !{i32 786478, metadata !87, metadata !88, metadata !"memmove", metadata !"memmove", metadata !"", i32 12, metadata !89, i1 false, i1 true, i32 0, i32 0, null, i32 256, i1 true, i8* (i8*, i8*, i64)* @memmove, null, null, metadata !92, i32 1
!87 = metadata !{metadata !"memmove.c", metadata !"/home/sanghu/TracerX/tracerx/runtime/Intrinsic"}
!88 = metadata !{i32 786473, metadata !87}        ; [ DW_TAG_file_type ] [/home/sanghu/TracerX/tracerx/runtime/Intrinsic/memmove.c]
!89 = metadata !{i32 786453, i32 0, null, metadata !"", i32 0, i64 0, i64 0, i64 0, i32 0, null, metadata !90, i32 0, null, null, null} ; [ DW_TAG_subroutine_type ] [line 0, size 0, align 0, offset 0] [from ]
!90 = metadata !{metadata !71, metadata !71, metadata !72, metadata !91}
!91 = metadata !{i32 786454, metadata !87, null, metadata !"size_t", i32 42, i64 0, i64 0, i64 0, i32 0, metadata !75} ; [ DW_TAG_typedef ] [size_t] [line 42, size 0, align 0, offset 0] [from long unsigned int]
!92 = metadata !{metadata !93, metadata !94, metadata !95, metadata !96, metadata !97}
!93 = metadata !{i32 786689, metadata !86, metadata !"dst", metadata !88, i32 16777228, metadata !71, i32 0, i32 0} ; [ DW_TAG_arg_variable ] [dst] [line 12]
!94 = metadata !{i32 786689, metadata !86, metadata !"src", metadata !88, i32 33554444, metadata !72, i32 0, i32 0} ; [ DW_TAG_arg_variable ] [src] [line 12]
!95 = metadata !{i32 786689, metadata !86, metadata !"count", metadata !88, i32 50331660, metadata !91, i32 0, i32 0} ; [ DW_TAG_arg_variable ] [count] [line 12]
!96 = metadata !{i32 786688, metadata !86, metadata !"a", metadata !88, i32 13, metadata !81, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [a] [line 13]
!97 = metadata !{i32 786688, metadata !86, metadata !"b", metadata !88, i32 14, metadata !32, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [b] [line 14]
!98 = metadata !{i32 786449, metadata !99, i32 1, metadata !"clang version 3.4.2 (tags/RELEASE_34/dot2-final)", i1 true, metadata !"", i32 0, metadata !2, metadata !2, metadata !100, metadata !2, metadata !2, metadata !""} ; [ DW_TAG_compile_unit ] [/hom
!99 = metadata !{metadata !"/home/sanghu/TracerX/tracerx/runtime/Intrinsic/mempcpy.c", metadata !"/home/sanghu/TracerX/tracerx/runtime/Intrinsic"}
!100 = metadata !{metadata !101}
!101 = metadata !{i32 786478, metadata !102, metadata !103, metadata !"mempcpy", metadata !"mempcpy", metadata !"", i32 11, metadata !104, i1 false, i1 true, i32 0, i32 0, null, i32 256, i1 true, i8* (i8*, i8*, i64)* @mempcpy, null, null, metadata !107, 
!102 = metadata !{metadata !"mempcpy.c", metadata !"/home/sanghu/TracerX/tracerx/runtime/Intrinsic"}
!103 = metadata !{i32 786473, metadata !102}      ; [ DW_TAG_file_type ] [/home/sanghu/TracerX/tracerx/runtime/Intrinsic/mempcpy.c]
!104 = metadata !{i32 786453, i32 0, null, metadata !"", i32 0, i64 0, i64 0, i64 0, i32 0, null, metadata !105, i32 0, null, null, null} ; [ DW_TAG_subroutine_type ] [line 0, size 0, align 0, offset 0] [from ]
!105 = metadata !{metadata !71, metadata !71, metadata !72, metadata !106}
!106 = metadata !{i32 786454, metadata !102, null, metadata !"size_t", i32 42, i64 0, i64 0, i64 0, i32 0, metadata !75} ; [ DW_TAG_typedef ] [size_t] [line 42, size 0, align 0, offset 0] [from long unsigned int]
!107 = metadata !{metadata !108, metadata !109, metadata !110, metadata !111, metadata !112}
!108 = metadata !{i32 786689, metadata !101, metadata !"destaddr", metadata !103, i32 16777227, metadata !71, i32 0, i32 0} ; [ DW_TAG_arg_variable ] [destaddr] [line 11]
!109 = metadata !{i32 786689, metadata !101, metadata !"srcaddr", metadata !103, i32 33554443, metadata !72, i32 0, i32 0} ; [ DW_TAG_arg_variable ] [srcaddr] [line 11]
!110 = metadata !{i32 786689, metadata !101, metadata !"len", metadata !103, i32 50331659, metadata !106, i32 0, i32 0} ; [ DW_TAG_arg_variable ] [len] [line 11]
!111 = metadata !{i32 786688, metadata !101, metadata !"dest", metadata !103, i32 12, metadata !81, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [dest] [line 12]
!112 = metadata !{i32 786688, metadata !101, metadata !"src", metadata !103, i32 13, metadata !32, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [src] [line 13]
!113 = metadata !{i32 786449, metadata !114, i32 1, metadata !"clang version 3.4.2 (tags/RELEASE_34/dot2-final)", i1 true, metadata !"", i32 0, metadata !2, metadata !2, metadata !115, metadata !2, metadata !2, metadata !""} ; [ DW_TAG_compile_unit ] [/h
!114 = metadata !{metadata !"/home/sanghu/TracerX/tracerx/runtime/Intrinsic/memset.c", metadata !"/home/sanghu/TracerX/tracerx/runtime/Intrinsic"}
!115 = metadata !{metadata !116}
!116 = metadata !{i32 786478, metadata !117, metadata !118, metadata !"memset", metadata !"memset", metadata !"", i32 11, metadata !119, i1 false, i1 true, i32 0, i32 0, null, i32 256, i1 true, i8* (i8*, i32, i64)* @memset, null, null, metadata !122, i32
!117 = metadata !{metadata !"memset.c", metadata !"/home/sanghu/TracerX/tracerx/runtime/Intrinsic"}
!118 = metadata !{i32 786473, metadata !117}      ; [ DW_TAG_file_type ] [/home/sanghu/TracerX/tracerx/runtime/Intrinsic/memset.c]
!119 = metadata !{i32 786453, i32 0, null, metadata !"", i32 0, i64 0, i64 0, i64 0, i32 0, null, metadata !120, i32 0, null, null, null} ; [ DW_TAG_subroutine_type ] [line 0, size 0, align 0, offset 0] [from ]
!120 = metadata !{metadata !71, metadata !71, metadata !12, metadata !121}
!121 = metadata !{i32 786454, metadata !117, null, metadata !"size_t", i32 42, i64 0, i64 0, i64 0, i32 0, metadata !75} ; [ DW_TAG_typedef ] [size_t] [line 42, size 0, align 0, offset 0] [from long unsigned int]
!122 = metadata !{metadata !123, metadata !124, metadata !125, metadata !126}
!123 = metadata !{i32 786689, metadata !116, metadata !"dst", metadata !118, i32 16777227, metadata !71, i32 0, i32 0} ; [ DW_TAG_arg_variable ] [dst] [line 11]
!124 = metadata !{i32 786689, metadata !116, metadata !"s", metadata !118, i32 33554443, metadata !12, i32 0, i32 0} ; [ DW_TAG_arg_variable ] [s] [line 11]
!125 = metadata !{i32 786689, metadata !116, metadata !"count", metadata !118, i32 50331659, metadata !121, i32 0, i32 0} ; [ DW_TAG_arg_variable ] [count] [line 11]
!126 = metadata !{i32 786688, metadata !116, metadata !"a", metadata !118, i32 12, metadata !127, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [a] [line 12]
!127 = metadata !{i32 786447, null, null, metadata !"", i32 0, i64 64, i64 64, i64 0, i32 0, metadata !128} ; [ DW_TAG_pointer_type ] [line 0, size 64, align 64, offset 0] [from ]
!128 = metadata !{i32 786485, null, null, metadata !"", i32 0, i64 0, i64 0, i64 0, i32 0, metadata !34} ; [ DW_TAG_volatile_type ] [line 0, size 0, align 0, offset 0] [from char]
!129 = metadata !{i32 2, metadata !"Dwarf Version", i32 4}
!130 = metadata !{i32 1, metadata !"Debug Info Version", i32 1}
!131 = metadata !{metadata !"clang version 3.4.2 (tags/RELEASE_34/dot2-final)"}
!132 = metadata !{i32 10, i32 0, metadata !4, null}
!133 = metadata !{i32 11, i32 0, metadata !134, null}
!134 = metadata !{i32 786443, metadata !1, metadata !4, i32 11, i32 0, i32 0} ; [ DW_TAG_lexical_block ] [/home/sanghu/TracerX/tracerx/test/Feature//home/sanghu/TracerX/tracerx/test/Feature/InAndOutOfBounds.c]
!135 = metadata !{i32 12, i32 0, metadata !4, null}
!136 = metadata !{i32 16, i32 0, metadata !9, null}
!137 = metadata !{i32 19, i32 0, metadata !9, null}
!138 = metadata !{i32 20, i32 0, metadata !9, null}
!139 = metadata !{i32 21, i32 0, metadata !9, null}
!140 = metadata !{i32 13, i32 0, metadata !141, null}
!141 = metadata !{i32 786443, metadata !17, metadata !16, i32 13, i32 0, i32 0} ; [ DW_TAG_lexical_block ] [/home/sanghu/TracerX/tracerx/runtime/Intrinsic/klee_div_zero_check.c]
!142 = metadata !{i32 14, i32 0, metadata !141, null}
!143 = metadata !{i32 15, i32 0, metadata !16, null}
!144 = metadata !{i32 15, i32 0, metadata !27, null}
!145 = metadata !{i32 16, i32 0, metadata !27, null}
!146 = metadata !{metadata !147, metadata !147, i64 0}
!147 = metadata !{metadata !"int", metadata !148, i64 0}
!148 = metadata !{metadata !"omnipotent char", metadata !149, i64 0}
!149 = metadata !{metadata !"Simple C/C++ TBAA"}
!150 = metadata !{i32 21, i32 0, metadata !151, null}
!151 = metadata !{i32 786443, metadata !42, metadata !41, i32 21, i32 0, i32 0} ; [ DW_TAG_lexical_block ] [/home/sanghu/TracerX/tracerx/runtime/Intrinsic/klee_overshift_check.c]
!152 = metadata !{i32 27, i32 0, metadata !153, null}
!153 = metadata !{i32 786443, metadata !42, metadata !151, i32 21, i32 0, i32 1} ; [ DW_TAG_lexical_block ] [/home/sanghu/TracerX/tracerx/runtime/Intrinsic/klee_overshift_check.c]
!154 = metadata !{i32 29, i32 0, metadata !41, null}
!155 = metadata !{i32 16, i32 0, metadata !156, null}
!156 = metadata !{i32 786443, metadata !54, metadata !53, i32 16, i32 0, i32 0} ; [ DW_TAG_lexical_block ] [/home/sanghu/TracerX/tracerx/runtime/Intrinsic/klee_range.c]
!157 = metadata !{i32 17, i32 0, metadata !156, null}
!158 = metadata !{i32 19, i32 0, metadata !159, null}
!159 = metadata !{i32 786443, metadata !54, metadata !53, i32 19, i32 0, i32 1} ; [ DW_TAG_lexical_block ] [/home/sanghu/TracerX/tracerx/runtime/Intrinsic/klee_range.c]
!160 = metadata !{i32 22, i32 0, metadata !161, null}
!161 = metadata !{i32 786443, metadata !54, metadata !159, i32 21, i32 0, i32 3} ; [ DW_TAG_lexical_block ] [/home/sanghu/TracerX/tracerx/runtime/Intrinsic/klee_range.c]
!162 = metadata !{i32 25, i32 0, metadata !163, null}
!163 = metadata !{i32 786443, metadata !54, metadata !161, i32 25, i32 0, i32 4} ; [ DW_TAG_lexical_block ] [/home/sanghu/TracerX/tracerx/runtime/Intrinsic/klee_range.c]
!164 = metadata !{i32 26, i32 0, metadata !165, null}
!165 = metadata !{i32 786443, metadata !54, metadata !163, i32 25, i32 0, i32 5} ; [ DW_TAG_lexical_block ] [/home/sanghu/TracerX/tracerx/runtime/Intrinsic/klee_range.c]
!166 = metadata !{i32 27, i32 0, metadata !165, null}
!167 = metadata !{i32 28, i32 0, metadata !168, null}
!168 = metadata !{i32 786443, metadata !54, metadata !163, i32 27, i32 0, i32 6} ; [ DW_TAG_lexical_block ] [/home/sanghu/TracerX/tracerx/runtime/Intrinsic/klee_range.c]
!169 = metadata !{i32 29, i32 0, metadata !168, null}
!170 = metadata !{i32 32, i32 0, metadata !161, null}
!171 = metadata !{i32 34, i32 0, metadata !53, null}
!172 = metadata !{i32 16, i32 0, metadata !66, null}
!173 = metadata !{i32 17, i32 0, metadata !66, null}
!174 = metadata !{metadata !174, metadata !175, metadata !176}
!175 = metadata !{metadata !"llvm.vectorizer.width", i32 1}
!176 = metadata !{metadata !"llvm.vectorizer.unroll", i32 1}
!177 = metadata !{metadata !148, metadata !148, i64 0}
!178 = metadata !{metadata !178, metadata !175, metadata !176}
!179 = metadata !{i32 18, i32 0, metadata !66, null}
!180 = metadata !{i32 16, i32 0, metadata !181, null}
!181 = metadata !{i32 786443, metadata !87, metadata !86, i32 16, i32 0, i32 0} ; [ DW_TAG_lexical_block ] [/home/sanghu/TracerX/tracerx/runtime/Intrinsic/memmove.c]
!182 = metadata !{i32 19, i32 0, metadata !183, null}
!183 = metadata !{i32 786443, metadata !87, metadata !86, i32 19, i32 0, i32 1} ; [ DW_TAG_lexical_block ] [/home/sanghu/TracerX/tracerx/runtime/Intrinsic/memmove.c]
!184 = metadata !{i32 20, i32 0, metadata !185, null}
!185 = metadata !{i32 786443, metadata !87, metadata !183, i32 19, i32 0, i32 2} ; [ DW_TAG_lexical_block ] [/home/sanghu/TracerX/tracerx/runtime/Intrinsic/memmove.c]
!186 = metadata !{metadata !186, metadata !175, metadata !176}
!187 = metadata !{metadata !187, metadata !175, metadata !176}
!188 = metadata !{i32 22, i32 0, metadata !189, null}
!189 = metadata !{i32 786443, metadata !87, metadata !183, i32 21, i32 0, i32 3} ; [ DW_TAG_lexical_block ] [/home/sanghu/TracerX/tracerx/runtime/Intrinsic/memmove.c]
!190 = metadata !{i32 24, i32 0, metadata !189, null}
!191 = metadata !{i32 23, i32 0, metadata !189, null}
!192 = metadata !{metadata !192, metadata !175, metadata !176}
!193 = metadata !{metadata !193, metadata !175, metadata !176}
!194 = metadata !{i32 28, i32 0, metadata !86, null}
!195 = metadata !{i32 15, i32 0, metadata !101, null}
!196 = metadata !{i32 16, i32 0, metadata !101, null}
!197 = metadata !{metadata !197, metadata !175, metadata !176}
!198 = metadata !{metadata !198, metadata !175, metadata !176}
!199 = metadata !{i32 17, i32 0, metadata !101, null}
!200 = metadata !{i32 13, i32 0, metadata !116, null}
!201 = metadata !{i32 14, i32 0, metadata !116, null}
!202 = metadata !{i32 15, i32 0, metadata !116, null}