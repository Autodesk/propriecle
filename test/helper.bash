# -*- mode: Shell-script;bash -*-

export VAULT_LOG="${BATS_TMPDIR}/aomi-vault-log"

function start_vault() {
    if [ -e "${HOME}/.vault-token" ] ; then
        mv "${HOME}/.vault-token" "${BATS_TMPDIR}/og-token"
    fi
    nohup vault server -config "${FIXTURE_DIR}/vault.json" &
    if ! pgrep vault &> /dev/null ; then
        stop_vault
        start_vault
    else
        VAULT_PID=$(pgrep vault)
        export VAULT_PID
        export VAULT_ADDR='http://127.0.0.1:8200'
    fi
}

function stop_vault() {
    if [ -e "${BATS_TMPDIR}/og-token" ] ; then
        mv "${BATS_TMPDIR}/og-token" "${HOME}/.vault-token"
    fi
    if ps "$VAULT_PID" &> /dev/null ; then
        kill "$VAULT_PID"
    else
        echo "vault server went away"
        PID=$(pgrep vault || true)
        if [ ! -z "$PID" ] ; then
            kill "$(pgrep vault)"
        fi
    fi
    rm -f "$VAULT_LOG"
}

function use_fixture() {
    FIXTURE="$1"
    FIXTURE_DIR="${BATS_TMPDIR}/fixtures"
    mkdir -p "${FIXTURE_DIR}/keys"
    cp "${BATS_TEST_DIRNAME}/fixtures/${FIXTURE}/proprieclerc" "${FIXTURE_DIR}/"
    cp "${BATS_TEST_DIRNAME}/fixtures/${FIXTURE}/vault.json" "${FIXTURE_DIR}/"    
    export PROPRIECLE_DIRECTORY="${FIXTURE_DIR}/keys"
    export PROPRIECLE_CONFIG="${FIXTURE_DIR}/proprieclerc"
    
}    

function run_propriecle() {
    run coverage run -a --source "${CIDIR}/propriecle" "${CIDIR}/propriecle.py" $@
    echo "$output"
    [ "$status" -eq 0 ]
}
