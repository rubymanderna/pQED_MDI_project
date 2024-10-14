

#Launch Driver
python /repo/test/mdi_driver.py -mdi "-role DRIVER -name AIMD -method TCP -port 8021" &
echo "Hello, World!"

# Launch QM code 
/repo/build/pQED/CQED_RHF.py -mdi "-role ENGINE -name QM -method TCP -port 8021 -hostname localhost" -in CQED_RHF.py > OCt1.out &
echo "Hello Again, World!"

exit 