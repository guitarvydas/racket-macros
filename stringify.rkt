#lang racket
(require (for-syntax racket/syntax))

(define-syntax (stringify-working stx)
  (syntax-case stx ()
    [(stringify idstr)
     (with-syntax ([id (format "~a" (syntax->datum #'idstr))])
       #'id)]))

(define-syntax (stringify stx)
  (syntax-case stx ()
    [(_ idstr)
     #'(format "~a" (syntax->datum #'idstr))]))

(println (stringify (a b c)))
(println (stringify d))