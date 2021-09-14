#lang peg


(require "../racket-peg/s-exp.rkt");

clause <- 'right' _ ':' _  -> e;

    right: (world-move w 1 0)