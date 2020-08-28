module gmath.vector3;

import std.math;

struct Vector3(T)
{
    union
    {
        T[3] array;
        struct
        {
            T x;
            T y;
            T z;
        }
    }

    alias array this;

    this(T[3] elements)
    {
        this.array[0] = elements[0];
        this.array[1] = elements[1];
        this.array[2] = elements[2];
    }

    this(T a, T b, T c)
    {
        this.x = a;
        this.y = b;
        this.z = c;
    }
}

Vector3!T add(T)(ref Vector3!T a, ref Vector3!T b)
{
    Vector3!T v;
    for (int i = 0; i < 3; ++i)
    {
        v[i] = a[i] + b[i];
    }
    return v;
}

Vector3!T sub(T)(ref Vector3!T a, ref Vector3!T b)
{
    Vector3!T v;
    for (int i = 0; i < 3; ++i)
    {
        v[i] = a[i] - b[i];
    }
    return v;
}

Vector3!T mul(T)(ref Vector3!T a, ref Vector3!T b)
{
    Vector3!T v;
    for (int i = 0; i < 3; ++i)
    {
        v[i] = a[i] * b[i];
    }
    return v;
}

Vector3!T mulScalar(T)(ref Vector3!T a, T scalar)
{
    Vector3!T v;
    for (int i = 0; i < 3; ++i)
    {
        v[i] = a[i] * scalar;
    }
    return v;
}

T dot(T)(ref Vector3!T a, ref Vector3!T b)
{
    T n = 0;
    for (int i = 0; i < 3; ++i)
    {
        n += a[i] * b[i];
    }
    return n;
}

T length(T)(ref Vector3!T v)
{
    return sqrt(dot(v, v));
}

T length2(T)(ref Vector3!T v)
{
    return dot(v, v);
}

Vector3!T normalize(T)(ref Vector3!T v)
{
    if (!v[0] && !v[1] && !v[2]) {
      return v;
    }

    Vector3!T norm;
    T len = 1.0 / length(v);
    for (int i = 0; i < 3; ++i)
    {
        norm[i] = v[i] * len;
    }
    return norm;
}

Vector3!T cross(T)(ref Vector3!T a, ref Vector3!T b)
{
    Vector3!T v;
    v[0] = a[1] * b[2] - a[2] * b[1];
    v[1] = a[2] * b[0] - a[0] * b[2];
    v[2] = a[0] * b[1] - a[1] * b[0];
    return v;
}

unittest
{
    alias vec3i = Vector3!int;

    vec3i defaultInt;
    assert(defaultInt[0] == 0);
    assert(defaultInt[1] == 0);
    assert(defaultInt[2] == 0);

    auto ctor = vec3i(0, 1, 2);
    assert(ctor[0] == 0);
    assert(ctor[1] == 1);
    assert(ctor[2] == 2);

    vec3i ctorArray = [0, 1, 2];
    assert(ctorArray[0] == 0);
    assert(ctorArray[1] == 1);
    assert(ctorArray[2] == 2);

    alias vec3f = Vector3!float;

    vec3f defaultFloat;
    assert(isNaN(defaultFloat[0]));
    assert(isNaN(defaultFloat[1]));
    assert(isNaN(defaultFloat[2]));
}
