#stałe potrzebne do symulacji
const a = 0.004   # szerokość ostrza
const k = 30      # przewodność cieplna stali nierdzewnej
const g = 9.81    # stała grawitacyjna Ziemi
const u = 0.15    # uśredniony współczynnik tarcia dynamicznego stali nierdzewnej o lód
const h = 0.03    # wysokość ostrza łyżwy
const d = 7850    # średnia gęstość stali nierdzewnej
const Cw = 500    # średnie ciepło właściwe sali nierdzewnej

function deltaTemp(v, x, s, dx)

    przyrost_temperatury = (u*m*g*v)/(a*x*(v*d*h*Cw/s + k/dx))
    println(przyrost_temperatury)
    return przyrost_temperatury
end

# pobieranie zmiennych symulacyjnych od użytkonika
print("Temperatura otoczenia [C]: ")
T0 = parse(Float32, readline())
print("Masa łyżwirza [kg] ")
m = parse(Float32, readline())
print("Długość ostrza łyżew [cm]: ")
x = parse(Float32, readline())
print("Długość toru jazdy [m]: ")
s = parse(Float32, readline())
print("Prędkość z jaką porusza się łyżwiarz [m/s]: ")
v = parse(Float32, readline())

temp = []
temp_na_danymm_odc_trasy = []

# delta_x = x/10
# delta_s = s/100

#global dlugosc_na_ostrzu = 0.1

delta_x = 1
delta_s = 1
przebyta_droga = 0
for i in 0:s
    for j in 0:10

        if(i == 0)
            push!(temp_na_danymm_odc_trasy, T0)
        end
        delta_temp = (u*m*g*v)/(a*global dlugosc_na_ostrzu*(v*d*h*Cw/ global przebyta_droga + k/dx))
        println(delta_temp)
        # push!(temp_na_danymm_odc_trasy, deltaTemp)
        # przebyta_droga += delta_s
        # dlugosc_na_ostrzu +=delta_x
        # przebyta_droga = 0.1
        # println(przebyta_droga)
    end
end
print(przebyta_droga)
#end

