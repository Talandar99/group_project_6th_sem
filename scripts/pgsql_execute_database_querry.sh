#!/bin/bash
PGPASSWORD=password psql -h localhost -p 5432 -U user -d db -f database/query.sql
