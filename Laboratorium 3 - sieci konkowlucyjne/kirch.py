import cv2
import numpy as np
import matplotlib.pyplot as plt
from collections import deque

image_path = "pg.jpg"
image = cv2.imread(image_path, cv2.IMREAD_GRAYSCALE)

def Kirch():
    g1 = np.array([[5, 5, 5], [-3, 0, -3], [-3, -3, -3]])
    g2 = np.rot90(g1)
    g3 = np.rot90(g2)
    g4= np.rot90(g3)
    g5 = g1
    g5[0,2] = -3
    g5[1,0] = 5 
    g6 = np.rot90(g5)
    g7 = np.rot90(g6)
    g8= np.rot90(g7)


    tabs = np.zeros((image.shape[0], image.shape[1], 8), dtype=np.int32)

    for i in range(1, image.shape[0] - 1):
        for j in range(1, image.shape[1] - 1):
            tabs[i, j, 0] = np.abs((g1 * image[i-1:i+2, j-1:j+2]).sum())
            tabs[i, j, 1] = np.abs((g2 * image[i-1:i+2, j-1:j+2]).sum())
            tabs[i, j, 2] = np.abs((g3 * image[i-1:i+2, j-1:j+2]).sum())
            tabs[i, j, 3] = np.abs((g4 * image[i-1:i+2, j-1:j+2]).sum())
            tabs[i, j, 4] = np.abs((g5 * image[i-1:i+2, j-1:j+2]).sum())
            tabs[i, j, 5] = np.abs((g6 * image[i-1:i+2, j-1:j+2]).sum())
            tabs[i, j, 6] = np.abs((g7 * image[i-1:i+2, j-1:j+2]).sum())
            tabs[i, j, 7] = np.abs((g8 * image[i-1:i+2, j-1:j+2]).sum())

    return tabs

if image is not None:
    tabs = Kirch()

    final_image = np.sum(tabs, axis=2)

    # Normalize the colors
    final_image = cv2.normalize(final_image, None, 0, 255, cv2.NORM_MINMAX, dtype=cv2.CV_8U)

    # Display the final image using OpenCV
    cv2.imshow("Final Image", final_image)
    cv2.waitKey(0)
    cv2.destroyAllWindows()

else:
    print("Failed to read the image.")
