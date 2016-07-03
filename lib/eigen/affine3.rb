module Eigen
    class Affine3
        def self.Identity
            Affine3.new
        end

        def self.from_position_orientation( v, q )
            i = Affine3.Identity
            i.prerotate( q )
            i.pretranslate( v )
            i
        end

        def dup
            raise NotImplementedError
        end

        def ==(q)
            q.kind_of?(self.class) &&
                __equal__(q)
        end

        def *(obj)
            if obj.kind_of?(Affine3)
                concatenate(obj)
            else
                transform(obj)
            end
        end

        def to_s
            matrix.to_s
        end
    end
end
