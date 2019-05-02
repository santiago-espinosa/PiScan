for i in "${SERVICES[@]}"
 do
   ###CHECK SERVICE####
   `pgrep $i >/dev/null 2>&1`
   STATS=$(echo $?)

   ###IF SERVICE IS NOT RUNNING####
   if [[  $STATS == 1  ]]

       then
       ##TRY TO RESTART THAT SERVICE###
       service $i start

       ##CHECK IF RESTART WORKED###
       `pgrep $i >/dev/null 2>&1`
       RESTART=$(echo $?)

       if [[  $RESTART == 0  ]]
           ##IF SERVICE HAS BEEN RESTARTED###
           then
               ##REMOVE THE TMP FILE IF EXISTS###
               if [ -f "/tmp/$i" ];
               then
                   rm /tmp/$i
               fi

               ##SEND AN EMAIL###
               MESSAGE="$i   is down, but looks like I was able to restart it on   on $(hostname) $(date)  "
               SUBJECT="$i  down -but restarted-  on $(hostname) $(date) "
               echo   $MESSAGE | mail -s "$SUBJECT" "$EMAIL"

           else
               ##IF RESTART DID NOT WORK###

               ##CHECK IF THERE IS NOT A TMP FILE###
               if [ ! -f "/tmp/$i" ]; then

                   ##CREATE A TMP FILE###
                   touch /tmp/$i

                   ##SEND A DIFFERENT EMAIL###
                   MESSAGE="$i is down   on $(hostname)  at $(date)  "
                   SUBJECT=" $i  down on $(hostname) $(date) "
                   echo $MESSAGE  " I tried to restart it, but it did not work"  | mail -s "$SUBJECT" "$EMAIL"
               else
                   exit 0;
               fi
       fi
   fi
 done
