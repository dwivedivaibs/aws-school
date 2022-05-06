

arr = ["B$u$i$ld", "$t$$h$e", "N$e$x$t", "E$$ra", "$$o$f$", "S$$of$t$wa$r$e", "De$$ve$l$op$me$n$t"] 
new_arr = []
arr.each do |a|
  new_str = a.gsub!(/[^0-9A-Za-z]/, '')
  new_arr << new_str 
end 

puts(new_str)
