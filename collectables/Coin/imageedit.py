from PIL import Image

im = Image.open("C:/Users/alexm/group_godot_project/collectables/Coin/coin.png")
pixelMap = im.load()

img = Image.new( im.mode, im.size)
pixelsNew = img.load()
for i in range(img.size[0]):
    for j in range(img.size[1]):
        if pixelMap[i,j][0] + pixelMap[i,j][1] + pixelMap[i,j][2] == 255*3:
            pixelsNew[i,j] = (0,0,0,0)
            # pixelsNew[i,j] = (0,0,255,255)
        else:
            pixelsNew[i,j] = pixelMap[i,j]
im.close()
img.show()
img.save("out.png") 
img.close()

