#! /bin/bash

###
### Script for do SOLR querys from command line via REST API 
###

urlencode() {
    # urlencode <string>
    old_lc_collate=$LC_COLLATE
    LC_COLLATE=C

    local length="${#1}"
    for (( i = 0; i < length; i++ )); do
        local c="${1:i:1}"
        case $c in
            [a-zA-Z0-9.~_-]) printf "$c" ;;
            *) printf '%%%02X' "'$c" ;;
        esac
    done

    LC_COLLATE=$old_lc_collate
}

urldecode() {
    # urldecode <string>
    local url_encoded="${1//+/ }"
    printf '%b' "${url_encoded//%/\\x}"
}

# Usage functions
usage() { echo "Usage: $0 [-t <term>] [-c <collection-name>] [-l <field-list-fl>] [-q <field-query-fq>] [-r <query-type-qt>] [-h <solr-server>] [-p <solr-port>]" 1>&2; exit 1; }

# Command line options
while getopts "t:c:l:q:r:h:p" o; do
    case "${o}" in
        t)
            TERM=${OPTARG}
            ;;
        l)
            FL=${OPTARG}
            ;;
        q)
            FQ=${OPTARG}
            ;;
        r)
            QT=${OPTARG}
            ;;
        c)
            COLLECTION=${OPTARG}
            ;;
        h)
            SERVER=${OPTARG}
            ;;
        p)
            PORT=${OPTARG}
            ;;
        \?)
            echo "Invalid Option: -$OPTARG" 1>&2
            exit 1
            ;;
        *)
            usage
            ;;
    esac
done
shift $((OPTIND-1))

# Needs at least COLLECTION and TERM as parameters 
if [ -z "${COLLECTION}" ] || [ -z "${TERM}" ] ; then
    usage
fi

# Exports SERVER,PORT
#source ./exportENVARS.sh

# Default parameters
# Encode parameters (as blank spaces)
TERM=`urlencode "$TERM"`
#COLLECTION=${COLLECTION:-zylk}
FL=${FL:-"url,title,lang,score"}
FL=`urlencode $FL`
FQ=${FQ:-"*"}
QT=${QT:-select}
SERVER=${SERVER:-localhost}
PORT=${PORT:-8983}

# Main
NUMROWS=`curl -s "http://${SERVER}:${PORT}/solr/${COLLECTION}/${QT}?fq=$FQ&indent=on&q=${TERM}&wt=json" | jq '.response.numFound'`
#echo "Number of results for search: $1 --> $NUMROWS"
ROWS=10000
COUNT=0
START=0  
while [ $START -lt $NUMROWS ]; do
    # Only 10 results finally
    #curl -s "http://${SERVER}:${PORT}/solr/${COLLECTION}/${QT}?fl=$FL&indent=on&q=$TERM&rows=$ROWS&start=$START&wt=json" | jq '.response.docs[]'
    echo "curl -s \"http://${SERVER}:${PORT}/solr/${COLLECTION}/${QT}?fq=$FQ&fl=$FL&indent=on&q=$TERM&rows=10&start=$START&wt=json\""
    curl -s "http://${SERVER}:${PORT}/solr/${COLLECTION}/${QT}?fq=$FQ&fl=$FL&indent=on&q=$TERM&rows=10&start=$START&wt=json" | jq '.response.docs[]'
    COUNT=$((COUNT+1))
    START=$((ROWS*COUNT))
done
echo "Number of results for search: $1 --> $NUMROWS"
