
/// @function		apiMthARound(number, f);
function apiMthARound(_number, _f) {
	return (sign(_number) * _f(abs(_number)));
}

/// @param			number
function apiMthTrunc(_number) {
	return (sign(_number) == -1 ? ceil : floor)(_number);
}

