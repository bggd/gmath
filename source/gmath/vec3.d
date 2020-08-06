module gmath.vec3;

import std.math;

struct Vec3(T)
{
    union
    {
        T[3] array = [0, 0, 0];
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

Vec3!T add(T)(ref Vec3!T a, ref Vec3!T b)
{
    Vec3!T v;
    for (int i = 0; i < 3; ++i)
    {
        v[i] = a[i] + b[i];
    }
    return v;
}

Vec3!T sub(T)(ref Vec3!T a, ref Vec3!T b)
{
    Vec3!T v;
    for (int i = 0; i < 3; ++i)
    {
        v[i] = a[i] - b[i];
    }
    return v;
}

Vec3!T mul(T)(ref Vec3!T a, ref Vec3!T b)
{
    Vec3!T v;
    for (int i = 0; i < 3; ++i)
    {
        v[i] = a[i] * b[i];
    }
    return v;
}

Vec3!T mulScalar(T)(ref Vec3!T a, T scalar)
{
    Vec3!T v;
    for (int i = 0; i < 3; ++i)
    {
        v[i] = a[i] * scalar;
    }
    return v;
}

T dot(T)(ref Vec3!T a, ref Vec3!T b)
{
    T n = 0;
    for (int i = 0; i < 3; ++i)
    {
        n += a[i] * b[i];
    }
    return n;
}

T length(T)(ref Vec3!T v)
{
    return sqrt(dot(v, v));
}

T length2(T)(ref Vec3!T v)
{
    return dot(v, v);
}

Vec3!T normalize(T)(ref Vec3!T v)
{
    if (!v[0] && !v[1] && !v[2]) {
      return v;
    }

    Vec3!T norm;
    T len = 1.0 / length(v);
    for (int i = 0; i < 3; ++i)
    {
        norm[i] = v[i] * len;
    }
    return norm;
}

Vec3!T cross(T)(ref Vec3!T a, ref Vec3!T b)
{
    Vec3!T v;
    v[0] = a[1] * b[2] - a[2] * b[1];
    v[1] = a[2] * b[0] - a[0] * b[2];
    v[2] = a[0] * b[1] - a[1] * b[0];
    return v;
}

unittest
{
    alias vec3i = Vec3!int;

    vec3i defaultValue;
    assert(defaultValue[0] == 0);
    assert(defaultValue[1] == 0);
    assert(defaultValue[2] == 0);

    auto ctor = vec3i(0, 1, 2);
    assert(ctor[0] == 0);
    assert(ctor[1] == 1);
    assert(ctor[2] == 2);

    vec3i ctorArray = [0, 1, 2];
    assert(ctorArray[0] == 0);
    assert(ctorArray[1] == 1);
    assert(ctorArray[2] == 2);
}
