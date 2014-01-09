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
    (finally (println "First case.")) 
  )
    
  `(try
    ~param
  (catch Exception e# e#)
  (finally (println "Second case.")))
  )
)


(def v (safe (/ 10 5)))
(println v)

(def v (safe (/ 10 0)))
(println v)

(def v (safe [s (FileReader. (File. "file.txt"))] (. s read)))
(println v)

(def v (safe [s (FileReader. (File. "missing-file"))] (. s read)))
(println v)
