render_contents() {

        MD_SRC_FOLDER="$src"
        MD_BLOG_INDEX="index.md"
        POSTS=$(ls -l "$MD_SRC_FOLDER" | grep .md | tr -s ' ' | cut -d ' ' -f 9 | sort -t '-' -k 1 --reverse)
        MD_BLOG_CONTENTS=""

        for line in ${POSTS[@]}
        do
                if [ $(echo "$line" | grep -c 'about') -ne 1 ] &&
                        [ $(echo "$line" | grep -c 'index') -ne 1 ]
                then
                        title="$(tail -n 1 "$MD_SRC_FOLDER"/"$line" | cut -d ' ' -f 1-3)  -  $(head -n 1 "$MD_SRC_FOLDER"/"$line" | cut -d ' ' -f2-)"
                        link="${line%.md}".html
                        entry="* [$title]($link)"
                        MD_BLOG_CONTENTS+="$entry"
                fi
        done

        echo "$MD_BLOG_CONTENTS" > "$MD_SRC_FOLDER"/"$MD_BLOG_INDEX"
}
