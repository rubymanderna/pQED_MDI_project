# Import the MDI Library
import mdi
import argparse


#get command line arguments from argparse
parser = argparse.ArgumentParser(description= "MDI Driver")
parser.add_argument("-mdi", help="Flags for MDI", default=None, type=str)
args = parser.parse_args()
mdi_options = args.mdi

# Initialize MDI Library 
mdi.MDI_Init(mdi_options)

# connecting to the engine
engines = { 'QM': None}
comm = mdi.MDI_Accept_Communicator()  # This function Accept a communicator from the engine

# Get the name of the engine
mdi.MDI_Send_Command("<NAME" , comm)   # < sign means Driver requesting info from engine and > sign means engine requesting info from driver
name = mdi.MDI_Recv(mdi.MDI_NAME_LENGTH, mdi.MDI_CHAR, comm)  # Recv function is used to receive data from engine
print("Connected to Engine : " + str(name), flush=True)

engines[name] = comm

# Get the number of atoms from the engine
mdi.MDI_Send_Command("<NATOMS", engines['QM'])
natoms = mdi.MDI_Recv(1, mdi.MDI_INT, engines['QM'])

# Have the QM/MM engine to intialize a simulation
mdi.MDI_Send_Command("INIT", engines['QM'])
#mdi.MDI_Send_Command("@INIT_MD", engines['engine_name']) # @ sign is used to send command to engine at some particular point in the code called a node 

# Get the energy from the engine
mdi.MDI_Send_Command("<ENERGY", engines['QM'])
energy = mdi.MDI_Recv(1, mdi.MDI_DOUBLE, engines['QM']) # Receive the energy from the engine
print("Energy: " + str(energy), flush=True)


# Send the exit command to the engine
mdi.MDI_Send_Command("EXIT", comm)