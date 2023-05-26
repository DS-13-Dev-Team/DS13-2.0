
/* Equivalence checking. Compares components exactly.
*/
/proc/equalent(datum/position/v, datum/position/p)
	return v ? p.x == v.x && p.y == v.y : FALSE

/* Position addition.
*/
/proc/summ(datum/position/v, datum/position/p)
	return p ? new /datum/position(p.x + v.x, p.y + v.y) : new /datum/position(p.x, p.y)

/* Position subtraction and negation.
*/
/proc/subtraction(datum/position/v, datum/position/p)
	return p ? new /datum/position(v.x - p.x, p.y - v.y) : new /datum/position(-p.x, -p.y)

/* Position scaling.
*/
/datum/position/proc/multiply(s)
	// Scalar
	if(isnum(s)) return new /datum/position(x * s, y * s)

	// Transform
	else if(istype(s, /matrix))
		var/matrix/m = s
		return new /datum/position(x * m.a + y * m.b + m.c, x * m.d + y * m.e + m.f)

	// Component-wise
	else if(istype(s, /datum/position))
		var/datum/position/v = s
		return new /datum/position(x * v.x, y * v.y)

	else CRASH("Invalid args.")

/* Position inverse scaling.
*/
/datum/position/proc/divide(d)
	// Scalar
	if(isnum(d)) return new /datum/position(x / d, y / d)

	// Inverse transform
	else if(istype(d, /matrix)) return src * ~d

	// Component-wise
	else if(istype(d, /datum/position))
		var/datum/position/v = d
		return new /datum/position(x / v.x, y / v.y)

	else CRASH("Invalid args.")

/* Position dot product.
	Returns the cosine of the angle between the positions.
*/
/datum/position/proc/Dot(datum/position/v)
	return x * v.x + y * v.y

/* Z-component of the 3D cross product.
	Returns the sine of the angle between the vectors.
*/
/datum/position/proc/Cross(datum/position/v)
	return x * v.y - y * v.x

/* Get a vector with the same magnitude rotated by a clockwise angle in degrees.
*/
//Future TODO: Make and implement a self version of this
/datum/position/proc/Turn(angle)
	return src.multiply(matrix().Turn(angle))

/datum/position/proc/SelfTurn(inputangle)

	var/matrix/m = matrix().Turn(inputangle)

	// Transform
	var/temp_x = x * m.a + y * m.b + m.c
	var/temp_y = x * m.d + y * m.e + m.f

	x = temp_x
	y = temp_y

/* Get the matrix that rotates north to point in this direction.
	This can be used as the transform of an atom whose icon is drawn pointing north.
*/
/datum/position/proc/Rotation()
	return RotationFrom()

/* Get the matrix that rotates from_vector to point in this direction.
	This can be used as the transform of an atom whose icon is drawn pointing in the direction of from_vector.
	Also accepts a dir.
*/
/datum/position/proc/RotationFrom(datum/position/from_vector = new(0, 1))
	var/datum/position/to_vector = src

	var/from_created = FALSE
	if(isnum(from_vector))
		from_vector = NewFromDir(from_vector)
		from_created = TRUE

	if(istype(from_vector, /datum/position))
		var/cos_angle = to_vector.Dot(from_vector)
		var/sin_angle = to_vector.Cross(from_vector)
		.= matrix(cos_angle, sin_angle, 0, -sin_angle, cos_angle, 0)
		to_vector = null

	else
		CRASH("Invalid 'from' vector.")

	if (from_created)
		from_vector = null

/* Get the components via index (1, 2) or name ("x", "y").
*/
/datum/position/proc/operator[](index)
	switch(index)
		if(1, "x")
			return x
		if(2, "y")
			return y
		else
			CRASH("Invalid args.")

/* Get the matrix that rotates from_vector to point in this direction.
	Also accepts a dir.
*/
/datum/position/proc/AngleFrom(datum/position/from_vector = new(0, 1), shorten = FALSE)
	var/datum/position/to_vector = src

	if(isnum(from_vector))
		from_vector = NewFromDir(from_vector) //This is not copied, gotta be careful with it

	var/angle = (Atan2(to_vector.y, to_vector.x) - Atan2(from_vector.y, from_vector.x))
	to_vector = null
	if (shorten)
		angle = shortest_angle(angle)

	return angle

/proc/NewFromDir(dir)
	var/datum/position/v
	switch(dir)
		if(NORTH)
			v = new(0, 1)
		if(SOUTH)
			v = new(0, -1)
		if(EAST)
			v = new(1, 0)
		if(WEST)
			v = new(-1, 0)
		if(NORTHEAST)
			v = new(1, 1)
		if(SOUTHEAST)
			v = new(1, -1)
		if(NORTHWEST)
			v = new(-1, 1)
		if(SOUTHWEST)
			v = new(-1, -1)
	return v

/proc/DirectionBetween(atom/A, atom/B)
	var/datum/position/delta = new(B.x - A.x, B.y - A.y)
	return delta
