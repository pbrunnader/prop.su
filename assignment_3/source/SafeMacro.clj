; This is the "assignment 3" for the course "Programming languages and Paradigms"
; at the Stockholm University
;
; @author Peter Brunnader 
; @author Katrin Freihofner
; @version 1.0


(import (java.io FileReader File))
 
(defmacro safe [param & form] 
  (if (vector? param)
    `(try
      (let [~(first param) ~(second param)] (def a# ~@form)
      (if (instance? java.io.Closeable ~(first param)) 
        (. ~(first param) close) 
        (println "nothing.") 
      ) a#)
    (catch Exception e# e#)
  )
    
  `(try
    ~param
  (catch Exception e# e#)
  )
  )
)


(println "; (def v (safe (/ 10 5)))")
(def v (safe (/ 10 5)))
(println v "\n")

(println "; (def v (safe (/ 10 0))) ")
(def v (safe (/ 10 0)))
(println v "\n")

(println "; (def v (safe [s (FileReader. (File. \"file.txt\"))] (. s read)))")
(def v (safe [s (FileReader. (File. "file.txt"))] (. s read)))
(println v "\n")

(println "; (def v (safe [s (FileReader. (File. \"missing-file\"))] (. s read)))")
(def v (safe [s (FileReader. (File. "missing-file"))] (. s read)))
(println v "\n")
