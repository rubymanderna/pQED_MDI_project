# Launch QM code 
/Users/rmandern/code/pQED_MDI_project/build/pQED -mdi "-role ENGINE -name QM -method TCP -port 8021 -hostname localhost" -in CQED_RHF.py > OCt1.out &

#Launch Driver
python mdi_driver.py -mdi "-role DRIVER -name AIMD -method TCP -port 8021" &

wait 