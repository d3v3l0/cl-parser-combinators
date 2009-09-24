(in-package :parser-combinators)

(defclass context ()
  ((sequence-id :accessor sequence-id-of :initarg :sequence-id :initform (gensym))
   (cache    :accessor cache-of    :initarg :cache :initform (make-hash-table))
   (storage  :accessor storage-of  :initarg :storage :initform nil)
   (position :accessor position-of :initarg :position :initform 0)
   (length   :accessor length-of   :initarg :length :initform 0)))

(defgeneric context-peek (context))
(defgeneric context-next (context))
(defgeneric make-context (sequence))
(defgeneric context-interval (context1 context2 &optional result-type)
  (:method ((context1 context) (context2 context) &optional (result-type 'string))
    (assert (eql (sequence-id-of context1)
                 (sequence-id-of context2)))
    (assert (<= (position-of context1)
                (position-of context2)))
    (if (= (position-of context1) (position-of context2))
        (coerce nil result-type)
        (coerce (iter (for c initially context1 then (context-next c))
                      (until (eq c context2))
                      (collect (context-peek c)))
                result-type))))

(defclass end-context (context)
  ())

(defgeneric end-context-p (context)
  (:method ((context t))
    nil)
  (:method ((context end-context))
    t))

(defmethod context-next ((context end-context))
  (error "Can't go past the end"))

(defmethod context-peek ((context end-context))
  (warn "Trying to peek past the end.")
  nil)

(defclass list-context (context)
  ())

(defmethod make-context ((list list))
  (if (null list)
      (make-instance 'end-context)
      (make-instance 'list-context :storage list :length (length list))))

(defmethod context-next ((context list-context))
  (with-accessors ((cache cache-of) (storage storage-of) (position position-of)
                   (length length-of) (sequence-id sequence-id-of))
      context
    (let ((new-position (1+ position)))
      (or (gethash new-position cache)
          (setf (gethash new-position cache)
                (if (= new-position length)
                    (make-instance 'end-context
                                   :sequence-id sequence-id
                                   :position new-position
                                   :length length
                                   :cache cache
                                   :storage nil)
                    (make-instance 'list-context
                                   :sequence-id sequence-id
                                   :storage (cdr storage)
                                   :position new-position
                                   :length length
                                   :cache cache)))))))

(defmethod context-peek ((context list-context))
  (car (storage-of context)))

(defclass vector-context (context)
  ())

(defmethod make-context ((vector vector))
  (if (zerop (length vector))
      (make-instance 'end-context)
      (make-instance 'vector-context :storage vector :length (length vector) :sequence-id vector)))

(defmethod context-next ((context vector-context))
  (with-accessors ((cache cache-of) (storage storage-of) (position position-of) (length length-of))
      context
    (let ((new-position (1+ position)))
      (or (gethash new-position cache)
          (setf (gethash new-position cache)
                (if (= new-position length)
                    (make-instance 'end-context
                                   :sequence-id storage
                                   :position new-position
                                   :length length
                                   :cache cache
                                   :storage nil)
                    (make-instance 'vector-context
                                   :sequence-id storage
                                   :storage storage
                                   :position new-position
                                   :length length
                                   :cache cache)))))))

(defmethod context-peek ((context vector-context))
  (aref (storage-of context) (position-of context)))
