#stałe potrzebne do symulacji
const a = 0.006                 # szerokość ostrza
const k = 30                    # przewodność cieplna stali nierdzewnej
const g = 9.81                  # stała grawitacyjna Ziemi
const u = 0.15                  # uśredniony współczynnik tarcia dynamicznego stali nierdzewnej o lód
const H = 0.05                  # wysokość ostrza łyżwy
const d = 7900                  # średnia gęstość stali nierdzewnej
const Cw = 500                  # średnie ciepło właściwe sali nierdzewnej
const h = 280                   # współczynnik konwekcji dla przepływu powietrza
const alfa = 4.2/1000000        # dyfuzycjność cieplna stali nierdzewnej
const sigma = 5.67/100000000    # stała Stefana Boltzmanna
const epsilon = 0.15            # średnia właściwe emisyjności polerowane stali nierdzewnej


using Plots

# pobieranie zmiennych symulacyjnych od użytkonika
# print("Temperatura otoczenia [C]: ")
# T0 = parse(Float32, readline()) # dla uproszczenia założono, że temperatura lodu jest taka sama jak otoczenia
# print("Masa łyżwirza [kg] ")
# m = parse(Float32, readline())
# print("Długość ostrza łyżew [mm] z zaokrągleniem do pełnego milimetra: ")
# x = parse(Int64, readline())
# print("Długość toru jazdy [m] z zaokrągleniem do pełnego metra: ")
# s = parse(Int32, readline())
# print("Prędkość z jaką porusza się łyżwiarz [m/s]: ")
# v = parse(Float32, readline())

T0 = -30
m = 100
x = 250
s = 10
v = 1

temp = zeros(Float32, s*100)

delta_x = 0.001 #iterowanie co 1 milimetr
delta_s = 0.01 # iterowanie co 1 cm trasy
przebyta_droga = 0.0
T_poprzednie= T0
T = 0

for i in 1:s*100
    if i==1
        global T = T0
        global temp[i] = T0

    else
        global przebyta_droga +=delta_s
        delta_temp = (alfa*d*a*H*x*Cw*(T+T_poprzednie)+delta_x*delta_x*(u*m*g*v-h*x*H*(T-T0)-epsilon*sigma*(T*T*T*T-T0*T0*T0*T0)))/(alfa*d*a*H*x*Cw + delta_x*k*x*H)
        global T_poprzednie = T
        global T -=delta_temp
            
        global temp[i] = T
        
    end
end

#println(temp[s*90])
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

ox = repeat(1:s*100)

p = plot(ox/100, temp[ox])
Plots.pdf(p,"plot")

