import numpy as np
import matplotlib.pyplot as plt
from matplotlib.animation import FuncAnimation

R = 0.05
def krzywa(x):
    return (2 * np.sin(x) + np.sqrt(1 / x)) / (x**2 + 53 + np.exp(x))

def cykloida(t):
    x = R * (t - np.sin(t))
    y = R * (1 - np.cos(t))+krzywa(x)
    return x, y

def sr_kola(t):
    x = t*R
    y = R+krzywa(x)
    return x, y

def inicjowanie_animacji():
    punkty_cykloidy.set_data([], [])
    punkt_srodek_okregu.set_data([], [])
    slad_cykloidy.set_data([], [])
    promien_wodzacy.set_data([], [])
    krzywa_animacja.set_data([], [])
    okrog_wokol_punktu.set_center((0, 0))
    return punkty_cykloidy, punkt_srodek_okregu, slad_cykloidy, promien_wodzacy, krzywa_animacja, okrog_wokol_punktu

def animacja(t):
    x1, y1 = cykloida(t)
    punkty_cykloidy.set_data(x1, y1)
    x2, y2 = sr_kola(t)
    punkt_srodek_okregu.set_data(x2, y2)
    slad_cykloidy.set_data(np.append(slad_cykloidy.get_xdata(), x1), np.append(slad_cykloidy.get_ydata(), y1))
    promien_wodzacy.set_data([x1, x2], [y1, y2])
    x_krzywa = np.linspace(0.000000000000001, 10, 10000)
    y_krzywa = krzywa(x_krzywa)
    krzywa_animacja.set_data(x_krzywa, y_krzywa)

    okrog_wokol_punktu.set_center((x2, y2))

    return punkty_cykloidy, punkt_srodek_okregu, slad_cykloidy, promien_wodzacy, krzywa_animacja, okrog_wokol_punktu

fig, ax = plt.subplots()
ax.set_aspect('equal', 'box')
ax.set_xlim(-1, 10)
ax.set_ylim(-1, 2)

punkty_cykloidy, = ax.plot([], [], 'bo', markersize=3)
punkt_srodek_okregu, = ax.plot([], [], 'go', markersize=3)
slad_cykloidy, = ax.plot([], [], 'r-')
promien_wodzacy, = ax.plot([], [], 'k-')
krzywa_animacja, = ax.plot([], [], 'b-')
okrog_wokol_punktu = plt.Circle((0, 0), R, fill=False, color='blue')
ax.add_patch(okrog_wokol_punktu)

czas_rysowania = np.linspace(0.000000000000001, 1000, 10000)
animacja = FuncAnimation(fig, animacja, frames=czas_rysowania, init_func=inicjowanie_animacji, blit=True, interval=10)

plt.show()
