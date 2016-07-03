module Eigen
    # 3-dimensional vector
    class Vector3
        # Returns a vector with all values set to Base.unset
        def self.Unset
            return Vector3.new(Base.unset, Base.unset, Base.unset)
        end

        def dup
            Vector3.new(x, y, z)
        end

        # Returns the [x, y, z] tuple
        def to_a; [x, y, z] end

        # Returns the (1, 0, 0) unit vector
        def self.UnitX()
            return Vector3.new(1, 0, 0)
        end

        # Returns the (0, 1, 0) unit vector
        def self.UnitY()
            return Vector3.new(0, 1, 0)
        end

        # Returns the (0, 0, 1) unit vector
        def self.UnitZ()
            return Vector3.new(0, 0, 1)
        end

        # returns the (0, 0, 0) vector
        def self.Zero()
            return Vector3.new(0, 0, 0)
        end

        # Returns the angle formed by +self+ and +v+, oriented from +self+ to
        # +v+
        def angle_to(v)
            ret = Math.atan2(v.y, v.x) - Math.atan2(y, x)
            if ret > Math::PI
                ret -= 2*Math::PI
            end
            if ret < -Math::PI
                ret += 2*Math::PI
            end
            ret
        end

        # Tests for equality
        #
        # Since Vector3 stores the coordinates as floating-point values, this is
        # a bad test. Use
        #
        #   q.approx?(other_q, tolerance)
        #
        # instead
        def ==(v)
            v.kind_of?(self.class) &&
                __equal__(v)
        end

        # Support for Marshal
        def _dump(level) # :nodoc:
            Marshal.dump(to_a)
        end

        # Support for Marshal
        def self._load(coordinates) # :nodoc:
            new(*Marshal.load(coordinates))
        end

        def to_s # :nodoc:
            "Vector3(#{x}, #{y}, #{z})"
        end

        def data
            [x, y, z]
        end

        def data=(value)
            self.x,self.y,self.z = value
        end

        ##
        # :method: ==

        ##
        # :method: []
        #
        # Returns the i-th coordinate

        ##
        # :method: []=
        #
        # Sets the i-th coordinate

        ##
        # :method: x

        ##
        # :method: y

        ##
        # :method: z

        ##
        # :method: x=

        ##
        # :method: y=

        ##
        # :method: z=

        ##
        # :method: +

        ##
        # :method: -

        ##
        # :method: -@

        ##
        # :method: *
        # :call-seq:
        #   a * scalar => b
        #
        # Returns +a+ scaled with the given scalar

        ##
        # :method: cross
        # :call-seq:
        #   cross(b) => c
        #
        # Returns the cross product of +self+ with +b+

        ##
        # :method: norm
        #
        # Returns the norm of +self+

        ##
        # :method: normalize!
        # 
        # Makes this vector unit-length

        ##
        # :method: normalize
        # 
        # Returns a vector that has the same direction than +self+ but unit
        # length

        ##
        # Computes the signed angle between two vectors, using the provided
        # vector as "positive" rotation direction
        #
        # The returned angle A is so that the rotation defined by A and axis
        # will transform +self+ into +v+
        def signed_angle_to(v, axis)
            dot_p   = self.dot(v)
            dir = self.cross(v).dot(axis)

            unsigned = Math.acos(dot_p / norm / v.norm)
            if dir > 0
                return unsigned
            else
                return -unsigned
            end
        end

        # @return [Qt::Quaternion] the Qt vector that is identical to this
        # one
        def to_qt
            Qt::Vector3D.new(x, y, z)
        end
    end
end
