(let* ([n 1]) (add1 n)) ->
(let ([n 1]) (add1 n)) ->
((lambda (n) (add1 n)) 
 1) ->
((lambda (n) (
              (lambda (f) (lambda (x) (f ((n f) x))))
              n)) 
 (lambda (f) (lambda (x) (f x))))

;; write a recursive function using let* not letrec (hint: use U-comb)

(let* ([U (lambda (u) (u u))]
       [mkfib (lambda (mkfib) (lambda (n) (if (< n 2) 1 (let ([fib (mkfib mkfib)]) 
                                (+ (fib (- n 1)) (fib (- n 2)))
                                ))) )]
       [fib (lambda (n) ((mkfib mkfib) n))])
  (fib 5)
  )

