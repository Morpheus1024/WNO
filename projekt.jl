#stałe potrzebne do symulacji
const a = 0,004   # szerokość ostrza
const k = 30      # przewodność cieplna stali nierdzewnej
const g = 9,81    # stała grawitacyjna Ziemi
const u = 0,15    # uśredniony współczynnik tarcia dynamicznego stali nierdzewnej o lód
const h = 0,03    # wysokość ostrza łyżwy
const d = 7850    # średnia gęstość stali nierdzewnej
const Cw = 500    # średnie ciepło właściwe sali nierdzewnej

function deltaTemp(v, x, s, dx)

    dTemp = (u*m*g*v)/(a*x*(v*d*h*Cw/s + k/dx))
    return dTemp
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

T = Vector{1000}
for i = 1:1000
    if i==1
        T[i] = T0 + deltaTemp(v, x, s, x/1000)
    else 
        T[i] = deltaTemp(v, x, s, x/1000) + T[i-1]
    end

    println(T[i])
end
