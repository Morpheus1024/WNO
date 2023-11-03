#stałe potrzebne do symulacji
const a = 0.006   # szerokość ostrza
const k = 30      # przewodność cieplna stali nierdzewnej
const g = 9.81    # stała grawitacyjna Ziemi
const u = 0.15    # uśredniony współczynnik tarcia dynamicznego stali nierdzewnej o lód
const h = 0.05    # wysokość ostrza łyżwy
const d = 7900    # średnia gęstość stali nierdzewnej
const Cw = 500    # średnie ciepło właściwe sali nierdzewnej
const h_O2 = 280  # współczynnik konwekcji dla przepływu powietrza

using Plots

# pobieranie zmiennych symulacyjnych od użytkonika
print("Temperatura otoczenia [C]: ")
T0 = parse(Float32, readline()) # dla uproszczenia założono, że temperatura lodu jest taka sama jak otoczenia
print("Masa łyżwirza [kg] ")
m = parse(Float32, readline())
print("Długość ostrza łyżew [mm] z zaokrągleniem do pełnego milimetra: ")
x = parse(Int64, readline())
print("Długość toru jazdy [m] z zaokrągleniem do pełnego metra: ")
s = parse(Int32, readline())
print("Prędkość z jaką porusza się łyżwiarz [m/s]: ")
v = parse(Float32, readline())

temp = zeros(Int, x, s*100)

delta_x = 0.001 #iterowanie co 1 milimetr
delta_s = 0.01 # iterowanie co 1 cm trasy
przebyta_droga = 0.0
dlugosc_na_ostrzu = 0.0
T = T0
for i in 1:x 
    for j in 1:s*100
        if j==1
            temp[i,j] = T0
        else
            global przebyta_droga +=delta_s
            delta_temp =( u*m*g*v - h*h_O2*(2*dlugosc_na_ostrzu+2*a)*(T-T0))/(a*dlugosc_na_ostrzu*(d*Cw*v*h/przebyta_droga + k/delta_x))
            global T +=delta_temp
            temp[i,j] = T
        end
    end

    global przebyta_droga = 0
    global dlugosc_na_ostrzu +=delta_x
end

print(temp[10,10])
#plot(temp, shape(temp))
# Generowanie siatki dla wykresu 3D
# m,n = temp.size
# println(m)
# println(n)

# Ox = repeat(1:m, inner=n)
# Oy = repeat(1:n, outer=m)
# Oz = vec(temp)

#p = scatter(x, y, z, zcolor=z, color=:blues, marker=:square, xlabel="Oś X", ylabel="Oś Y", zlabel="Oś Z", title="Wykres 3D")

#plot = scatter(Ox,Oy,Oz)
#Plots.pdf(plot,"projekt")

# Tworzenie wykresu 3D

