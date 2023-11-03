using Plots
#plotlyjs()  # lub pyplot() jeśli wolisz inny silnik

# Przykładowa tablica 2D
tablica = [1 2 3; 4 5 6]
#push!(tablica, [4 5 6])

# Pobranie rozmiaru tablicy
println(tablica)
println(tablica[2,1])
tablica[2,1] = 11
println(tablica[2,1])

println(m)
println(n)

# Przygotowanie danych do wykresu 3D
x = repeat(1:m, inner=n)
y = repeat(1:n, outer=m)
z = vec(tablica)

# Tworzenie wykresu 3D
#p = scatter(x, y, z, zcolor=z, color=:blues, marker=:square, xlabel="Oś X", ylabel="Oś Y", zlabel="Oś Z", title="Wykres 3D")

# Jeśli chcesz dostosować skalę osi, możesz dodać odpowiednie argumenty xlim, ylim, zlim do funkcji scatter.

#Plots.pdf(p,"1")