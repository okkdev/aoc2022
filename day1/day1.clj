(:require '[clojure.string :as str])
(as-> "input.txt" $
  (slurp $)
  (str/split $ #"\n\n")
  (map
   #(->> %
         str/split-lines
         (map read-string)
         (reduce +)) $)
  (sort > $)
  (let [x $]
    (println "Part 1:" (first x))
    (println "Part 2:" (reduce + (take 3 x)))))
