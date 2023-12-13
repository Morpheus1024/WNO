import numpy as np
import cv2

def gaussian_filter(image, kernel_size, sigma):
    # Creating the Gaussian kernel
    kernel = np.fromfunction(lambda x, y: (1 / (2 * np.pi * sigma**2)) * np.exp(-((x - kernel_size//2)**2 + (y - kernel_size//2)**2) / (2 * sigma**2)), (kernel_size, kernel_size))
    kernel = kernel / np.sum(kernel)  # Normalizing the kernel

    # Applying the Gaussian filter to the image
    filtered_image = cv2.filter2D(image, -1, kernel)

    return filtered_image

# Load the image
image = cv2.imread('test.jpg', cv2.IMREAD_GRAYSCALE)

# Apply the Gaussian filter
filtered_image = gaussian_filter(image, kernel_size=5, sigma=1.0)

# Display the original and filtered images
cv2.imshow('Original Image', image)
cv2.imshow('Filtered Image', filtered_image)
cv2.waitKey(0)
cv2.destroyAllWindows()
