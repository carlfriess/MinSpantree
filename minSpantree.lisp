; Implementation of Kruskal's algorithm for the minimum spanning tree problem


; ALGORITHM FUNCTIONS

; makes lists of triplets
(defun make-triplet (items)
  (if (null items)
    '()
    (cons (list (- (car items) 1) (- (cadr items) 1) (caddr items))
      (make-triplet (cdddr items)))))

; list comparator
; compares the cost of the edges
(defun list< (a b)
  (cond ((null a) (not (null b)))
    ((null b) nil)
    ((> (caddr a) (caddr b)) nil)
    (t)))

(defun fill-array (i numVert)
  (cond ((< i numVert) (progn (setf (aref vertices i) i) (fill-array (+ i 1) numVert)))))

(defun findinarray (vert)
  (if (= vert (aref vertices vert))
  vert
  (findinarray (aref vertices vert))))

(defun connected? (StartVert EndVert)
  (= (findinarray StartVert) (findinarray EndVert)))

(defun union_array (vert1 vert2)
  (setf (aref vertices (findinarray vert1)) (findinarray vert2)))

(defun everyEdge (edges num costs)
  (cond   ((= num 0) (write costs))
    ((not (connected? (caar edges) (cadar edges)))
      (progn (union_array (caar edges) (cadar edges))
        (everyEdge (cdr edges) (- num 1) (+ costs (caddar edges)))))
  ((everyEdge (cdr edges) (- num 1) costs))))

; makes an array of vertices
; sorts edges by costs (edge format: beginning ending cost)
; calculates the cost of the minimum spanning tree
(defun minSpantree (numVert numEdge edges)
  (progn
    (setf vertices (make-array numVert))
    (setf edges (sort (make-triplet edges) #'list<))
    (fill-array 0 numVert)
    (everyEdge edges numEdge 0)
    ))


; INPUT FUNCTIONS

(defun split-input (string &key (delimiterp #'delimiterp))
    (loop :for beg = (position-if-not delimiterp string)
        :then (position-if-not delimiterp string :start (1+ end))
        :for end = (and beg (position-if delimiterp string :start beg))
        :when beg :collect (parse-integer (subseq string beg end))
        :while end))

(defun delimiterp (c) (char= c #\Space))

(defvar input-buffer (split-input (read-line)))

(defun get-next-int ()
    (if (= (list-length input-buffer) 0)
        (setq input-buffer (split-input (read-line))))
    (let ((output-val (first input-buffer)))
    (setq input-buffer (nthcdr 1 input-buffer))
    output-val))


; MAIN 

(setq testInstanz (get-next-int))

(loop
   (setq testInstanz (- testInstanz 1))
   (setq n (get-next-int))
   (setq m (get-next-int))
   (setq lim (* m 3))
   (setq i 0)
   (setq edgeList input-buffer)
   (minSpantree n m edgeList)
   (setq input-buffer '())
   (terpri)
   (when (< testInstanz 1) (return))
)