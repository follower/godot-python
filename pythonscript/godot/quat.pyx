# cython: language_level=3

cimport cython

from godot._hazmat.gdapi cimport (
    pythonscript_gdapi as gdapi,
    pythonscript_gdapi11 as gdapi11,
    pythonscript_gdapi12 as gdapi12
)
from godot._hazmat.gdnative_api_struct cimport godot_quat, godot_real, godot_string
from godot._hazmat.conversion cimport godot_string_to_pyobj
from godot.vector3 cimport Vector3
from godot.basis cimport Basis


@cython.final
cdef class Quat:

    def __init__(self, x=0, y=0, z=0, w=0):
        gdapi.godot_quat_new(&self._gd_data, x, y, z, w)

    @staticmethod
    cdef inline Quat new(godot_real x, godot_real y, godot_real z, godot_real w):
        # Call to __new__ bypasses __init__ constructor
        cdef Quat ret = Quat.__new__(Quat)
        gdapi.godot_quat_new(&ret._gd_data, x, y, z, w)
        return ret

    @staticmethod
    def from_axis_angle(Vector3 axis not None, godot_real angle):
        return Quat.new_with_axis_angle(axis, angle)

    @staticmethod
    cdef inline Quat new_with_axis_angle(Vector3 axis, godot_real angle):
        # Call to __new__ bypasses __init__ constructor
        cdef Quat ret = Quat.__new__(Quat)
        gdapi.godot_quat_new_with_axis_angle(&ret._gd_data, &axis._gd_data, angle)
        return ret

    @staticmethod
    def from_basis(Basis basis not None):
        return Quat.new_with_basis(basis)

    @staticmethod
    cdef inline Quat new_with_basis(Basis basis):
        # Call to __new__ bypasses __init__ constructor
        cdef Quat ret = Quat.__new__(Quat)
        gdapi11.godot_quat_new_with_basis(&ret._gd_data, &basis._gd_data)
        return ret

    @staticmethod
    def from_euler(Vector3 euler not None):
        return Quat.new_with_euler(euler)

    @staticmethod
    cdef inline Quat new_with_euler(Vector3 euler):
        # Call to __new__ bypasses __init__ constructor
        cdef Quat ret = Quat.__new__(Quat)
        gdapi11.godot_quat_new_with_euler(&ret._gd_data, &euler._gd_data)
        return ret

    @staticmethod
    cdef inline Quat from_ptr(const godot_quat *_ptr):
        # Call to __new__ bypasses __init__ constructor
        cdef Quat ret = Quat.__new__(Quat)
        ret._gd_data = _ptr[0]
        return ret

    def __repr__(self):
        return f"<Quat(x={self.x}, y={self.y}, z={self.z}, w={self.w})>"

    # Operators

    cdef inline Quat operator_add(self, Quat b):
        cdef Quat ret  = Quat.__new__(Quat)
        ret._gd_data = gdapi.godot_quat_operator_add(&self._gd_data, &b._gd_data)
        return ret

    cdef inline Quat operator_subtract(self, Quat b):
        cdef Quat ret  = Quat.__new__(Quat)
        ret._gd_data = gdapi.godot_quat_operator_subtract(&self._gd_data, &b._gd_data)
        return ret

    cdef inline Quat operator_multiply(self, godot_real b):
        cdef Quat ret  = Quat.__new__(Quat)
        ret._gd_data = gdapi.godot_quat_operator_multiply(&self._gd_data, b)
        return ret

    cdef inline Quat operator_divide(self, godot_real b):
        cdef Quat ret  = Quat.__new__(Quat)
        ret._gd_data = gdapi.godot_quat_operator_divide(&self._gd_data, b)
        return ret

    cdef inline bint operator_equal(self, Quat b):
        cdef Quat ret  = Quat.__new__(Quat)
        return gdapi.godot_quat_operator_equal(&self._gd_data, &b._gd_data)

    cdef inline Quat operator_neg(self):
        cdef Quat ret  = Quat.__new__(Quat)
        ret._gd_data = gdapi.godot_quat_operator_neg(&self._gd_data)
        return ret

    def __eq__(self, other):
        try:
            return Quat.operator_equal(self, other)
        except TypeError:
            return False

    def __ne__(self, other):
        try:
            return not Quat.operator_equal(self, other)
        except TypeError:
            return True

    def __neg__(self):
        return Quat.operator_neg(self)

    def __pos__(self):
        return self

    def __add__(self, Quat val not None):
        return Quat.operator_add(self, val)

    def __sub__(self, Quat val not None):
        return Quat.operator_subtract(self, val)

    def __mul__(self, godot_real val):
        return Quat.operator_multiply(self, val)

    def __truediv__(self, godot_real val):
        if val == 0:
            raise ZeroDivisionError
        return Quat.operator_divide(self, val)

    # Property

    cdef inline godot_real get_x(self):
        return gdapi.godot_quat_get_x(&self._gd_data)

    cdef inline void set_x(self, godot_real val):
        gdapi.godot_quat_set_x(&self._gd_data, val)

    @property
    def x(self):
        return self.get_x()

    @x.setter
    def x(self, val):
        self.set_x(val)

    cdef inline godot_real get_y(self):
        return gdapi.godot_quat_get_y(&self._gd_data)

    cdef inline void set_y(self, godot_real val):
        gdapi.godot_quat_set_y(&self._gd_data, val)

    @property
    def y(self):
        return self.get_y()

    @y.setter
    def y(self, val):
        self.set_y(val)

    cdef inline godot_real get_z(self):
        return gdapi.godot_quat_get_z(&self._gd_data)

    cdef inline void set_z(self, godot_real val):
        gdapi.godot_quat_set_z(&self._gd_data, val)

    @property
    def z(self):
        return self.get_z()

    @z.setter
    def z(self, val):
        self.set_z(val)

    cdef inline godot_real get_w(self):
        return gdapi.godot_quat_get_w(&self._gd_data)

    cdef inline void set_w(self, godot_real val):
        gdapi.godot_quat_set_w(&self._gd_data, val)

    @property
    def w(self):
        return self.get_w()

    @w.setter
    def w(self, val):
        self.set_w(val)

    # Methods

    cdef inline str as_string(self):
        cdef godot_string var_ret = gdapi.godot_quat_as_string(&self._gd_data)
        cdef str ret = godot_string_to_pyobj(&var_ret)
        gdapi.godot_string_destroy(&var_ret)
        return ret

    cpdef inline godot_real length(self):
        return gdapi.godot_quat_length(&self._gd_data)

    cpdef inline godot_real length_squared(self):
        return gdapi.godot_quat_length_squared(&self._gd_data)

    cpdef inline Quat normalized(self):
        cdef Quat ret = Quat.__new__(Quat)
        ret._gd_data = gdapi.godot_quat_normalized(&self._gd_data)
        return ret

    cpdef inline bint is_normalized(self):
        return gdapi.godot_quat_is_normalized(&self._gd_data)

    cpdef inline Quat inverse(self):
        cdef Quat ret = Quat.__new__(Quat)
        ret._gd_data = gdapi.godot_quat_inverse(&self._gd_data)
        return ret

    cpdef inline godot_real dot(self, Quat b):
        return gdapi.godot_quat_dot(&self._gd_data, &b._gd_data)

    cpdef inline Vector3 xform(self, Vector3 v):
        cdef Vector3 ret = Vector3.__new__(Vector3)
        ret._gd_data = gdapi.godot_quat_xform(&self._gd_data, &v._gd_data)
        return ret

    cpdef inline Quat slerp(self, Quat b, godot_real t):
        cdef Quat ret = Quat.__new__(Quat)
        ret._gd_data = gdapi.godot_quat_slerp(&self._gd_data, &b._gd_data, t)
        return ret

    cpdef inline Quat slerpni(self, Quat b, godot_real t):
        cdef Quat ret = Quat.__new__(Quat)
        ret._gd_data = gdapi.godot_quat_slerpni(&self._gd_data, &b._gd_data, t)
        return ret

    cpdef inline Quat cubic_slerp(self, Quat b, Quat pre_a, Quat post_b, godot_real t):
        cdef Quat ret = Quat.__new__(Quat)
        ret._gd_data = gdapi.godot_quat_cubic_slerp(&self._gd_data, &b._gd_data, &pre_a._gd_data, &post_b._gd_data, t)
        return ret

    cpdef inline void set_axis_angle(self, Vector3 axis, godot_real angle):
        gdapi11.godot_quat_set_axis_angle(&self._gd_data, &axis._gd_data, angle)


    IDENTITY = Quat(0, 0, 0, 1)