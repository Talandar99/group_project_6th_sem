#!/bin/bash
psql -h localhost -p 5432 -U user -d db -f query.sql
#psql -h localhost -p 5432 -U user -d db -c 'select * from products;'


