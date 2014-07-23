# Interval Training

An _exercise_ in Angular ~\_^

## installation

Setup [Bower](https://github.com/bower/bower) for dependencies:
```
bower install
```

Create audio files for counting off intervals and reps.

On GNU/Linux, install espeak (`sudo apt-get install espeak`), and run:
```
bash audio/generate-audio.sh
```

On Mac, run:
```
bash audio/generate-audio.sh say
```

## extra
You can add more counting sounds by adding a number after the speech program,
as in:
```
#GNU/Linux
bash audio/generate-audio.sh espeak 30

#Mac
bash audio/generate-audio.sh say 30
```

### CLI
You can use a command line version of the app by doing the above command while
specifing `0` as the last parameter.

You will be prompted for sets and intervals. `3 5 30` would give you 3 reps
with 2 intervals of 5 and 30 seconds. You can also name your intervals, like `3
5-rest 30-work`, and this name will be called out when the interval starts.

You can also pass your reps and intervals in the initial call:
```
bash audio/generate-audio.sh say 0 3 5-rest 30-work
```

This is easiest if you define an alias:
```
alias interval="bash /PATH/TO/REPO/audio/generate-audio.sh say 0"
interval 3 5-rest 30-work
```
