(defpackage :parser-combinators
    (:use :cl :iterate :alexandria)
  (:export #:result
           #:zero
           #:item
           #:sat
           #:choice
           #:choice1
           #:choices
           #:choices1
           #:mdo
           #:parse-string
           #:char?
           #:digit?
           #:lower?
           #:upper?
           #:letter?
           #:alphanum?
           #:word?
           #:string?
           #:many?
           #:many1?
           #:int?
           #:sepby1?
           #:bracket?
           #:sepby?
           #:chainl1?
           #:nat?
           #:chainr1?
           #:chainl?
           #:chainr?
           #:many*
           #:many1*
           #:sepby1*
           #:sepby*
           #:chainl1*
           #:nat*
           #:int*
           #:chainr1*
           #:chainl*
           #:chainr*
           #:memoize?
           #:curtail?
           #:force?
           #:times?
           #:atleast?
           #:atmost?
           #:between?
           #:current-result
           #:next-result
           #:gather-results
           #:tree-of
           #:suffix-of
           #:atmost*
           #:between*
           #:atleast*
           #:make-context
           #:delayed?
           #:<-
           #:make-parse-result
           #:cache?
           #:cached?
           #:def-cached-parser
           #:cached-arguments?
           #:def-cached-arg-parser
           #:sepby1-cons?
           #:find-after-collect?
           #:find-after-collect*
           #:breadth?
           #:expression?
           #:expression*
           #:context-interval
           #:context?
           #:end-context-p
           #:context-equal
           #:*default-context-cache*
           #:context-equal
           #:find-after?
           #:find-after*
           #:find*
           #:find?
           #:parse-string*
           #:find-before?
           #:find-before*
           #:end?
           #:context-of
           #:tags-of
           #:tag?
           #:cut-tag?
           #:position-of
           #:find-before-token*
           #:gather-before-token*
           #:seq-list?
           #:named-seq?))
