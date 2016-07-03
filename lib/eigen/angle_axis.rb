module Eigen
    # Representation and manipulation of an angle axis
    class AngleAxis
        def dup
            AngleAxis.new(angle, axis)
        end

        # Returns the angle axis as [angle, x, y, z]
        def to_a; [angle, axis.to_a] end

        def from_a (array)
            aa = AngleAxis.new(array[0], Eigen::Vector3.new(array[1][0], array[1][1], array[1][2]))
            aa
        end

        # Returns the identity unit quaternion (identity rotation)
        def self.Identity
            AngleAxis.new(0, Eigen::Vector3.new(1, 0, 0))
        end

        # Creates a angle axis from a quaternion
        def self.from_quaternion(*args)
            aa = new(0, Eigen::Vector3.new(1, 0, 0))
            aa.from_quaternion(*args)
            aa
        end

        # Creates a quaternion from a set of euler angles.
        #
        # See Quaternion#from_euler for details
        def self.from_euler(*args)
            aa = new(0, Eigen::Vector3.new(1, 0, 0))
            aa.from_euler(*args)
            aa
        end

        # Creates a quaternion from a rotation matrix
        def self.from_matrix(m)
            aa = new(0, Eigen::Vector3.new(1, 0, 0))
            aa.from_matrix(m)
            aa
        end

        # Returns a scaled axis representation that is equivalent to this
        # quaternion
        #
        # @param [Float] eps see {#to_angle_axis}
        # @return [Vector3]
        def to_scaled_axis(eps = 1e-12)
            return axis * angle
        end

        # Concatenates with another angle axis or transforms a vector
        def *(obj)
            if obj.kind_of?(AngleAxis)
                concatenate(obj)
            else
                transform(obj)
            end
        end

        def _dump(level) # :nodoc:
            Marshal.dump(to_a)
        end

        def self._load(coordinates) # :nodoc:
            aa = new(0, Eigen::Vector3.new(1, 0, 0))
            aa.from_a(Marshal.load(coordinates))
            aa
        end

        def to_s # :nodoc:
            "AngleAxis( angle #{angle}, axis(#{axis.x}, #{axis.y}, #{axis.z}))"
        end

        # Tests for equality
        #
        # Since Quaternion stores the coordinates as floating-point values, this is
        # a bad test. Use
        #
        #   (v - other_v).norm < threshold
        #
        # instead
        def ==(q)
            q.kind_of?(self.class) &&
                __equal__(q)
        end
    end
end

