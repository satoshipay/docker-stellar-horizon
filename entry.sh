#!/usr/bin/env bash

{ # try
    horizon_init_db
	echo "finished initializing horizon db"
} || { # catch
    # if horizon_init_db failed, that means that a db aleady exists which is fine.
	echo "horizon db already initialized. continuing on..."
}

horizon_init_db

function horizon_init_db() {
	horizon init db
}