module Eigen
    # Abritary size vector
    class MatrixX
        def dup
            MatrixX.from_a(to_a, rows, cols)
        end

        def self.Zero(rows, cols)
            m = new(rows, cols)
            rows.times do |r|
                cols.times do |c|
                    m[r, c] = 0
                end
            end
            m
        end

        def self.from_a(*args)
            m = new
            m.from_a(*args)
            m
        end

        # Returns the array value in a vector 
        def to_a(column_major=true)
            a = []
            if column_major
                for j in 0..cols()-1
                    for i in 0..rows()-1
                        a << self[i,j]
                    end
                end
            else
                for i in 0..rows()-1
                    for j in 0..cols()-1
                        a << self[i,j]
                    end
                end
            end
            a
        end

        # sets matrix from a 1d array
        def from_a(array,nrows=-1,ncols=-1,column_major=true)
            if nrows == -1 && ncols == -1
                nrows = rows
                ncols = cols
            elsif nrows == -1
                nrows = array.size / ncols
            elsif ncols == -1
                ncols = array.size / nrows
            end
            resize(nrows,ncols)
            array.each_index do |i|
                v = array[i]
                if !v
                    v = 0.0
                end
                if column_major
                    self[i%nrows,i/nrows] = v
                else
                    self[i/ncols,i%ncols] = v
                end
            end
        end

        def pretty_print(pp)
            for i in 0..rows()-1
                for j in 0..cols()-1
                    pp.text " #{self[i,j]}"
                end
                pp.text "\n"
            end
        end

        def ==(m)
            m.kind_of?(self.class) &&
                __equal__(m)
        end

        def to_s # :nodoc:
            str = "MatrixX(\n"
            for i in 0..rows()-1
                for j in 0..cols()-1
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
            m = new(o['rows'],o['cols'])
            m.from_a(o['data'],o['rows'],o['cols'])
            m
        end
    end
end

