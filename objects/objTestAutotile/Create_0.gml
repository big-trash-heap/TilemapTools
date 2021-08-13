
#region tile list

self.tileList = [
	"Tile16_0",
];

self.tileCurrentIndex = 0;
self.tileCurrentTile  = undefined;

self.__tileSize = array_length(self.tileList);
self.tileScroll = function(_step) {

	layer_set_visible(self.tileList[self.tileCurrentIndex], false);
	
	self.tileCurrentIndex = 
		(((self.tileCurrentIndex + _step) mod self.__tileSize) + self.__tileSize) mod self.__tileSize;
	
	var _layer = self.tileList[self.tileCurrentIndex];
	
	layer_set_visible(_layer, true);
	self.tileCurrentTile = layer_tilemap_get_id(_layer);
}

for (var _i = 0; _i < self.__tileSize; ++_i) {
	
	layer_set_visible(self.tileList[_i], false);
}

self.tileScroll(0);

#endregion

