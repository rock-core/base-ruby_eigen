module Eigen
    # Matrix 4x4
    class Matrix4
        def self.from_a(*args)
            m = new
            m.from_a(*args)
            m
        end

        # Returns the array value in a vector 
        def to_a(column_major=true)
            a = []
            if column_major
                for j in 0..3
                    for i in 0..3
                        a << self[i,j]
                    end
                end
            else
                for i in 0..3
                    for j in 0..3
                        a << self[i,j]
                    end
                end
            end
            a
        end

        # sets matrix from a 1d array
        def from_a(array, column_major=true)
            array.each_index do |i|
                v = array[i]
                if !v
                    v = 0.0
                end
                if column_major
                    self[i%4,i/4] = v
                else
                    self[i/4,i%4] = v
                end
            end
        end

        def ==(m)
            m.kind_of?(self.class) &&
                __equal__(m)
        end

        def to_s # :nodoc:
            str = "Matrix4(\n"
            for i in 0..3
                for j in 0..3
                    str += "#{self[i,j]} "
                end
                str[-1] = "\n"
            end
            str += ")"
            str
        end

        def _dump(level) # :nodoc:
            Marshal.dump({'rows' => rows, 'cols' => cols, 'data' => to_a})
        end

        def self._load(coordinates) # :nodoc:
            o = Marshal.load(coordinates)
            m = new()
            m.from_a(o['data'])
            m
        end
    end
end

