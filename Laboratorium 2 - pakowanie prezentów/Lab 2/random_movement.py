import tkinter as tk
import random
import time

class Point:
    def __init__(self, x, y, canvas):
        self.x = x
        self.y = y
        self.canvas = canvas

    def draw(self, color="blue"):
        self.canvas.create_oval(self.x - 2, self.y - 2, self.x + 2, self.y + 2, fill=color)

def orientation(p, q, r):
    val = (q.y - p.y) * (r.x - q.x) - (q.x - p.x) * (r.y - q.y)
    if val == 0:
        return 0  # collinear
    return 1 if val > 0 else 2  # clock or counterclockwise

def convex_hull(points):
    n = len(points)
    if n < 3:
        return points

    hull = []

    l = min(range(n), key=lambda i: points[i].x)
    p = l
    q = 0

    while True:
        hull.append(p)
        q = (p + 1) % n
        for i in range(n):
            if orientation(points[p], points[i], points[q]) == 2:
                q = i
        p = q
        if p == l:
            break

    return hull

def connect_points(canvas, points, indices):
    for i in range(len(indices) - 1):
        p1 = points[indices[i]]
        p2 = points[indices[i + 1]]
        canvas.create_line(p1.x, p1.y, p2.x, p2.y, fill="red")

def update_points_animation(root, canvas, points, animation_steps):
    if animation_steps > 0:
        for point in points:
            choice = random.choice([1, -1])  # randomly choose between adding or subtracting
            point.x += choice * 2  # Add or subtract a small number to the x value
            point.y += choice * 2  # Add or subtract a small number to the y value

        canvas.delete("all")  # Clear the canvas
        for point in points:
            point.draw()  # Draw the updated points

        hull_indices = convex_hull(points)
        for idx in hull_indices:
            points[idx].draw(color="red")

        connect_points(canvas, points, hull_indices + [hull_indices[0]])

        root.update()  # Force an update of the Tkinter window
        time.sleep(0.05)  # Adjust the sleep duration for the desired animation speed

        root.after(50, update_points_animation, root, canvas, points, animation_steps - 1)

def main():
    root = tk.Tk()
    root.title("Animated Convex Hull")

    canvas = tk.Canvas(root, width=400, height=400, bg="white")
    canvas.pack()

    points = [Point(random.uniform(10, 390), random.uniform(10, 390), canvas) for _ in range(20)]

    # Draw random points
    for point in points:
        point.draw()

    root.after(1000, update_points_animation, root, canvas, points, 50)  # Start animation after 1 second

    root.mainloop()

if __name__ == "__main__":
    main()
