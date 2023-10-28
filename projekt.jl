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
print("Długość ostrza łyżew [cm]: ")
x = parse(Float32, readline())
x = x/100 # zamiana na metry
print("Długość toru jazdy [m]: ")
s = parse(Float32, readline())
print("Prędkość z jaką porusza się łyżwiarz [m/s]: ")
v = parse(Float32, readline())

temp = []
temp_na_danymm_odc_trasy = []

# delta_x = x/10
# delta_s = s/100


delta_x = 0.002 #iterowanie co 2 milimetry ostrza
delta_s = 0.01 # iterowanie co 1 cm trasy
przebyta_droga = 0
dlugosc_na_ostrzu = 0
T = T0 # warunek początkowy
for i in 1:s*100
    global T = T0
    for j in 0:x*100*5
        global dlugosc_na_ostrzu+=delta_x
        delta_temp = (u*m*g*v - h*h_O2*(2*dlugosc_na_ostrzu+2*a)*(T-T0))/(a*dlugosc_na_ostrzu*(d*Cw*v*h/przebyta_droga + k/delta_x))
        #print(delta_temp)
        global T +=delta_temp
        push!(temp_na_danymm_odc_trasy,T)
    end
    global przebyta_droga += delta_s
    global dlugosc_na_ostrzu =0
    push!(temp, temp_na_danymm_odc_trasy)
    #savefig(plot(x, temp_na_danymm_odc_trasy),"plot.pdf")
    global temp_na_danymm_odc_trasy =[]
end
print(T)

# plot3d(temp)
#print(temp_na_danymm_odc_trasy)
#end


