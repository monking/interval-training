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
fi
if [[ -z $count ]]; then
  count=20
fi

o=(th st nd rd th th th th th th);

if [[ $count != 0 ]]; then
  $speak_command $output_option $dir/rep.wav rep
  $speak_command $output_option $dir/interval.wav interval

  for i in $(seq $count); do
    $speak_command $output_option $dir/count-${i}.wav ${i}${o[$((i%10))]}
    $speak_command $output_option $dir/${i}.wav ${i}
  done
else
  echo 'INTERACTIVE MODE (no audio files will be saved)'
  read -p 'reps, intervals: ' reps intervals
  r=0
  while [[ $r -lt $reps ]]; do
    r=$(($r+1))
    i=0
    for interval in $intervals; do
      i=$(($i+1))
      $speak_command "${i}${o[$((i%10))]} interval, $interval seconds, rep $r" &
      sleep $interval
    done
  done
  $speak_command "DONE!" &
fi
