
self.tilemap = layer_tilemap_get_id("TileColls");
self.tilemap_offx = layer_get_x("TileColls");
self.tilemap_offy = layer_get_y("TileColls");

tilemap_set_width(self.tilemap, 40);
tilemap_set_height(self.tilemap, 30);
