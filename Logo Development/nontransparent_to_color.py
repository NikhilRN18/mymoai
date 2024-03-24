from PIL import Image

def convert_to_single_color(img_path, output_path, hex_color):
    img = Image.open(img_path)
    img = img.convert("RGBA")
    
    datas = img.getdata()
    
    newData = []
    for item in datas:
        # If the pixel is not transparent (alpha channel is not 0)
        if item[3] != 0:
            # Change it to the hex color provided
            newData.append(tuple(int(hex_color[i:i+2], 16) for i in (0, 2, 4)) + (255,))
        else:
            # Keep the pixel transparent
            newData.append(item)
    
    img.putdata(newData)
    img.save(output_path, "PNG")

# Usage
convert_to_single_color("transparent_cherryblossom.png", "cherryblossom_pink.png", "ffd1dc")
