#!/bin/bash

# Check number of arguments
if [ "$#" -ne 1 ]; then
    echo "Usage: $0 scriptname"
    exit 1
fi

fdum="$1"

txtfile="help_${fdum}.txt"
mdfile0="help_${fdum}.md0"
mdfile="help_${fdum}.md"
echo "\`\`\`console" > ${mdfile}
echo "(venv_numina) \$ ${fdum} --help" >> ${mdfile}
echo "\`\`\`" >> ${mdfile}
echo "" >> ${mdfile}
FORCE_COLOR=1 ${fdum} --help > ${txtfile}
num_lines=$(wc -l < "${txtfile}")
../../extract_blocks_ansi.sh "${txtfile}" "${mdfile0}" 1 "${num_lines}"
cat ${mdfile0} >> ${mdfile}
\rm ${mdfile0}
