# Interval Training

An _exercise_ in Angular ~\_^

## installation

Setup [Bower](https://github.com/bower/bower) for dependencies:
```
bower install
```

Create audio files for counting off intervals and reps.

On Ubuntu, install espeak (`sudo apt-get install espeak`), and run:
```
bash audio/generate-audio.sh
```

On Mac, run:
```
bash audio/generate-audio.sh say
```

## extra
You can add more counting sounds by adding a number after the speech program, as in
```
#Ubuntu
bash audio/generate-audio.sh espeak 30

#Mac
bash audio/generate-audio.sh say 30
```

If you specify `0`, then you'll enter the interactive timer.
