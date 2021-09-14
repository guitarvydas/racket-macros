#lang racket
;; see https://stackoverflow.com/questions/32793972/racket-switch-statement-macro

(require (for-syntax syntax/parse))

(define-syntax (switch stx)
  (define (transform-clause cl)
    (syntax-case cl (default)
      ((default expr) #'(else expr))
      ((val ... expr) #'((val ...) expr))))

  (define (transform-clauses cls)
    (syntax-case cls ()
      ((cl)
       (with-syntax ((case-clause (transform-clause #'cl)))
         #'(case-clause)))
      ((cl rest ...)
       (with-syntax ((case-clause (transform-clause #'cl))
                     ((case-rest ...) (transform-clauses #'(rest ...))))
         #'(case-clause case-rest ...)))))

  (syntax-case stx ()
    ((_ x clause ...)
     (with-syntax (((case-clause ...) (transform-clauses #'(clause ...))))
       #'(case x case-clause ...)))))

(define x 5)

(define (test1)
  ;; uses builtin 'case'
  (case x
    ((3) (displayln "x is 3"))
    ((4) (displayln "x is 4"))
    ((5) (displayln "x is 5"))
    (else (displayln "none of the above"))))

(define (test2)
  ;; uses macro 'switch'
  (switch x
          [3 (displayln "sw x is 3")]
          [4 (displayln "sw x is 4")]
          [5 (displayln "sw x is 5")]
          [default (displayln "sw none of the above")]))

(test1)
(test2)
