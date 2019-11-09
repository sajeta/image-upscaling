import os
import numpy as np
from pathlib import Path
from PIL import Image


def downsccale(img_name):
    out_img_name = img_name.split(".")[0] + ".png"

    img = Image.open(in_img_path)
    in_img = np.array(img)
    out_img = in_img[::2, ::2]
    img_small = Image.fromarray(out_img)
    img_small.save(out_img_name, "png")


if __name__ == '__main__':
    path = os.path.join("data", "png", "att_faces")
    for subdir, dirs, files in os.walk(path):
        for file in files:
            in_img_path = Path(os.path.join(subdir, file))
            img = Image.open(in_img_path)

            out_img_name = file.split(".")[0] + ".png"
            tmp = Path(subdir).parts
            root_small = os.path.join(tmp[0], "png", "downscaled", *tmp[1:])
            out_img_small_path = os.path.join(root_small, out_img_name)

            if not os.path.exists(os.path.dirname(out_img_small_path)):
                os.makedirs(os.path.dirname(out_img_small_path))

            in_img = np.array(img)
            out_img = in_img[::2, ::2]
            img_small = Image.fromarray(out_img)
            img_small.save(out_img_small_path, "png")
