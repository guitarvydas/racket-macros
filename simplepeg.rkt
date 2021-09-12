#lang peg


(require "../racket-peg/s-exp.rkt");

clause <- 'f8' ':' s-exp;
