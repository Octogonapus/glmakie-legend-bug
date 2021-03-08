To reproduce the issue, run:

```sh
docekr build .
docker run -v /absolute/path/to/glmakie-legend-bug/out:/out:z <DOCKER IMAGE SHA>  # Generate the headless plot
julia plot-with-head.jl  # Generate the normal plot
```

To produce the diff image, install ImageMagick and run:

```sh
compare plot-with-head.png plot-headless.png -compose src diff.png
```
