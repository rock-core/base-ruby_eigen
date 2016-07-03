module Eigen
    # Abritary size vector
    class VectorX
        def dup
            VectorX.from_a(to_a)
        end

        # Returns the array value in a vector
        def to_a()
            a = []
            for i in 0..size()-1
                    a << self[i]
            end
            a
        end

        def self.from_a(array)
            v = VectorX.new
            v.from_a(array)
            v
        end

        def from_a(array)
            resize(array.size())
            for i in 0..array.size()-1
                self[i] = array[i]
            end
        end

        def ==(v)
            v.kind_of?(self.class) &&
                __equal__(v)
        end

        def to_s # :nodoc:
            str = "VectorX("
            for i in 0..size()-1
                str += "#{self[i]} "
            end
            str[-1] = ")"
            str
        end

        def _dump(level) # :nodoc:
            Marshal.dump(to_a)
        end

        def self._load(coordinates) # :nodoc:
            m = new()
            m.from_a(Marshal.load(coordinates))
            m
        end
    end
end
