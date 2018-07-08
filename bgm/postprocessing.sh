#!/bin/bash
# fetch record and subject file from azure storage service

echo "Begining fetching filename..."

recordfile=$(az storage blob list -c bangumi --account-key $AZURE_STORAGE_IKELY_KEY --account-name $AZURE_STORAGE_IKELY_ACCOUNT -o table --prefix record | sed 1,2d | tr -s '\040' '\011' | cut -f1,5 | sort -t$'\t' -k2,2r | sed 1q | sed 's/\t.*//g')
echo "Record file read as ${recordfile}."

subjectfile=$(az storage blob list -c bangumi --account-key $AZURE_STORAGE_IKELY_KEY --account-name $AZURE_STORAGE_IKELY_ACCOUNT -o table --prefix subject | sed 1,2d | tr -s '\040' '\011' | cut -f1,5 | sort -t$'\t' -k2,2r | sed 1q | sed 's/\t.*//g')
echo "Subject file read as ${subjectfile}."

recordmonth=$(echo $recordfile | cut -d'-' -f3)
subjectmonth=$(echo $subjectfile | cut -d'-' -f3)
echo "Get record file month ${recordmonth} and subject file month ${subjectmonth}."


[ $recordmonth != $subjectmonth ] && echo "Record month not equal to subject month, exit!" && exit 0
[ -e "$HOME"/"$recordfile" ] && echo "Record file already exists under ${HOME}." || (az storage blob download -c bangumi --account-key $AZURE_STORAGE_IKELY_KEY --account-name $AZURE_STORAGE_IKELY_ACCOUNT -n "$recordfile" -f "$HOME"/"$recordfile" && echo "Record file downloaded under ${HOME}.")
[ -e "$HOME"/"$subjectfile" ] && echo "Subject file already exists under ${HOME}." || (az storage blob download -c bangumi --account-key $AZURE_STORAGE_IKELY_KEY --account-name $AZURE_STORAGE_IKELY_ACCOUNT -n "$subjectfile" -f "$HOME"/"$subjectfile" && echo "Subject file downloaded under ${HOME}.")
recordfile="$HOME"/"$recordfile"
subjectfile="$HOME"/"$subjectfile"

aujourdhui=$(date +"%Y_%m_%d")

# Preprocess files to remove scrapy error
echo "Preprocessing record and subject files."
sed 's/\r//g' $recordfile > /tmp/record.raw
sed 's/\r//g' $subjectfile > /tmp/subject.raw

echo "Sorting files."
sed 1d /tmp/subject.raw | sort -t$'\t' -k2,2n > /tmp/subject.sorted
sed 1d /tmp/record.raw | sort -t$'\t' -k1,1n -k7,7 > /tmp/record.sorted
# Get user.tsv
echo "Generating user.tsv."
cat <(echo "uid\tname\tnickname\tlastactive") <(tac /tmp/record.sorted | awk -F "\t" 'BEGIN {pre=0} pre!=$1 { printf("%d\t%s\t%s\t%s\n", $1, $2, $3, $7); pre=$1}' | tac) > "$HOME"/user_"$aujourdhui".tsv
# Join correct subject id
echo "Solving redirected subjects..."
cut -f2,3 --complement /tmp/record.sorted | sort -t$'\t' -k2,2 > /tmp/record.right
cut -f1,2 /tmp/subject.sorted | awk -F "\t" '{print $0; if($1 != $2) printf("%d\t%d\n", $1, $1);}' | sort -t$'\t' -k2,2 > /tmp/subject.left
cat <(echo "uid\tiid\ttyp\tstate\tadddate\trate\ttags\tcomment") <(join -12 -22 -t$'\t' -o 2.1,1.1,2.3,2.4,2.5,2.6,2.7,2.8 /tmp/subject.left /tmp/record.right | sort -t$'\t' -k1,1n -k5,5) > "$HOME"/record_"$aujourdhui".tsv
# Remove duplicated subject in subject.tsv
awk -F "\t" '$1==$2 {print $0;}' < /tmp/subject.sorted | cut -f2 --complement | sort -t$'\t' -k1,1 > /tmp/subject.filtered
# expand related entity list
echo "Solving redirected subjects in related works..."
cut -f1,9 /tmp/subject.filtered | awk -F "\t" '$2!="" { split($2, a, ";"); for(i in a){ split(a[i], b, ":"); split(b[2], c, ","); for(j in c){printf("%d\t%s\t%d\n", $1, b[1], c[j]);} } }' | sort -t$'\t' -k3,3 > /tmp/subject.related.right
join -12 -23 -t$'\t' -o 2.1,2.2,1.1 /tmp/subject.left /tmp/subject.related.right | sort -t$'\t' -k1,1n -k2,2 > /tmp/subject.related.filtered
awk -F "\t" 'NR==1 {id=$1; type=$2; itm=$3;} NR!=1 { if(id!=$1 || type!=$2) { printf("%d\t%s\t%s\n", id, type, itm); id=$1; type=$2; itm=$3;} else { itm=(itm "," $3); } } END {printf("%d\t%s\t%s\n", id, type, itm);}' /tmp/subject.related.filtered > /tmp/subject.related.rec1
awk -F "\t" 'NR==1 {id=$1; rec=($2 ":" $3)} NR!=1 { if(id!=$1) { printf("%d\t%s\n", id, rec); id=$1; rec=($2 ":" $3); } else { rec=(rec ";" $2 ":" $3); } } END { printf("%d\t%s\n", id, rec); } ' /tmp/subject.related.rec1 | sort -t$'\t' -k1,1 > /tmp/subject.related.rec2
join -11 -21 -t$'\t' -o 1.1,1.2,1.3,1.4,1.5,1.6,1.7,1.8,2.2 -a1  /tmp/subject.filtered /tmp/subject.related.rec2 | sort -t$'\t' -k1,1n > "$HOME"/subject_"$aujourdhui".tsv
