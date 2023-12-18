# Program tworzy 4 pliki typu .png. 3 z nich są kolejnymi stopniami oceniania. Mam nadzieję, że dobrze zinterpretowałem docelowe działanie programu
# 1result.png - otoczenie obiektów bounding boxami
# 2result.png - wycięcie bounding boxów z obrazka
# 3result.png - usunięcie tła dookoła obiektu

import numpy as np
import cv2

def binaryzacja_obrazu(image):
    obraz_binarny = np.zeros_like(image)
    obraz_binarny[image > 21] = 255
    
    return obraz_binarny

def find_contours(image):
    contours = []
    height, width = image.shape
    visited = np.zeros((height, width), dtype=np.uint8)

    for y in range(height):
        for x in range(width):
            if visited[y, x] == 0 and image[y, x] > 0:
                contour = []
                stack = [(x, y)]

                while stack:
                    px, py = stack.pop()
                    if visited[py, px] == 0 and image[py, px] > 0:
                        contour.append((px, py))
                        visited[py, px] = 255

                        if px > 0:
                            stack.append((px - 1, py))
                        if px < width - 1:
                            stack.append((px + 1, py))
                        if py > 0:
                            stack.append((px, py - 1))
                        if py < height - 1:
                            stack.append((px, py + 1))

                contours.append(np.array(contour))

    return contours

def find_added_objects(original, modified):
    print("1. szukanie roznic")
    diff = np.abs(original.astype(int) - modified.astype(int)).astype(np.uint8)

    gray_diff = np.dot(diff[...,:3], [0.2989, 0.5870, 0.1140]).astype(np.uint8)

    thresh = binaryzacja_obrazu(gray_diff)
    cv2.imwrite('0result.png', thresh, [cv2.IMWRITE_PNG_COMPRESSION, 0])
    print("2. szukanie bboxow")
    contours = find_contours(thresh)

    bounding_boxes = []
    for contour in contours:
        x_min = np.min(contour[:, 0])
        y_min = np.min(contour[:, 1])
        x_max = np.max(contour[:, 0])
        y_max = np.max(contour[:, 1])
        bounding_boxes.append((x_min, y_min, x_max, y_max))

    return bounding_boxes

def create_mask(image, bounding_boxes):
    mask = np.zeros_like(image)

    for bbox in bounding_boxes:
        x_min, y_min, x_max, y_max = bbox
        mask[y_min:y_max+1, x_min:x_max+1] = image[y_min:y_max+1, x_min:x_max+1]

    return mask

original_image = cv2.imread('london.jpg')
modified_image = cv2.imread('london_ed.jpg')

added_objects_bboxes = find_added_objects(original_image, modified_image)

result = modified_image.copy()
for bbox in added_objects_bboxes:
    x_min, y_min, x_max, y_max = bbox
    for x in range(x_min, x_max + 1):
        result[y_min, x] = (20, 255, 20)
        result[y_max, x] = (20, 255, 20)
        result[y_min+1, x+1] = (20, 255, 20)
        result[y_max+1, x+1] = (20, 255, 20)
    for y in range(y_min, y_max + 1):
        result[y, x_min] = (20, 255, 20)
        result[y, x_max] = (20, 255, 20)
        result[y+1, x_min+1] = (20, 255, 20)
        result[y+1, x_max+1] = (20, 255, 20)

        mask = create_mask(result, added_objects_bboxes)
        
print("3. zapisywanie wyniku")
cv2.imwrite('1result.png', result, [cv2.IMWRITE_PNG_COMPRESSION, 0])
print(" -zapisano naniesione bounding boxy")
transparent_mask = np.zeros_like(result, dtype=np.uint8)
transparent_mask[mask > 0] = 255

result_rgba = np.zeros((result.shape[0], result.shape[1], 4), dtype=np.uint8)
result_rgba[:, :, :3] = result[:, :, :3]
result_rgba[:, :, 3] = 255
result_rgba[:, :, 3] = transparent_mask[:, :, 0]

cv2.imwrite('2result.png', result_rgba, [cv2.IMWRITE_PNG_COMPRESSION, 0])
print(" -zapisano wycięte bounding boxy")
image_difference = cv2.imread('0result.png')
image_mod = cv2.imread('london_ed.jpg', cv2.IMREAD_UNCHANGED)

image_mod_masked = np.where(image_difference > 0, image_mod, 0)


image_mod_masked_rgba = np.zeros((image_mod_masked.shape[0], image_mod_masked.shape[1], 4), dtype=np.uint8)
image_mod_masked_rgba[:, :, :3] = image_mod_masked[:, :, :3]
image_mod_masked_rgba[:, :, 3] = 255
image_mod_masked_rgba[np.all(image_mod_masked_rgba == [0, 0, 0, 255], axis=-1)] = [0, 0, 0, 0]

cv2.imwrite('3result.png', image_mod_masked_rgba)
print(" -zapisano wycięte obiekty bez tła")