(defmacro safe [& form] 
  `(try
    ~@form
    (catch Exception e# e#)
    (finally (println "Done."))))



(def v (safe (/ 1 0)))
(println v)

(def v (safe (/ 10 2)))
(println v)

(def v (safe [s (FileReader. (File. "file.txt"))] (. s read)))
(println v)

