#lang racket
(require (for-syntax racket/syntax))

(define-syntax (stringify stx)
  (syntax-case stx ()
    [(_ idstr)
     #'(format "~a" (syntax->datum #'idstr))]))


(println (stringify (a b c)))
(println (stringify d))
