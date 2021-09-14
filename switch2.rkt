#lang racket
;; see https://stackoverflow.com/questions/32793972/racket-switch-statement-macro

(require (for-syntax syntax/parse))

(define-syntax (switch stx)
  (syntax-parse stx
    [(switch)
     #'(raise-syntax-error 'switch "value expression and at least one clause expected" stx)]
    [(switch expr clause ...)
     #'(let ([v expr])
         (switch-value v clause ...))]))

(define-syntax (switch-value stx)
  (syntax-parse stx
    #:literals (else)
    [(switch-value v)
     #'(raise-syntax-error 'switch "at least one clause is expected" _switch-value)]
    [(switch-value v [else expr])
     #'expr]
    [(switch-value v [expr1 expr2] clause ...)
     #'(if (equal? v expr1)
           expr2
           (switch-value v clause ...))]))


(define x 4)

(switch x
  [3 "x is 3"]
  [4 "x is 4"]
  [5 "x is 5"]
  [else (displayln "none of the above")])
