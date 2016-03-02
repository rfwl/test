function Color(r, g, b)
{
	this.red = parseInt(r) % 256;
	this.green = parseInt(g) % 256;
	this.blue = parseInt(b) % 256;

	return this;
}

function createGraphics(width, height)
{
	this.updateImage = function(imageId)
	{
		var img = document.getElementById(imageId);
		if (img != null)
		{
			img.src = 'data:image/bmp;base64,' + window.btoa(imageHeader + imageData.join(""));
		}
	}

	this.clear = function(color)
	{
		var newColor = String.fromCharCode(color.blue, color.green, color.red, 0);
		for (var i=0; i<sizeOfImage; i++)
		{
			imageData[i] = newColor;
		}
	}

	getPixelColor = function(pixel)
	{
		var pixelColor = pixel.toString();
		return new Color(pixelColor.charCodeAt(2), pixelColor.charCodeAt(1), pixelColor.charCodeAt(0));
	}

	this.drawLine = function(x1, y1, x2, y2, color)
	{
		var newColor = String.fromCharCode(color.blue, color.green, color.red, 0);
		var dx = x2 - x1;
		var dy = y2 - y1;
		if (Math.abs(dx) > Math.abs(dy))
		{
			var k = dy / dx;
			if (x1 > x2)
			{
				var temp = x1;
				x1 = x2;
				x2 = temp;

				temp = y1;
				y1 = y2;
				y2 = temp;
			}
			y = y1;
			for (var x=x1+1; x<=x2; x++)
			{
				imageData[parseInt(y)*imgWidth+x] = newColor;
				y += k;
			}
		}
		else
		{
			var k = dx / dy;
			if (y1 > y2)
			{
				var temp = y1;
				y1 = y2;
				y2 = temp;

				temp = x1;
				x1 = x2;
				x2 = temp;
			}
			x = x1;
			for (var y=y1+1; y<=y2; y++)
			{
				imageData[y*imgWidth+parseInt(x)] = newColor;
				x += k;
			}
		}
	}

	this.drawLineAlpha = function(x1, y1, x2, y2, color, alpha)
	{
		alpha = Math.min(1, Math.max(0, parseFloat(alpha) / 100.0));
		var newColor = String.fromCharCode(color.blue, color.green, color.red, 0);
		var dx = x2 - x1;
		var dy = y2 - y1;
		if (Math.abs(dx) > Math.abs(dy))
		{
			var k = dy / dx;
			if (x1 > x2)
			{
				var temp = x1;
				x1 = x2;
				x2 = temp;

				temp = y1;
				y1 = y2;
				y2 = temp;
			}
			y = y1;
			for (var x=x1+1; x<=x2; x++)
			{
				var oldColor = getPixelColor(imageData[parseInt(y)*imgWidth+x]);
				var red = color.red*alpha + oldColor.red*(1.0-alpha);
				var green = color.green*alpha + oldColor.green*(1.0-alpha);
				var blue = color.blue*alpha + oldColor.blue*(1.0-alpha);
				var newColor = String.fromCharCode(blue, green, red, 0);
				imageData[parseInt(y)*imgWidth+x] = newColor;
				y += k;
			}
		}
		else
		{
			var k = dx / dy;
			if (y1 > y2)
			{
				var temp = y1;
				y1 = y2;
				y2 = temp;

				temp = x1;
				x1 = x2;
				x2 = temp;
			}
			x = x1;
			for (var y=y1+1; y<=y2; y++)
			{
				var oldColor = getPixelColor(imageData[y*imgWidth+parseInt(x)]);
				var red = color.red*alpha + oldColor.red*(1.0-alpha);
				var green = color.green*alpha + oldColor.green*(1.0-alpha);
				var blue = color.blue*alpha + oldColor.blue*(1.0-alpha);
				var newColor = String.fromCharCode(blue, green, red, 0);
				imageData[y*imgWidth+parseInt(x)] = newColor;
				x += k;
			}
		}
	}

	this.drawRectangle = function(x1, y1, x2, y2, color)
	{
		var newColor = String.fromCharCode(color.blue, color.green, color.red, 0);
		for (var y=y1; y<=y2; y++)
		{
			imageData[y*imgWidth+x1] = newColor;
			imageData[y*imgWidth+x2] = newColor;
		}
		for (var x=x1+1; x<x2; x++)
		{
			imageData[y1*imgWidth+x] = newColor;
			imageData[y2*imgWidth+x] = newColor;
		}
	}

	this.drawRectangleAlpha = function(x1, y1, x2, y2, color, alpha)
	{
		alpha = Math.min(1, Math.max(0, parseFloat(alpha) / 100.0));
		for (var y=y1; y<=y2; y++)
		{
			var oldColor = getPixelColor(imageData[y*imgWidth+x1]);
			var red = color.red*alpha + oldColor.red*(1.0-alpha);
			var green = color.green*alpha + oldColor.green*(1.0-alpha);
			var blue = color.blue*alpha + oldColor.blue*(1.0-alpha);
			var newColor = String.fromCharCode(blue, green, red, 0);
			imageData[y*imgWidth+x1] = newColor;

			var oldColor = getPixelColor(imageData[y*imgWidth+x2]);
			var red = color.red*alpha + oldColor.red*(1.0-alpha);
			var green = color.green*alpha + oldColor.green*(1.0-alpha);
			var blue = color.blue*alpha + oldColor.blue*(1.0-alpha);
			var newColor = String.fromCharCode(blue, green, red, 0);
			imageData[y*imgWidth+x2] = newColor;
		}
		for (var x=x1+1; x<x2; x++)
		{
			var oldColor = getPixelColor(imageData[y1*imgWidth+x]);
			var red = color.red*alpha + oldColor.red*(1.0-alpha);
			var green = color.green*alpha + oldColor.green*(1.0-alpha);
			var blue = color.blue*alpha + oldColor.blue*(1.0-alpha);
			var newColor = String.fromCharCode(blue, green, red, 0);
			imageData[y1*imgWidth+x] = newColor;

			var oldColor = getPixelColor(imageData[y2*imgWidth+x]);
			var red = color.red*alpha + oldColor.red*(1.0-alpha);
			var green = color.green*alpha + oldColor.green*(1.0-alpha);
			var blue = color.blue*alpha + oldColor.blue*(1.0-alpha);
			var newColor = String.fromCharCode(blue, green, red, 0);
			imageData[y2*imgWidth+x] = newColor;
		}
	}

	this.fillRectangle = function(x1, y1, x2, y2, color)
	{
		var newColor = String.fromCharCode(color.blue, color.green, color.red, 0);
		for (var y=y1; y<y2; y++)
		{
			for (var x=x1; x<x2; x++)
			{
				imageData[y*imgWidth+x] = newColor;
			}
		}
	}

	this.fillRectangleAlpha = function(x1, y1, x2, y2, color, alpha)
	{
		alpha = Math.min(1, Math.max(0, parseFloat(alpha) / 100.0));
		for (var y=y1; y<y2; y++)
		{
			for (var x=x1; x<x2; x++)
			{
				var oldColor = getPixelColor(imageData[y*imgWidth+x]);
				var red = color.red*alpha + oldColor.red*(1.0-alpha);
				var green = color.green*alpha + oldColor.green*(1.0-alpha);
				var blue = color.blue*alpha + oldColor.blue*(1.0-alpha);
				var newColor = String.fromCharCode(blue, green, red, 0);
				imageData[y*imgWidth+x] = newColor;
			}
		}
	}

	this.gradientRectangleH = function(x1, y1, x2, y2, color1, color2)
	{
		var dr = (color2.red - color1.red) / (x2 - x1);
		var dg = (color2.green - color1.green) / (x2 - x1);
		var db = (color2.blue - color1.blue) / (x2 - x1);
		for (var y=y1; y<y2; y++)
		{
			var red = color1.red;
			var green = color1.green;
			var blue = color1.blue;
			for (var x=x1; x<x2; x++)
			{
				red += dr;
				green += dg;
				blue += db;
				var newColor = String.fromCharCode(blue, green, red, 0);
				imageData[y*imgWidth+x] = newColor;
			}
		}
	}

	this.gradientRectangleHAlpha = function(x1, y1, x2, y2, color1, color2, alpha)
	{
		alpha = Math.min(1, Math.max(0, parseFloat(alpha) / 100.0));
		var dr = (color2.red - color1.red) / (x2 - x1);
		var dg = (color2.green - color1.green) / (x2 - x1);
		var db = (color2.blue - color1.blue) / (x2 - x1);
		for (var y=y1; y<y2; y++)
		{
			var red = color1.red;
			var green = color1.green;
			var blue = color1.blue;
			for (var x=x1; x<x2; x++)
			{
				red += dr;
				green += dg;
				blue += db;
				var oldColor = getPixelColor(imageData[y*imgWidth+x]);
				var newRed = red*alpha + oldColor.red*(1.0-alpha);
				var newGreen = green*alpha + oldColor.green*(1.0-alpha);
				var newBlue = blue*alpha + oldColor.blue*(1.0-alpha);
				var newColor = String.fromCharCode(newBlue, newGreen, newRed, 0);
				imageData[y*imgWidth+x] = newColor;
			}
		}
	}

	this.gradientRectangleV = function(x1, y1, x2, y2, color1, color2)
	{
		var dr = (color2.red - color1.red) / (y2 - y1);
		var dg = (color2.green - color1.green) / (y2 - y1);
		var db = (color2.blue - color1.blue) / (y2 - y1);
		for (var x=x1; x<x2; x++)
		{
			var red = color1.red;
			var green = color1.green;
			var blue = color1.blue;
			for (var y=y1; y<y2; y++)
			{
				red += dr;
				green += dg;
				blue += db;
				var newColor = String.fromCharCode(blue, green, red, 0);
				imageData[y*imgWidth+x] = newColor;
			}
		}
	}

	this.gradientRectangleVAlpha = function(x1, y1, x2, y2, color1, color2, alpha)
	{
		alpha = Math.min(1, Math.max(0, parseFloat(alpha) / 100.0));
		var dr = (color2.red - color1.red) / (y2 - y1);
		var dg = (color2.green - color1.green) / (y2 - y1);
		var db = (color2.blue - color1.blue) / (y2 - y1);
		for (var x=x1; x<x2; x++)
		{
			var red = color1.red;
			var green = color1.green;
			var blue = color1.blue;
			for (var y=y1; y<y2; y++)
			{
				red += dr;
				green += dg;
				blue += db;
				var oldColor = getPixelColor(imageData[y*imgWidth+x]);
				var newRed = red*alpha + oldColor.red*(1.0-alpha);
				var newGreen = green*alpha + oldColor.green*(1.0-alpha);
				var newBlue = blue*alpha + oldColor.blue*(1.0-alpha);
				var newColor = String.fromCharCode(newBlue, newGreen, newRed, 0);
				imageData[y*imgWidth+x] = newColor;
			}
		}
	}

	var imgWidth = parseInt(width);
	var imgHeight = parseInt(height);
	var imageData = new Array();
	var sizeOfImage = imgWidth * imgHeight;

	_asLittleEndianHex = function(value, bytes)
	{
		var result = [];
		for (; bytes>0; bytes--)
		{
			result.push(String.fromCharCode(value & 255));
			value >>= 8;
		}
		return result.join('');

	}

	height = _asLittleEndianHex(height, 4);
        width = _asLittleEndianHex(width, 4);
        num_file_bytes = _asLittleEndianHex(sizeOfImage*4, 4);
        imageHeader = ('BM' +                // "Magic Number"
                	num_file_bytes +     // size of the file (bytes)*
                	'\x00\x00' +         // reserved
                	'\x00\x00' +         // reserved
                	'\x36\x00\x00\x00' + // offset of where BMP data lives (54 bytes)
                	'\x28\x00\x00\x00' + // number of remaining bytes in header from here (40 bytes)
                	width +              // the width of the bitmap in pixels*
                	height +             // the height of the bitmap in pixels*
                	'\x01\x00' +         // the number of color planes (1)
                	'\x20\x00' +         // 32 bits / pixel
                	'\x00\x00\x00\x00' + // No compression (0)
                	'\x00\x00\x00\x00' + // size of the BMP data (bytes)*
                	'\x13\x0B\x00\x00' + // 2835 pixels/meter - horizontal resolution
                	'\x13\x0B\x00\x00' + // 2835 pixels/meter - the vertical resolution
               		'\x00\x00\x00\x00' + // Number of colors in the palette (keep 0 for 32-bit)
                	'\x00\x00\x00\x00'   // 0 important colors (means all colors are important)
			);

	return this;
}
