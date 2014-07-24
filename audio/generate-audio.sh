speak_command=$1
count=$2
dir=$(dirname $0)
if [[ -z $speak_command ]]; then
  speak_command=espeak
fi
if [[ $speak_command = espeak ]]; then
  output_option=-w
else
  output_option=-o
  output_format=--file-format=WAVE
fi
if [[ -z $count ]]; then
  count=20
fi

function nth() {
  i=$1
  o=(th st nd rd th th th th th th);
  echo ${i}${o[$(($i%10))]}
}

function say_this() {
  message=$1
  output_file=$2
  if [[ -n $output_file ]]; then
    output_segment=$output_option $dir/set.wav $output_format
  fi
  $speak_command $output_segment $message
}

function is_integer() {
  [ "$1" -eq "$1" ] > /dev/null 2>&1
  return $?
}

function from_seconds() {
  if [[ $1 -ge 3600 ]]; then
    echo $(($1 / 3600)) hours
  elif [[ $1 -ge 60 ]]; then
    echo $(($1 / 60)) minutes
  else
    echo $(($1)) seconds
  fi
}

function to_seconds() {
  read quantity unit <<< $(sed -E 's/([0-9]+)([smh])?/\1 \2/' <<< $1)
  if [[ h = $unit ]]; then
    echo $(($quantity * 3600))
  elif [[ m = $unit ]]; then
    echo $(($quantity * 60))
  else
    echo $quantity
  fi
}


if [[ $count != 0 ]]; then
  say_this "set" $dir/set.wav
  say_this "interval" $dir/interval.wav

  for i in $(seq $count); do
    say_this "$(nth $i)" $dir/count-${i}.wav
    say_this "$i" $dir/${i}.wav
  done
else
  if [[ -n $3 ]]; then
    shift 2
    read sets intervals <<< $@
  else
    echo 'INTERACTIVE MODE (no audio files will be saved)'
    read -p 'sets, intervals: ' sets intervals
  fi
  s=0
  while [[ $s -lt $sets ]]; do
    s=$(($s+1))
    i=0
    for interval in $intervals; do
      i=$(($i+1))
      time=$(to_seconds $(sed -E 's/^([0-9]+[smh]?)-?.*$/\1/' <<< $interval))
      message=$(sed -E 's/^[0-9]+[smh]?-?(.*)$/\1/' <<< $interval)
      if [[ -z $message ]]; then message="$(nth $i) interval"; fi
      say_this "$message, $(from_seconds $time), set $s" &
      sleep $time
    done
  done
  say_this "DONE!" &
fi
