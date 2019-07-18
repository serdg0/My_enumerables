arr = [5,6,4,1,3,2,7,9,8]
strings = ["hi", "hello", "hey"]
hash = { "cinco": 5, "three": 3, "four": 4}

module Enumerable

    def my_each
        i = 0
        while i<self.size
            yield(self[i])
            i+=1
        end
        self
    end

    def my_each_index
        i=0
        while i < self.size
            yield(self[i],i)
            i+=1
        end
    end

    def my_select
        arr_selection= []
        self.my_each{|x| arr_selection << x if yield(x)}
        arr_selection
    end

    def my_all?
        self.my_each do |x|
        return true unless block_given?
        return false unless yield(x)
        end
        true
    end
    
    def my_any?
        statement = false
        self.my_each do |x|
            (statement = true) if yield(x)
        end
        statement
    end

    def my_none?
        statement = true
        self.my_each{ |x| statement = false if yield(x) }
        statement
    end

    def my_count
        count = 0
        self.my_each do |x|
            block_given? ? (count+=1 if yield(x)) : count+=1
        end
        count
    end

    def my_map
        array = []
        self.my_each do |x|
            yield(x) ? (array << true) : (array << false)
        end
        array
    end
        
    def my_inject (memo = self[0]) # If no initial value passed, it's 1st element
        object = memo
        self.my_each do |x|
            object = yield(memo,x)
            memo = object 
        end
        object
    end

end

my_proc = Proc.new {|x| x%2 == 0}

print arr.my_any?(&my_proc)
puts "  -  My solution"

print arr.any?(&my_proc)
puts "  -  Original"