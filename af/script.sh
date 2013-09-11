for i in `cat /tmp/af_vars`
do
  BOL=`fgrep -lr $i * | grep -v nodes.pp`
  
  if [ -z "${BOL}" ];
  then
    echo $i
  fi
done
