# frozen_string_literal: true

module Eigen
    # Matrix 4x4
    class Matrix4
        # @!method [](row, col)
        #   @param [Integer] row the row index
        #   @param [Integer] col the column index

        # Create a new matrix from the content of an array
        #
        # @param [Array<Numeric>] the values. It must be of size at most 16.
        #    If smaller than 16, the rest is filled with zeroes
        #
        # @return [Matrix4]
        def self.from_a(*args)
            m = new
            m.from_a(*args)
            m
        end

        # Returns the values flattened in a ruby array
        #
        # @param [Boolean] column_major if true, the values of a column will be
        #   adjacent in the resulting array, if not the values of a row will
        # @return [Array<Numeric>]
        #
        # @example column-major ordering
        #   matrix.to_s => Matrix4(1 2 3 4
        #                          5 6 7 8
        #                          9 10 11 12
        #                          13 14 15 16)
        #   matrix.to_a(true) => [1 5 9 13 2 6 10 14 ...]
        def to_a(column_major = true)
            a = []
            if column_major
                (0..3).each do |j|
                    (0..3).each do |i|
                        a << self[i, j]
                    end
                end
            else
                (0..3).each do |i|
                    (0..3).each do |j|
                        a << self[i, j]
                    end
                end
            end
            a
        end

        # sets matrix from a 1d array
        def from_a(array, column_major = true)
            raise ArgumentError, "array should be of size maximum 16" if array.size > 16

            16.times do |i|
                v = array[i] || 0
                if column_major
                    self[i % 4, i / 4] = v
                else
                    self[i / 4, i % 4] = v
                end
            end
        end

        def ==(other)
            other.kind_of?(self.class) &&
                __equal__(other)
        end

        def to_s(line_format = "%g %g %g %g") # :nodoc:
            lines = to_a.each_slice(3).to_s
            <<~EOSTRING
                Matrix4(#{line_format % lines[0]}"
                        #{line_format % lines[1]}"
                        #{line_format % lines[2]}"
                        #{line_format % lines[3]})"
            EOSTRING
        end

        def _dump(_level)
            to_a.pack("E*")
        end

        def self._load(elements) # :nodoc:
            m = new
            if elements.size == 8 * 16
                m.from_a(elements.unpack("E*"))
            else
                m.from_a(Marshal.load(elements)["data"])
            end
            m
        end
    end
end
