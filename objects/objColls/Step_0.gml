
self.image_xscale -= 0.005;
if (self.image_xscale < -4) self.image_xscale = 4;

self.image_yscale += 0.0067;
if (self.image_yscale > 4) self.image_yscale = -4;

self.dy = (self.dy + 1) mod 250;
self.y = self.ystart - self.dy;
