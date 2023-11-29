import numpy as np
import matplotlib.pyplot as plt
from matplotlib.animation import FuncAnimation
from matplotlib.patches import Circle

R = 5
r = 1

def calculate_epicycloid(a, b, t):
    x = (a + b) * np.cos(t) - b * np.cos((a + b) / b * t)
    y = (a + b) * np.sin(t) - b * np.sin((a + b) / b * t)
    return x, y

def hipocykloida(a, b, t):
    x = (a - b) * np.cos(t) + b * np.cos((a - b) / b * t)
    y = (a - b) * np.sin(t) - b * np.sin((a - b) / b * t)
    return x, y

def inicjowanie_animacji():
    line_epicycloid.set_data([], [])
    line_hypocycloid.set_data([], [])
    point1.set_data([], [])
    point2.set_data([], [])
    circle1.set_center((0, 0))
    circle2.set_center((0, 0))
    circle3.set_center((0, 0))
    ax.add_patch(circle1)
    ax.add_patch(circle2)
    ax.add_patch(circle3)
    return line_epicycloid, line_hypocycloid, point1, point2, circle1, circle2, circle3

def update(frame):
    t = np.linspace(0, 2 * np.pi, 1000)
    x_epicycloid, y_epicycloid = calculate_epicycloid(R, r, t)
    x_hypocycloid, y_hypocycloid = hipocykloida(R, r, t)

    line_epicycloid.set_data(x_epicycloid[:frame], y_epicycloid[:frame])
    line_hypocycloid.set_data(x_hypocycloid[:frame], y_hypocycloid[:frame])

    # Aktualizacja pozycji punktu na okręgu
    x_point1 = (R + r) * np.cos(t[frame])
    y_point1 = (R + r) * np.sin(t[frame])
    x_point2 = (R - r) * np.cos(t[frame])
    y_point2 = (R - r) * np.sin(t[frame])
    point1.set_data(x_point1, y_point1)
    point2.set_data(x_point2, y_point2)

    circle1.set_center((x_point1, y_point1))
    circle2.set_center((x_point2, y_point2))
    circle3.set_center((0,0))
    return line_epicycloid, line_hypocycloid, point1, point2, circle1, circle2, circle3

fig, ax = plt.subplots()
ax.set_aspect('equal')  # Ustawienie równych odległości na osiach
ax.set_xlim(-1.6 * (r + R), 1.6 * (r + R))
ax.set_ylim(-1.6 * (r + R), 1.6 * (r + R))

line_epicycloid, = ax.plot([], [], lw=2)
line_hypocycloid, = ax.plot([], [], lw=2)
point1, = ax.plot([], [], 'ro')
point2, = ax.plot([], [], 'ro')
circle1 = Circle((0, 0), r, color='blue', fill=False)
circle2 = Circle((0, 0), r, color='green', fill=False)
circle3 = Circle((0, 0), R, color='purple', fill=False)

ax.add_patch(circle1)

ani = FuncAnimation(fig, update, frames=range(0, 1000, 10), init_func=inicjowanie_animacji, blit=True)

plt.show()
