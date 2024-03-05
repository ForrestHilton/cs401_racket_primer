(define (f graph) 
  (foldl (lambda (x graph+) 
           (foldl (lambda (y graph+)
                    (foldl () 
                           graph+
                           (set->list (hash-ref graph y set))))
                  graph+
                  ))))
