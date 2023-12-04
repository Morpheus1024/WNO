import tkinter as tk
import random

class Point:
    def __init__(self, x, y, canvas):
        self.x = x
        self.y = y
        self.canvas = canvas

    def draw(self, color="blue"):
        self.canvas.create_oval(self.x - 2, self.y - 2, self.x + 2, self.y + 2, fill=color)

    def __str__(self):
        return f"({round(self.x, 3)}, {round(self.y, 3)})"

def orientation(p, q, r):
    val = (q.y - p.y) * (r.x - q.x) - (q.x - p.x) * (r.y - q.y)
    if val == 0:
        return 0  # collinear
    return 1 if val > 0 else 2  # clock or counterclockwise

def convex_hull_animation(canvas, points, hull_indices, i, connecting_lines):
    if i >= len(hull_indices):
        # Connect the last point to the very first point
        last_index = hull_indices[-1]
        first_index = hull_indices[0]
        last_point = points[last_index]
        first_point = points[first_index]
        connecting_line = canvas.create_line(last_point.x, last_point.y, first_point.x, first_point.y, fill="red")
        connecting_lines.append(connecting_line)

        # Print connected points in the terminal
        connected_points = [points[index] for index in hull_indices]
        print(f"Connected Points: {[str(point) for point in connected_points]}")
        return

    current_index = hull_indices[i]
    current_point = points[current_index]

    # Draw current convex hull point
    current_point.draw(color="red")

    # Connect the current point to the next point in the convex hull
    if i > 0:
        previous_index = hull_indices[i - 1]
        previous_point = points[previous_index]
        connecting_line = canvas.create_line(previous_point.x, previous_point.y, current_point.x, current_point.y, fill="red")
        connecting_lines.append(connecting_line)

    canvas.after(500, convex_hull_animation, canvas, points, hull_indices, i + 1, connecting_lines)

def convex_hull_jarvis(points):
    n = len(points)
    if n < 3:
        return list(range(n))

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

def main():
    root = tk.Tk()
    root.title("Convex Hull Animation")

    canvas = tk.Canvas(root, width=400, height=400, bg="white")
    canvas.pack()

    points = [Point(random.uniform(10, 390), random.uniform(10, 390), canvas) for _ in range(20)]

    # Draw random points
    for point in points:
        point.draw()

    # Find convex hull (Jarvis algorithm)
    hull_indices = convex_hull_jarvis(points)

    # Draw convex hull points
    for index in hull_indices:
        points[index].draw(color="red")

    # Connect the convex hull points before starting the animation
    for i in range(len(hull_indices) - 1):
        p1 = points[hull_indices[i]]
        p2 = points[hull_indices[i + 1]]
        print(f"Connecting: {p1} to {p2}")
        canvas.create_line(p1.x, p1.y, p2.x, p2.y, fill="red")

    # Wait for a moment before starting the animation
    root.after(2000, convex_hull_animation, canvas, points, hull_indices, 0, [])

    root.mainloop()

if __name__ == "__main__":
    main()
