#!/usr/bin/env bash

set -o errexit
set -o pipefail

# Cloud provider does not set JDBC string but a different connection string format. 
# This function transforms it into the JDBC format.
# At the moment it's hard coded for PostgreSQL.
#
# ${1} a (PostgreSQL) connection string
# returns a JDBC string
getJDBCString() {
    declare -r CONNECTION_STRING=${1}
    declare -r PATTERN='^postgres://(.+):(.+)@(.+):([0-9]+)/(.+)$'
    
    if [[ ! "${CONNECTION_STRING}" =~ ${PATTERN} ]]; then
        echo "Connection string (${CONNECTION_STRING}) is not in expected format" 1>&2
        exit 1
    fi

    declare -r USERNAME=${BASH_REMATCH[1]}
    declare -r PASSWORD=${BASH_REMATCH[2]}
    declare -r HOST=${BASH_REMATCH[3]}
    declare -r PORT=${BASH_REMATCH[4]}
    declare -r DATABASE_NAME=${BASH_REMATCH[5]}

    echo "jdbc:postgresql://${HOST}:${PORT}/${DATABASE_NAME}?user=${USERNAME}&password=${PASSWORD}"
}

/app/mvnw -Dflyway.url="$(getJDBCString "${DATABASE_URL}")" flyway:migrate
