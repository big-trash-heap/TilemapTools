
function apiMthARound(_number, _f) {
	return (sign(_number) * _f(abs(_number)));
}

function apiMthTrunc(_number) {
	return (sign(_number) == -1 ? ceil(_number) : floor(_number));
}

