import matplotlib.pyplot as plt
import numpy as np
import matplotlib.image as image
import cv2
from PIL import Image


def rgb2gray(rgb):
    return np.dot(rgb[..., :3], [0.2989, 0.5870, 0.1140])


def downsccale(img_name):
    out_img_name = img_name.split(".")[0] + ".png"

    in_img = image.imread(img_name)
    out_img = in_img[::2, ::2]
    image.imsave(fname=out_img_name, format="png", arr=out_img)


def upscaale_channel(in_img):
    print(in_img.shape)

    target_shape = (in_img.shape[0]*2, in_img.shape[1])

    upsized_img = np.zeros(target_shape)
    upsized_img[::2, :] = np.copy(in_img)

    tmp1 = np.zeros_like(in_img)
    tmp1[1:, :] = in_img[:-1, :]
    tmp2 = np.zeros_like(in_img)
    tmp2[:-1, :] = in_img[1:, :]
    upsized_img[1::2, :] = (tmp1 + tmp2) / 2
    # upsized_img[1::2, :] = tmp1

    upsized_img2 = np.zeros((upsized_img.shape[0], upsized_img.shape[1]*2))
    upsized_img2[:, ::2] = np.copy(upsized_img)

    tmp1 = np.zeros_like(upsized_img)
    tmp1[:, 1:] = upsized_img[:, :-1]
    tmp2 = np.zeros_like(upsized_img)
    tmp2[:, :-1] = upsized_img[:, 1:]
    upsized_img2[:, 1::2] = (tmp1 + tmp2) / 2
    # upsized_img2[:, 1::2] = tmp1

    return np.copy(upsized_img2)


if __name__ == '__main__':
    in_file = "demo-pic4.png"
    out_file = in_file.split(".")[0] + "_upscaled_laplace.png"

    in_img = np.array(Image.open(in_file))

    # out_img = in_img[::2, ::4]
    #
    # plt.figure()
    # plt.imshow(in_img)
    # plt.show()
    #
    # plt.figure()
    # plt.imshow(out_img)
    # plt.show()

    # stupid_format_img = Image.open(in_file)
    # stupid_format_img.save(out_file, "png")
    #
    # img = image.imread(out_file, format="png")
    # # img = rgb2gray(img)
    # # img = cv2.imread("Lenna.png")
    # # img = rgb2gray(img)
    # print(type(img), np.shape(img))
    #
    # target_shape = img.shape
    #
    # # downsized_img = img[::2, ::2]
    # # upsized_img = np.zeros(target_shape)
    # # upsized_img[::2, ::2] = downsized_img
    # #
    # # tmp1 = np.zeros((downsized_img.shape[0], target_shape[1]))
    # # tmp1[1:, :] = downsized_img[:-1, :]
    # # tmp2 = np.zeros((downsized_img.shape[0], target_shape[1]))
    # # tmp2[:-1, :] = downsized_img[1:, :]
    # # tmp3 = np.zeros_like(downsized_img)
    # # tmp3[:, 1:] = downsized_img[:, :-1]
    # # tmp4 = np.zeros_like(downsized_img)
    # # tmp4[:, :-1] = downsized_img[:, 1:]
    #
    # # upsized_img[1::2, :] = (tmp1 + tmp2)/2
    #
    # downsized_img = img[::2]

    # input("Press any key to continue....")

    target_shape = (in_img.shape[0]*2, in_img.shape[1]*2, in_img.shape[2])

    upsized_img = np.zeros(target_shape)

    upsized_img[:, :, 0] = upscaale_channel(in_img[:, :, 0])
    upsized_img[:, :, 1] = upscaale_channel(in_img[:, :, 1])
    upsized_img[:, :, 2] = upscaale_channel(in_img[:, :, 2])

    plt.figure()
    plt.imshow(upsized_img[:, :, 0])
    plt.show()

    plt.figure()
    plt.imshow(upsized_img[:, :, 1])
    plt.show()

    plt.figure()
    plt.imshow(upsized_img[:, :, 2])
    plt.show()

    # plt.figure()
    # plt.imshow(img)
    # plt.show()
    # image.imsave(fname="original.png", format="png", arr=img)
    # # cv2.imwrite("original.png", img)
    #
    # plt.figure()
    # plt.imshow(downsized_img)
    # plt.show()
    # image.imsave(fname="small.png", format="png", arr=downsized_img)
    # # cv2.imwrite("small.png", downsized_img)
    #
    plt.figure()
    plt.imshow(upsized_img.astype("uint8"))
    plt.show()
    out_img = Image.fromarray(upsized_img.astype("uint8"))
    out_img.save(out_file, "png")
    # image.imsave(fname=out_file, format="png", arr=upsized_img)
    # # cv2.imwrite("upscaled.png", upsized_img)



