x = 'this_11x121.is a test'
p x[/_[0-9]+x[0-9]+./].gsub(/[_.]/, "")

arr = []
for i in 0..4
	begin
		input = rand(42)
	end while arr.include? input
	arr << input
end	

arr.each do |item|
	p item
end