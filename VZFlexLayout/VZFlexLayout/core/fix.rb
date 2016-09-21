


handle = File.new("./results.txt","w")


found_ = false;
lines_ = 0;
f = File.open("./VZFunctor.h")

if (f) 
	lines = f.each_line{ |line| 

			if line[0]  == "/"
				lines_ += 1
			else
				found_ = true
				if(found_)
					puts line
				end
			end
	}


end


handle.close