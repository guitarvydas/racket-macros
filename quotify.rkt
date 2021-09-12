#lang racket
(require (for-syntax racket/syntax))

(define-syntax (quotify stx)
  (syntax-case stx ()
    [(_ idstr)
     #'(syntax->datum #'idstr)]))

(println (quotify (a b c)))
(println (quotify d))