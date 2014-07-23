speak_command=$1
count=$2
dir=$(dirname $0)
if [[ -z $speak_command ]]; then
  speak_command=espeak
fi
if [[ -z $count ]]; then
  count=20
fi

$speak_command -w $dir/rep.wav rep
$speak_command -w $dir/interval.wav interval

o=(th st nd rd th th th th th th);
for i in $(seq $count); do
  $speak_command -w $dir/${i}.wav ${i}
  $speak_command -w $dir/count-${i}.wav ${i}${o[$((i%10))]}
done
