

#region basic

/// @param			...values
function apiFunctorEm() {
	return undefined;
}

/// @function		apiFunctorId(value, ...values);
function apiFunctorId(_value) {
	return _value;
}

/// @param			value
function apiFunctorArr(_value) {
	return (is_array(_value) ? _value : [_value]);
}

#endregion

