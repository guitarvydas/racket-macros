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

