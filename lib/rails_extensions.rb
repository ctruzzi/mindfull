class Array
	def every(n)
		select { |x| index(x) % n == 0 }
	end

	def every_third(n)
		select { |x| index(x) % 3 == n }
	end

	def every_other
		every 2
	end
end