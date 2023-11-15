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
plotly()

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

T0 = -1
m = 80
x = 50
s = 1
v = 10

temp = zeros(Float32, s*100, x)
#print(size(temp))
# x=x/1000 # zamiana na metry z mm


delta_x =0.001 #iterowanie co 1 milimetr
delta_s = 0.01 # iterowanie co 1 cm trasy
przebyta_droga = 0.0
dlugosc_ostrza = 0.0
T_poprzednie= T0
T = 0

for j in 1:x
    global dlugosc_ostrza += delta_x
    for i in 1:s*100
        if i==1
            global T = T0
            global temp[i, j] = T0

        else
            global przebyta_droga +=delta_s
            delta_temp = (alfa*d*a*H*dlugosc_ostrza*Cw*(T+T_poprzednie)+delta_x*delta_x*(u*m*g*v-h*x*H*(T-T0)-epsilon*sigma*(T*T*T*T-T0*T0*T0*T0)))/(alfa*d*a*H*dlugosc_ostrza*Cw + delta_x*k*x*H)
            global T_poprzednie = T
            global T -=delta_temp
            
            global temp[i, j] = T
        
        end
    end
    
end

ox = repeat(1:s*100, 1, x)
oy = repeat(1:x, s*100, 1)
#p = plot(ox/100, temp[ox], label="Temperatura")
#p = plot3d(ox/100, oy, temp[ox,oy], title = "Temperatura ostrza")
#Plots.pdf(p,"plot")
p = scatter3d(ox/100, oy,temp[ox,oy])
Plots.pdf(p, "plot"))


