
/*
	2 - переключится в другую комнату

	Управление:
	Q - первый тест
	E - второй тест
	
	Первый тест:
	A, D, W, S - изменения прямоугльника
	
	Второй тест:
	A, D, W, S - изменения смещения спрайта
*/

//
globalvar root;
root = id;

//
self.check = function(_tile) {
	return (_tile != 0);
}

//

self.tilemap      = layer_tilemap_get_id("TileColls");
self.tilemap_offx = layer_get_x("TileColls");
self.tilemap_offy = layer_get_y("TileColls");

tilemap_set_width(self.tilemap, 40);
tilemap_set_height(self.tilemap, 30);

//
self.tests = {};

//
self.tests[$ "0"] = {
	w: 48,
	h: 60,
	init: undefined,
	destroy: undefined,
	test: function() {
		
		if (keyboard_check(ord("A")))
			self.w = max(0, self.w - 1);
		
		if (keyboard_check(ord("D")))
			self.w += 1;
		
		if (keyboard_check(ord("W")))
			self.h = max(0, self.h - 1);
		
		if (keyboard_check(ord("S")))
			self.h += 1;
		
		var _x1 = mouse_x;
		var _y1 = mouse_y;
		var _x2 = _x1 + self.w;
		var _y2 = _y1 + self.h;
		
		var _colls = tilemapCollsRect(root.tilemap, _x1, _y1, _x2, _y2, root.check, 
			undefined, root.tilemap_offx, root.tilemap_offy);
		
		if (_colls)
			draw_set_color(c_red);
		else
			draw_set_color(c_blue);
		
		draw_rectangle(_x1, _y1, _x2, _y2, false);
		
		show_debug_message(_colls);
	}
};

//
self.tests[$ "1"] = {
	init: function() { self.inst = instance_create_depth(1366 - 64, 768 - 64, 0, objColls); },
	destroy: function() { instance_destroy(self.inst); },
	test: function() {
		
		draw_set_color(c_white);
		var _colls = tilemapCollsRectInst(root.tilemap, self.inst, mouse_x, mouse_y,
			root.check, undefined, root.tilemap_offx, root.tilemap_offy);
		
		draw_sprite_ext(sprColls, 0, mouse_x, mouse_y, self.inst.image_xscale, self.inst.image_yscale, 0, _colls ? c_red : c_white, 0.4);
		
		var _keyw = keyboard_check(ord("A")) - keyboard_check(ord("D"));
		var _keyh = keyboard_check(ord("W")) - keyboard_check(ord("S"));
		sprite_set_offset(
			sprColls,
			sprite_get_xoffset(sprColls) + _keyw,
			sprite_get_yoffset(sprColls) + _keyh,
		);
		
		show_debug_message(_colls);
	}
}

//
self.test_cur = undefined;
self.test_set = function(_number) {
	if (!is_undefined(self.test_cur))
		if (!is_undefined(self.test_cur.destroy)) self.test_cur.destroy();
	self.test_cur = self.tests[$ _number];
	if (!is_undefined(self.test_cur.init))
		self.test_cur.init();
}

//
self.test_set(1);
