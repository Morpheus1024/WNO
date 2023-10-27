# using DifferentialEquations
# f(u, p, t) = 1.01 * u
# u0 = 1 / 2
# tspan = (0.0, 1.0)
# prob = ODEProblem(f, u0, tspan)
# sol = solve(prob, Tsit5(), reltol = 1e-8, abstol = 1e-8)

# using Plots
# plot(sol, linewidth = 5, title = "Solution to the linear ODE with a thick line",
#     xaxis = "Time (t)", yaxis = "u(t) (in μm)", label = "My Thick Line!") # legend=false
# plot!(sol.t, t -> 0.5 * exp(1.01t), lw = 3, ls = :dash, label = "True Solution!")

przebyta_droga = 0  # Zadeklaruj i zainicjuj zmienną przebyta_droga na 0

for i in 1:5
    global przebyta_droga += i  # Zwiększ wartość przebyta_droga o i w każdej iteracji
end

println(przebyta_droga)  # Wyświetli 15 (bo 0 + 1 + 2 + 3 + 4 + 5 = 15)
