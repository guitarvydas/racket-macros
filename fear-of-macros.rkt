#lang racket
; fear of macros https://www.greghendershott.com/fear-of-macros/Transform_.html
(require (for-syntax racket/syntax))

(define-syntax foo
    (lambda (stx)
      (syntax "I am foo")))
(foo)

(foo 'pal)

(define-syntax (also-foo stx)
  (syntax "I am also foo"))

(also-foo x y z)

(define-syntax (foo3 stx)
  #'"Yet more foo")

(foo3 x y z)

(define-syntax (show-me stx)
    (println stx)
    #'(void))
(show-me '(+ 1 2))

(define stx #'(if x (list "true") #f))

(define-syntax (hyphen-define/wrong1.1 stx)
    (syntax-case stx ()
      [(_ a b (args ...) body0 body ...)
       (let ([name (string->symbol (format "~a-~a" #'a #'b))])
         #'(define (name args ...)
             body0 body ...))]))

(hyphen-define/wrong1.1 foo bar () #t)

(define-syntax (stringify-1 stx)
  (println (format "stx: ~v" stx))
  (println (format "identifer?: ~v" (identifier? stx)))
  (println (format "source: ~v" (syntax-source stx)))
  (println (format "datum: ~v" (syntax->datum stx)))
  (println (format "cadr datum: ~v" (cadr (syntax->datum stx))))
  (println (format "syntax? cadr datum: ~v" (syntax? (cadr (syntax->datum stx)))))
  (println (identifier? (cadr (syntax->datum stx))))
  (println (format "~v" (cadr (syntax->datum stx))))
  #'(void))

(stringify-1 1)
(stringify-1 f8)

(define-syntax (hyphen-define/ok3 stx)
    (syntax-case stx ()
      [(_ a b (args ...) body0 body ...)
;       (with-syntax ([name (format-id #'a "~a-~a" #'a #'b)])
       (with-syntax ([name (format "formated: ~a-~a" (syntax->datum #'a) (syntax->datum #'b))])
#'(println (format "~a" name)))]))
;         #'(define (name args ...)
;             body0 body ...))]))
(hyphen-define/ok3 bar baz () #t)
;(bar-baz)

(define-syntax (stringify stx)
  (syntax-case stx ()
    [(stringify idstr)
     (with-syntax ([id (format "~a" (syntax->datum #'idstr))])
       #'id)]))

(println (stringify xxx))
(stringify (a b c))