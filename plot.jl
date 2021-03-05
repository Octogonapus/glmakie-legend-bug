using GLMakie, FileIO

f = Figure()
ax = f[1,1] = Axis(f)
s = scatter!(ax, 1:4)
f[1,2] = Legend(f, [s], ["dots"])

FileIO.save("/out/plot-headless.png", f)
