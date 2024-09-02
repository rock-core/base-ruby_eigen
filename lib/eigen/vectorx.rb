# frozen_string_literal: true

module Eigen
    # Abritary size vector
    class VectorX
        def dup
            VectorX.from_a(to_a)
        end

        # Returns the array value in a vector
        def to_a
            a = []
            (0..size - 1).each do |i|
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
            resize(array.size)
            (0..array.size - 1).each do |i|
                self[i] = array[i]
            end
        end

        def ==(other)
            other.kind_of?(self.class) &&
                __equal__(other)
        end

        def to_s # :nodoc:
            str = "VectorX("
            (0..size - 1).each do |i|
                str += "#{self[i]} "
            end
            str[-1] = ")"
            str
        end

        def _dump(_level) # :nodoc:
            Marshal.dump(to_a)
        end

        def self._load(coordinates) # :nodoc:
            m = new
            m.from_a(Marshal.load(coordinates))
            m
        end
    end
end
