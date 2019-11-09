import os
from PIL import Image
from pathlib import Path
import numpy as np


if __name__ == '__main__':
    path = os.path.join("data", "att_faces")
    for subdir, dirs, files in os.walk(path):
        for file in files:
            in_img_path = Path(os.path.join(subdir, file))
            img = Image.open(in_img_path)

            out_img_name = file.split(".")[0] + ".png"
            tmp = Path(subdir).parts
            root = os.path.join(tmp[0], "png", *tmp[1:])
            out_img_path = os.path.join(root, out_img_name)
            tmp = Path(subdir).parts
            root_small = os.path.join(tmp[0], "png", "downscaled", *tmp[1:])
            out_img_small_path = os.path.join(root_small, out_img_name)

            if not os.path.exists(os.path.split(out_img_path)[0]):
                os.makedirs(os.path.split(out_img_path)[0])

            if not os.path.exists(os.path.dirname(out_img_small_path)):
                os.makedirs(os.path.dirname(out_img_small_path))

            in_img = np.array(img)
            out_img = in_img[::2, ::2]
            img_small = Image.fromarray(out_img)
            img.save(out_img_path, "png")
            img_small.save(out_img_small_path, "png")

