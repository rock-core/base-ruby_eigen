# frozen_string_literal: true

module Eigen
    # Representatiion of a 3D isometry
    class Isometry3
        def self.Identity
            Isometry3.new
        end

        def self.from_position_orientation(v, q)
            i = Isometry3.Identity
            i.prerotate(q)
            i.pretranslate(v)
            i
        end

        def dup
            raise NotImplementedError
        end

        def ==(other)
            other.kind_of?(self.class) &&
                __equal__(other)
        end

        def *(other)
            if other.kind_of?(Isometry3)
                concatenate(other)
            else
                transform(other)
            end
        end

        def to_s
            matrix.to_s
        end
    end
end
