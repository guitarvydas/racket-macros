#lang racket
(define (choose x)
  (case x
    ((0) "chose zero")
    ((1) "chose one")
    ((2) "chose two")
    ((3) "chose three")
    (else "fail")))
	