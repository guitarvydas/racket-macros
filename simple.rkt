#lang racket
(define (choose x)
  (case x
    ((0) "chose zero")
    ((1) "chose one")
    ((2) "chose two")
    ((3) "chose three")
    (else "fail")))


(choose 0)
(choose 1)
(choose 2)
(choose 3)
(choose 4)


(define-syntax m-or
  (syntax-rules ()
    [(m-or) #f]
    [(m-or e1 e2 ...)
     (let ([temp e1])
       (if temp
           temp
           (m-or e2 ...)))]))

(m-or #t)
(m-or #f #t)
(m-or #f 1)
(define x 2)
(m-or #f x)
(m-or (= x 1) x)
(m-or (= x 2) x)

(define-syntax mchoice
  (syntax-rules ()
    [(mchoice x) "mchoose fail"]
    [(mchoice x (hh ht) r ...)
     (if (eq? x hh)
         ht
         (mchoice x r ...))]))

(mchoice 1
    (0 "mchose zero"))
(mchoice 0
    (0 "mchoose zero"))
(mchoice 1
    (0 "mchoose zero")
    (1 "mchoose uno"))

(define-syntax mchoice2
  (syntax-rules ()
    [(mchoice2 x) "mchoose2 fail"]
    [(mchoice2 x r ...)
     (case x r ...)]))

(mchoice2 1)

(mchoice2 1
    ((0) "mchose2 zero"))
(mchoice2 0
    ((0) "mchoose2 zero"))
(mchoice2 1
    ((0) "mchoose2 zero")
    ((1) "mchoose2 uno"))

(define-syntax-rule (stringify x)
  (format "~v" x))

(define-syntax mchoice3
  (syntax-rules ()
    [(mchoice3 x) "mchoose3 fail"]
    [(mchoice3 x r ...)
     (case (stringify x) r ...)]))


(mchoice3 1
    ((0) "mchose3 zero"))
(mchoice3 0
    ((0) "mchoose3 zero"))
(mchoice3 1
    ((0) "mchoose3 zero")
    (("f8") "mchoose3 function  key 8")
    ((1) "mchoose3 uno"))
(mchoice3 1
    ((0) "mchose3 zero")
    (else "mchoice 3 else"))
(mchoice3 'f8
    ((0) "mchose3 zero")
    (("f8") "function key 8")
    (else "mchoice 3 else"))

#|
(define-syntax-rule (stringify2 x)
  (syntax-rules (f8)
   [ (stringify x) x ]
   [ (stringify f8) "abc" ]))

(stringify 77)
(stringify2 f8)
|#

(define-macro (report EXPR)
  #'(begin
      ; EXPR used as literal data, and quoted as a datum
      (displayln (format "input was ~a" 'EXPR))
      EXPR)) ; EXPR used for its result
(report (* 1 2 3 4))