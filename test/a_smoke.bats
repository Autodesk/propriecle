#!/usr/bin/env bats
# -*- mode: Shell-script;bash -*-
# happy path tests
load helper

setup() {
    use_fixture smoke
    start_vault
}

teardown() {
    stop_vault
}

@test "a happy path" {
    run_propriecle init local1
    run_propriecle unseal local1
    VAULT_TOKEN=$(propriecle root_get local1 2> /dev/null)
    export VAULT_TOKEN
    run vault mounts
    [ "$status" -eq 0 ]
    run_propriecle seal local1
    sleep 5 # wait for it
    run vault mounts
    [ "$status" -eq 2 ]
}

@test "root regeneration" {
    run_propriecle init local1
    run_propriecle unseal local1
    run_propriecle regenerate_start local1
    run_propriecle regenerate_auth local1
    VAULT_TOKEN=$(propriecle root_get local1 2> /dev/null)
    export VAULT_TOKEN
    run vault mounts
    [ "$status" -eq 0 ]    
}
