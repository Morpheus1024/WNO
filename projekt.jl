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

print("Temperatura otoczenia [C]: ")
T0 = parse(Float32, readline()) # dla uproszczenia założono, że temperatura lodu jest taka sama jak otoczenia
while T0 > 0
    print("TEMPERATURA MUSI BYĆ MNIEJSZA OD ZERA BY WODA BYŁA W STANIE STAŁYM. PODAJ JESZCZE RAZ: ")
    global T0 = parse(Float32, readline()) # dla uproszczenia założono, że temperatura lodu jest taka sama jak otoczenia
end
print("Masa łyżwirza [kg] ")
m = parse(Float32, readline())
print("Długość ostrza łyżew z zaokrągleniem do pełnego milimetran [mm]: ")
x = parse(Int64, readline())
print("Długość toru jazdy z zaokrągleniem do pełnego metra [m]: ")
s = parse(Int32, readline())
print("Prędkość z jaką porusza się łyżwiarz [m/s]: ")
v = parse(Float32, readline())

x=x/1000 # zamiana na metry

let #https://discourse.julialang.org/t/undefined-variable-in-loop/72936
    temp = zeros(Float32, s*100)
    delta_x = 0.001 #iterowanie co 1 milimetr
    delta_s = 0.01 # iterowanie co 1 cm trasy
    przebyta_droga = 0.0
    T_poprzednie= T0
    T = 0
    delta_temp =0.0

    for i in 1:s*100
        if i==1
            T=T0
            temp[i] = T0
        else
            przebyta_droga +=delta_s
            delta_temp = (alfa*d*a*H*x*Cw*(T+T_poprzednie)+delta_x*delta_x*(u*m*g*v-h*x*H*(T-T0)-epsilon*sigma*(T*T*T*T-T0*T0*T0*T0)))/(alfa*d*a*H*x*Cw + delta_x*k*x*H)
            T_poprzednie = T
            T -=delta_temp 
            temp[i] = T
        end
    end
    plot_title = string("T0= $T0 ℃, v= $v m/s, M= $m kg, ostrze- $x m")
    ox = repeat(1:s*100)
    p = plot(ox/100, temp[ox], title=plot_title, legend = false, xlabel = "Droga [m]", ylabel="Temperatura [℃]")
    Plots.pdf(p,"plot")
end

println()
println("   ~~~ Plik plot.pdf powinien już się pojawić ~~~   ")
println()

