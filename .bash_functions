# A file of custom bash functions to suite my peronal use of the command line


# Function used for diary. Use the -f command to specify a file other than the default.
# -o opens the diary and -c closes it.
diary(){
        local OPTIND diaryfile
        # the default diary file is defined here. Will be overwritten with the -f option
        diaryfile=entries
        local OPTIND diarypath
        diarypath=~/Refl/entries
        while getopts ":f:oc" opt; do
                case $opt in
                        f) diaryfile=$OPTARG; diarypath=$(pwd)/$OPTARG; echo "f was used with file $diarypath";;
                        o) gpg --output ${diarypath}.txt --decrypt ${diarypath}; 
				if [ "$?" = "0" ]; then
					vim ${diarypath}.txt
				else
					echo "Could not open diary because of gpg failure."
					return 1
				fi;;
                        c) mv "${diarypath}" "~/Refl/entries_backup/${diaryfile}_$(date +%y-%m-%d_%H:%M:%S)"; #first backup the diary file in case of any problems 
                        gpg --output ${diarypath} --symmetric ${diarypath}.txt;
                                if [ "$?" = "0" ]; then
                                        rm ${diarypath}.txt
                                else
                                        echo "Did not complete diary close because of  gpg failure."
                                        return 1
                                fi
                        ;;
                        \?) echo "Invalid option: -$OPTARG"; return 1;;
                        :) echo "Option $OPTARG requires an argument."; return 1;;
                esac
        done
}

############testing bash functions. can delete this section, but its a good example of getopts

getopts_test(){
        local OPTIND word
        while getopts ":ach:e" option; do
                case $option in
                        a) word=hello;;
                        b) word=bye;;
                        c) word=well then;;#spaces break thingsi
                        h) echo "the option used was $OPTARG";;
                        ?) echo "invalid option: $(pwd)/$OPTARG"; return 1;;
                        :) echo "Option $OPTARG requires an argument."; return 1;;
                esac
        done
        echo "this is the word $word"
}

##############end delete section

